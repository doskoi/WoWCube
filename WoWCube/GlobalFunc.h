#pragma once

#pragma comment(lib,"Wininet.lib")
#pragma comment(lib,"version.lib")

#if !defined _GLOBALFUNC_H_
#define _GLOBALFUNC_H_
struct DownloadInfo
{
	CString url;
	CString filename;
	bool showinfo;
	int after;
};

struct VersionInfo
{
	CString Version;
	CString Sha1;
};

struct RealmInfo
{
	int idx;
	CString realm;
	CWnd *me;
};
#endif

bool IsFileExist(LPCTSTR sFilePath);
bool IsFolderExists(CString sPath);
CString GetFileVersion(LPCTSTR file);
UINT DownloadIt(LPVOID pDownload);
UINT CompareSha1(LPVOID pVer);
UINT UninstallApp(LPVOID param);
int InternetGetFile(CString szUrl, CString szFileName, bool showinfo);
int InternetGetFileToString(CString szUrl, CString& szMem);
BOOL TraverseDirectory(LPCTSTR lpszDirectory);
int ParseXml(CString szFile);
int RemoveUI( void );
int DownloadUI( void );
bool RecMakeDir(CString sPath);
int SearchRealm(CString sRealm);
UINT Echo(LPVOID parma);
UINT WatchRealmStatus(LPVOID pRealm);
