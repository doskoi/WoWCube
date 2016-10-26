// AutoUpdater.cpp: implementation of the CAutoUpdater class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "AutoUpdater.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

#define TRANSFER_SIZE 4096
HINTERNET hInternet;
CString sAppServer = _T("http://17cube.googlecode.com/svn");	//"http://wowcube.googlecode.com/svn"
/*
CAutoUpdater::CAutoUpdater()
{
	// Initialize WinInet
	hInternet = InternetOpen(_T("WoWCubeUpdateAgent"), INTERNET_OPEN_TYPE_PRECONFIG, NULL, NULL, 0);	
}

CAutoUpdater::~CAutoUpdater()
{
	if (hInternet) {
		InternetCloseHandle(hInternet);
	}
}
*/
// Check if an update is required
//
UINT CheckForUpdate( LPVOID param )
{
	CString UpdateServerURL = sAppServer + _T("/tags/");

	hInternet = InternetOpen(_T("WoWCubeUpdateAgent"), INTERNET_OPEN_TYPE_PRECONFIG, NULL, NULL, 0);	

	if (!InternetOkay())
	{
		return InternetConnectFailure;
	}

	bool bTransferSuccess = false;

	// First we must check the remote configuration file to see if an update is necessary
	CString URL = UpdateServerURL + CString(LOCATION_UPDATE_FILE_CHECK);
	HINTERNET hSession = GetSession(URL);
	if (!hSession)
	{
		if (hInternet) {
			InternetCloseHandle(hInternet);
		}
		return InternetSessionFailure;
	}

	DWORD dwIndex = 0,	dwCodeLen = 10;
	char dwcode[20];
	HttpQueryInfo(hSession, HTTP_QUERY_STATUS_CODE, &dwcode, &dwCodeLen, &dwIndex);
	CString strErr;
	strErr.Format(_T("%s"), dwcode);
	if(strErr.Find(_T("404"))!=-1)
	{
		if (hInternet) {
			InternetCloseHandle(hInternet);
		}
		InternetCloseHandle(hSession);
		return FileNotFound;
	}

	BYTE pBuf[TRANSFER_SIZE];

	memset(pBuf, NULL, sizeof(pBuf));
	bTransferSuccess = DownloadConfig(hSession, pBuf, TRANSFER_SIZE);
	InternetCloseHandle(hSession);
	if (!bTransferSuccess)
	{
		if (hInternet) {
			InternetCloseHandle(hInternet);
		}
		return ConfigDownloadFailure;
	}

	// Get the version number of our executable and compare to see if an update is needed
	CString executable = GetExecutable();
	CString fileVersion = GetFileVersion(executable);
	if (fileVersion.IsEmpty())
	{
		if (hInternet) {
			InternetCloseHandle(hInternet);
		}
		return NoExecutableVersion;
	}

	CString updateVersion((char *)pBuf);
	if (CompareVersions(updateVersion, fileVersion) != 1)
	{	
		if (hInternet) {
			InternetCloseHandle(hInternet);
		}
		return UpdateNotRequired;
	}

	// At this stage an update is required	
	TCHAR path[MAX_PATH];
	GetTempPath(MAX_PATH, path);
	CString exeName = executable.Mid(1+executable.ReverseFind(_T('\\')));
	CString directory = path;
	
	// Download the updated file
	URL = UpdateServerURL + updateVersion + _T("/") + exeName;
	hSession = GetSession(URL);
	if (!hSession)
	{
		if (hInternet) {
			InternetCloseHandle(hInternet);
		}
		return InternetSessionFailure;
	}

	CString msg;
	//msg.Format(_T("An update of %s is now available. Proceed with the update?"), exeName);
	msg.Format(_T("发现新版本WoWCube Patcher %s，下载更新?"), updateVersion);
	if (IDNO == MessageBox(GetActiveWindow(), msg, _T("WoWCube Patcher 升级提示"), MB_ICONQUESTION|MB_YESNO))
	{
		if (hInternet) {
			InternetCloseHandle(hInternet);
		}
		return UpdateNotComplete;	
	}

	// Proceed with the update
	CString updateFileLocation = directory+exeName;
	//InternetGetFile(URL, updateFileLocation, false);
	bTransferSuccess = DownloadFile(hSession, updateFileLocation);

	InternetCloseHandle(hSession);
	if (!bTransferSuccess)
	{
		if (hInternet) {
			InternetCloseHandle(hInternet);
		}
		return FileDownloadFailure;
	}

	if (CompareVersions(updateVersion, GetFileVersion(updateFileLocation)) != 0)
	{	
		if (hInternet) {
			InternetCloseHandle(hInternet);
		}
		return UpdateNotComplete;
	}

	if (!Switch(executable, updateFileLocation, false))
	{
		if (hInternet) {
			InternetCloseHandle(hInternet);
		}
		return UpdateNotComplete;
	}

	MessageBox(GetActiveWindow(), _T("更新下载完成，下次运行时将会启用。"), _T("WoWCube Patcher 升级提示"), MB_ICONINFORMATION|MB_OK);

	if (hInternet) {
		InternetCloseHandle(hInternet);
	}
	
	return Success;
}

// Ensure the internet is ok to use
//
bool InternetOkay()
{
	if (hInternet == NULL) {
		return false;
	}

	// Important step - ensure we have an internet connection. We don't want to force a dial-up.
	DWORD dwType;
	if (!InternetGetConnectedState(&dwType, 0))
	{
		return false;
	}

	return true;
}

// Get a session pointer to the remote file
//
HINTERNET GetSession(CString &URL)
{
	// Canonicalization of the URL converts unsafe characters into escape character equivalents
	TCHAR canonicalURL[1024];
	DWORD nSize = 1024;
	InternetCanonicalizeUrl(URL, canonicalURL, &nSize, ICU_BROWSER_MODE);		
	
	DWORD options = INTERNET_FLAG_NEED_FILE|INTERNET_FLAG_HYPERLINK|INTERNET_FLAG_RESYNCHRONIZE|INTERNET_FLAG_RELOAD;
	HINTERNET hSession = InternetOpenUrl(hInternet, canonicalURL, NULL, NULL, options, 0);
	URL = canonicalURL;

	return hSession;
}

// Download a file into a memory buffer
//
bool DownloadConfig(HINTERNET hSession, BYTE *pBuf, DWORD bufSize)
{	
	DWORD	dwReadSizeOut;
	InternetReadFile(hSession, pBuf, bufSize, &dwReadSizeOut);
	if (dwReadSizeOut <= 0)
	{
		return false;
	}

	
	return true;
}

// Download a file to a specified location
//
bool DownloadFile(HINTERNET hSession, LPCTSTR localFile)
{	
	HANDLE	hFile;
	BYTE	pBuf[TRANSFER_SIZE];
	DWORD	dwReadSizeOut, dwTotalReadSize = 0;

	hFile = CreateFile(localFile, GENERIC_WRITE, FILE_SHARE_READ|FILE_SHARE_WRITE, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
	if (hFile == INVALID_HANDLE_VALUE) return false;

	do {
		DWORD dwWriteSize, dwNumWritten;
		BOOL bRead = InternetReadFile(hSession, pBuf, TRANSFER_SIZE, &dwReadSizeOut);
		dwWriteSize = dwReadSizeOut;

		DWORD dwIndex = 0,	dwCodeLen = 10;
		char dwcode[20];
		HttpQueryInfo(hSession, HTTP_QUERY_STATUS_CODE, &dwcode, &dwCodeLen, &dwIndex);
		CString strErr;
		strErr.Format(_T("%s"), dwcode);
		if(strErr.Find(_T("404"))!=-1)
		{
			InternetCloseHandle(hSession);
			CloseHandle(hFile);
			return false;
		}

		if (bRead && dwReadSizeOut > 0) {
			dwTotalReadSize += dwReadSizeOut;
			WriteFile(hFile, pBuf, dwWriteSize, &dwNumWritten, NULL); 
			// File write error
			if (dwWriteSize != dwNumWritten) {
				CloseHandle(hFile);					
				return false;
			}
		}
		else {
			if (!bRead)
			{
				// Error
				CloseHandle(hFile);	
				return false;
			}			
			break;
		}
	} while(1);

	CloseHandle(hFile);
	return true;
}

// Get the version of a file
//
/*
CString GetFileVersion(LPCTSTR file)
{
	CString version;
	VS_FIXEDFILEINFO *pVerInfo = NULL;
	DWORD	dwTemp, dwSize, dwHandle = 0;
	BYTE	*pData = NULL;
	UINT	uLen;

	try {
		dwSize = GetFileVersionInfoSize((LPTSTR) file, &dwTemp);
		if (dwSize == 0) throw 1;

		pData = new BYTE[dwSize];
		if (pData == NULL) throw 1;

		if (!GetFileVersionInfo((LPTSTR) file, dwHandle, dwSize, pData))
			throw 1;

		if (!VerQueryValue(pData, _T("\\"), (void **) &pVerInfo, &uLen)) 
			throw 1;

		DWORD verMS = pVerInfo->dwFileVersionMS;
		DWORD verLS = pVerInfo->dwFileVersionLS;

		int ver[4];
		ver[0] = HIWORD(verMS);
		ver[1] = LOWORD(verMS);
		ver[2] = HIWORD(verLS);
		ver[3] = LOWORD(verLS);

		// Are lo-words used?
		if (ver[2] != 0 || ver[3] != 0)
		{
			version.Format(_T("%d.%d.%d.%d"), ver[0], ver[1], ver[2], ver[3]);
		}
		else if (ver[0] != 0 || ver[1] != 0)
		{
			version.Format(_T("%d.%d"), ver[0], ver[1]);
		}

		delete pData;
		return version;
	}
	catch(...) {
		return _T("");
	}	
}
*/
// Compare two versions 
//
int CompareVersions(CString ver1, CString ver2)
{
	int  wVer1[4], wVer2[4];
	int	 i;
	TCHAR *pVer1 = ver1.GetBuffer(256);
	TCHAR *pVer2 = ver2.GetBuffer(256);

	for (i=0; i<4; i++)
	{
		wVer1[i] = 0;
		wVer2[i] = 0;
	}

	// Get version 1 to DWORDs
	wchar_t *pToken = wcstok(pVer1, _T("."));
	if (pToken == NULL)
	{
		return -21;
	}

	i=3;
	while(pToken != NULL)
	{
		if (i<0 || !IsDigits(pToken)) 
		{			
			return -21;	// Error in structure, too many parameters
		}		
		wVer1[i] = _wtoi(pToken);
		pToken = wcstok(NULL, _T("."));
		i--;
	}
	ver1.ReleaseBuffer();

	// Get version 2 to DWORDs
	pToken = wcstok(pVer2, _T("."));
	if (pToken == NULL)
	{
		return -22;
	}

	i=3;
	while(pToken != NULL)
	{
		if (i<0 || !IsDigits(pToken)) 
		{
			return -22;	// Error in structure, too many parameters
		}		
		wVer2[i] = _wtoi(pToken);
		pToken = wcstok(NULL, _T("."));
		i--;
	}
	ver2.ReleaseBuffer();

	// Compare the versions
	for (i=3; i>=0; i--)
	{
		if (wVer1[i] > wVer2[i])
		{
			return 1;		// ver1 > ver 2
		}
		else if (wVer1[i] < wVer2[i])
		{
			return -1;
		}
	}

	return 0;	// ver 1 == ver 2
}

// Ensure a string contains only digit characters
//
bool IsDigits(CString text)
{
	for (int i=0; i<text.GetLength(); i++)
	{
		TCHAR c = text.GetAt(i);
		if (c >= _T('0') && c <= _T('9'))
		{
		}
		else
		{
			return false;
		}
	}

	return true;
}

CString GetExecutable()
{
	HMODULE hModule = ::GetModuleHandle(NULL);
    ASSERT(hModule != 0);
    
    TCHAR path[MAX_PATH];
    VERIFY(::GetModuleFileName(hModule, path, MAX_PATH));
    return path;
}

bool Switch(CString executable, CString update, bool WaitForReboot)
{
	int type = (WaitForReboot) ? MOVEFILE_DELAY_UNTIL_REBOOT : MOVEFILE_COPY_ALLOWED;

	const TCHAR *backup = _T("WoWCube.old");
	CString directory = executable.Left(executable.ReverseFind(_T('\\')));	
	CString backupFile = directory + _T('\\') + CString(backup);

	DeleteFile(backupFile);
	if (!MoveFileEx(executable, backupFile, type)) 
	{
		return false;
	}


	bool bMoveOK = (MoveFileEx(update, executable, type) == TRUE);
	int i = GetLastError();

	return bMoveOK;	
}