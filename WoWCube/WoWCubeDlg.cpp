// WoWCubeDlg.cpp : 实现文件
//
#include "stdafx.h"
#include "WoWCube.h"
#include "WoWCubeDlg.h"
#include "AutoUpdater.h"
#include "StdioFileEx.h"
#include "SHA1.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

CString m_sWoWPath; //魔兽世界目录
CString m_sWoWFile; //魔兽世界程序
CString strInterfacePath, strTempInterface;
extern CString m_TempPath;
extern CString m_AppFileName;
extern CString sSvnServer;
extern CStringArray addonList;
// CWoWCubeDlg 对话框

CWoWCubeDlg::CWoWCubeDlg(CWnd* pParent)
	: CDialog(CWoWCubeDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CWoWCubeDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_PROGRESS_DL, m_progress_dl);
	DDX_Control(pDX, IDC_PROGRESS_TOTAL, m_progress_total);
	DDX_Control(pDX, IDC_COMBO_SERVER, m_pServer);
	DDX_Control(pDX, IDC_EXPLORER_WEB, m_browser);
	DDX_Control(pDX, IDC_SERVER_ICON, m_Icon);
	DDX_Control(pDX, IDC_STATIC_NAME, m_Name);
}

BEGIN_MESSAGE_MAP(CWoWCubeDlg, CDialog)
	ON_WM_TIMER()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
	ON_BN_CLICKED(IDC_BUTTON_EXIT, &CWoWCubeDlg::OnBnClickedButtonExit)
	ON_BN_CLICKED(IDC_BUTTON_RUN, &CWoWCubeDlg::OnBnClickedButtonRun)
	ON_BN_CLICKED(IDC_BUTTON_UPDATE, &CWoWCubeDlg::OnBnClickedButtonUpdate)
	ON_BN_CLICKED(IDC_BUTTON_INSTALL, &CWoWCubeDlg::OnBnClickedButtonInstall)
	ON_BN_CLICKED(IDC_BUTTON_UNINSTALL, &CWoWCubeDlg::OnBnClickedButtonUninstall)
	ON_BN_CLICKED(IDC_BUTTON_MANAGE, &CWoWCubeDlg::OnBnClickedButtonManage)
	ON_BN_CLICKED(IDC_BUTTON_CXML, &CWoWCubeDlg::OnBnClickedButtonCxml)
	ON_CBN_SELCHANGE(IDC_COMBO_SERVER, &CWoWCubeDlg::OnCbnSelchangeComboServer)
	ON_STN_DBLCLK(IDC_SERVER_ICON, &CWoWCubeDlg::OnStnClickeServerIcon)
	ON_STN_DBLCLK(IDC_STATIC_NAME, &CWoWCubeDlg::OnStnClickeServerIcon)
	ON_STN_DBLCLK(IDC_STATIC_DELAY, &CWoWCubeDlg::OnStnClickStaticDelay)

END_MESSAGE_MAP()


BOOL CWoWCubeDlg::PreTranslateMessage(MSG* pMsg)
{
    if (NULL != m_pToolTip)
        m_pToolTip->RelayEvent(pMsg);

    return CDialog::PreTranslateMessage(pMsg);
}


// CWoWCubeDlg 消息处理程序

BOOL CWoWCubeDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// 设置此对话框的图标。当应用程序主窗口不是对话框时，框架将自动
	//  执行此操作
	SetIcon(m_hIcon, TRUE);			// 设置大图标
	SetIcon(m_hIcon, FALSE);		// 设置小图标

	// TODO: 在此添加额外的初始化代码
	SetDlgItemText(IDC_EDIT_WOWPATH, _T(""));
	SetDlgItemText(IDC_STATIC_DELAY, _T(""));
	SetDlgItemText(IDC_STATIC_TIP, _T("等待安装。"));
	SetDlgItemText(IDC_STATIC_NAME, _T(""));
	SetDlgItemText(IDC_STATIC_COPYRIGHT, _T(""));
	SetDlgItemText(IDC_STATIC_SHA1, _T(""));

	m_progress_dl.SetRange(0,100);
	m_progress_total.SetRange(0,100);

	GetInstallStatus();

	CString str = AfxGetApp()->m_lpCmdLine;
	if ( str == "-doskoi" ) {
		GetDlgItem(IDC_EDIT_WOWPATH)->ShowWindow(TRUE);
		GetDlgItem(IDC_EDIT_WOWPATH)->SetWindowText(m_sWoWPath+_T("Interface\\AddOns\\"));
		GetDlgItem(IDC_BUTTON_CXML)->ShowWindow(TRUE);
		SetDlgItemText(IDC_BUTTON_CXML, _T("Create XML"));
	}
	GetServerList();
	CheckSum();
	GetRealm();

	m_browser.Navigate(L"http://wowcube.cn/patcher", NULL, NULL, NULL, NULL);

	//Set up the tooltip
    m_pToolTip = new CToolTipCtrl;
    if(!m_pToolTip->Create(this))
	{
	   TRACE("Unable To create ToolTip\n");
	   return TRUE;
	}

	return TRUE;  // 除非将焦点设置到控件，否则返回 TRUE
}

void CWoWCubeDlg::OnTimer(UINT nIDEvent)
{
	switch (nIDEvent) {
		case 1:
			GetRealm();
			break;
		case 2:
			KillTimer(2);
			::AfxBeginThread(CheckForUpdate, (LPVOID)NULL );
			break;
	}

	CDialog::OnTimer(nIDEvent);
}

// 如果向对话框添加最小化按钮，则需要下面的代码
//  来绘制该图标。对于使用文档/视图模型的 MFC 应用程序，
//  这将由框架自动完成。

void CWoWCubeDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 用于绘制的设备上下文

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// 使图标在工作区矩形中居中
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// 绘制图标
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

//当用户拖动最小化窗口时系统调用此函数取得光标
//显示。
HCURSOR CWoWCubeDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}

void CWoWCubeDlg::OnDestroy()
{
	CDialog::OnDestroy();

	// TODO: 在此处添加消息处理程序代码
}

bool CWoWCubeDlg::GetWoWPath()
{
	bool bFind = false;
	HKEY key = HKEY_LOCAL_MACHINE;
	LPCTSTR subkey = _T("SOFTWARE\\Blizzard Entertainment\\World of Warcraft"); 
	LONG res = RegOpenKeyEx(key, subkey, 0, KEY_READ, &key);
	if ( res == ERROR_SUCCESS )
	{
		char sz[256];
		DWORD dwtype, sl = 256;
		res = RegQueryValueEx(key, _T("InstallPath"), NULL, &dwtype, (LPBYTE)sz, &sl);
		if ( res == ERROR_SUCCESS )
		{
			m_sWoWPath = (LPCTSTR)sz;
			m_sWoWFile = m_sWoWPath + _T("WoW.exe");
			if (IsFileExist((LPCTSTR)m_sWoWFile))
				bFind = true;
			else
				m_sWoWPath.Empty();
		}
	}
	RegCloseKey(key);
	if ( m_sWoWPath.IsEmpty() )
	{
			CFileDialog fDLG(true,NULL,_T("WoW.exe"),OFN_FILEMUSTEXIST,_T("魔兽世界执行程序|*.exe||"));
			fDLG.m_ofn.lpstrTitle =(_T("请指定魔兽世界的执行程序"));
			if(fDLG.DoModal()==IDOK)
			{
				m_sWoWFile = fDLG.GetPathName();
				m_sWoWPath = m_sWoWFile.Left(m_sWoWFile.ReverseFind('\\'));
				if ( m_sWoWPath.Right(1)!="\\" ) m_sWoWPath += '\\';
				bFind=true;				
			}
	}

	strInterfacePath = m_sWoWPath + _T("Interface\\");

	return bFind;
}
void CWoWCubeDlg::GetInstallStatus( void )
{
	HKEY key = HKEY_LOCAL_MACHINE;
	LPCTSTR subkey = _T("SOFTWARE\\Asura Software\\WoWCube Patcher"); 
	LONG res = RegOpenKeyEx(key, subkey, 0, KEY_READ, &key);
	if ( res == ERROR_SUCCESS )
	{
		char sz[256];
		DWORD dwtype, sl = 256;
		res = RegQueryValueEx(key, _T("WoWCube Installed"), NULL, &dwtype, (LPBYTE)sz, &sl);
		if ( res == ERROR_SUCCESS )
		{
			GetDlgItem(IDC_BUTTON_UPDATE)->ShowWindow(TRUE);
			GetDlgItem(IDC_BUTTON_INSTALL)->ShowWindow(FALSE);
			GetDlgItem(IDC_BUTTON_UNINSTALL)->EnableWindow(TRUE);
			SetDlgItemText(IDC_STATIC_TIP, _T("等待进行更新。"));
			SetTimer(2, 10000, NULL);
		}
	}
	RegCloseKey(key);
}

void CWoWCubeDlg::CheckSum()
{
	CString strVer = GetFileVersion(m_AppFileName);
	SetDlgItemText(IDC_STATIC_COPYRIGHT, _T("WoWCube.cn ver:") + strVer);

	char szReport[1024];
	bool bSuccess = false;
	CSHA1 sha1;
	szReport[0] = 0;
	bSuccess = sha1.HashFile(m_AppFileName);
	sha1.Final();
	sha1.ReportHash(szReport, CSHA1::REPORT_HEX);

	if(bSuccess == true) {
		//TRACE(szReport);
		SetDlgItemText(IDC_STATIC_SHA1, _T("SHA1:") + (CString)szReport);
		VersionInfo *pVer = new VersionInfo;
		pVer->Version = strVer;
		pVer->Sha1 = (CString)szReport;
		AfxBeginThread(CompareSha1, (LPVOID)pVer);
	}
}

int CWoWCubeDlg::GetRealm( void )
{
	if ( this->IsIconic() ) return 0;
	this->SetTimer(1 ,60000, NULL);

	if ( m_Icon.Load(MAKEINTRESOURCE(IDR_GIFLOAD), _T("GIF")) )
	{
		m_Icon.SetBkColor(m_Icon.GetBkColor());
		m_Icon.Draw();
	}

	static int idx;
	static CString realm;
	if ( idx == 0 )
	{
		CStdioFileEx file;
		file.SetCodePage(CP_UTF8);
		if (file.Open(m_sWoWPath + _T("WTF\\Config.wtf"), CFile::modeRead | CFile::typeText )) {
			CString buffer;
			while(file.ReadString(buffer))
			{
				if ( buffer.Find(_T("realmName"))!=-1 ) {
					int i = buffer.Find('"') + 1;
					int j = buffer.GetLength() - i - 1;
					CString sRealm = buffer.Mid(i, j);
					SetDlgItemText(IDC_STATIC_NAME, sRealm);
					realm = sRealm;
					idx = SearchRealm(sRealm);
					break;
				}
			}
			file.Close();
		} else {
			m_Icon.UnLoad();
			return -1;
		}
	}

	if ( idx != 0 )
	{
		RealmInfo *pRealm = new RealmInfo;
		pRealm->idx = idx;
		pRealm->realm = realm;
		pRealm->me = this;
		AfxBeginThread( WatchRealmStatus, (LPVOID)pRealm );
	} else {
		GetDlgItem(IDC_STATIC_NAME)->EnableWindow(FALSE);
		if ( m_Icon.Load(MAKEINTRESOURCE(IDR_GIFFAIL), _T("GIF")) )
		{
			m_Icon.SetBkColor(m_Icon.GetBkColor());
			m_Icon.Draw();
		}
	}

	return 0;
}

int CWoWCubeDlg::GetServerList( void )
{
	/* 下载游戏服务器列表 */
	if ( m_sWoWPath != "" ) {
		CString lpUrl = _T("http://launcher.wowchina.com/wowlauncher/launcher.config");
		CString lpFile = m_sWoWPath + "launcher.config";

		if (InternetGetFile(lpUrl, lpFile, false) == 0)
			if ( SetServerList() == 0 )
				//Echo((LPCTSTR)WoWServers.GetAt(m_pServer.GetCurSel()));
				AfxBeginThread(Echo, (LPVOID)(LPCTSTR)WoWServers.GetAt(m_pServer.GetCurSel()));

	}
	return 0;
}


int CWoWCubeDlg::SetServerList( void )
{
	//CStdioFile file;  //CStdio has a big bugs in unicode 'n CJK
	CStdioFileEx file;
	if (file.Open(m_sWoWPath + _T("launcher.config"), CFile::modeRead | CFile::typeText )) {
		CString buffer;
		//CComboBox *pServer=(CComboBox*)this->GetDlgItem(IDC_COMBO_SERVER);
		m_pServer.ResetContent();
		while(file.ReadString(buffer))
		{
			if ( buffer.Find(_T("com"))!=-1 ) {
				int i = buffer.Find(',');

				m_pServer.AddString( buffer.Left(i).Trim() );
				i++;
				int j = buffer.Find(',', i);
				WoWServers.Add(buffer.Mid(i, j-i));
			}
		}
		file.Close();
		if (m_pServer.GetCount()>0)m_pServer.SetCurSel(0);

		m_pServer.AddString(_T("臺灣伺服器"));
		m_pServer.AddString(_T("US Server"));
		m_pServer.AddString(_T("Europe Server"));
		m_pServer.AddString(_T("한국 서버"));

		WoWServers.Add(_T("tw.logon.worldofwarcraft.com"));
		WoWServers.Add(_T("us.logon.worldofwarcraft.com"));
		WoWServers.Add(_T("eu.logon.worldofwarcraft.com"));
		WoWServers.Add(_T("kr.logon.worldofwarcraft.com"));
	} else {
		return -1;
	}

	HKEY key = HKEY_LOCAL_MACHINE;
	LPCTSTR subkey = _T("SOFTWARE\\Asura Software\\WoWCube Patcher"); 
	LONG res = RegOpenKeyEx(key, subkey, 0, KEY_READ, &key);
	if ( res == ERROR_SUCCESS )
	{
		char sz[256];
		DWORD dwtype, sl = 256;
		res = RegQueryValueEx(key, _T("Game Server"), NULL, &dwtype, (LPBYTE)sz, &sl);
		if ( res == ERROR_SUCCESS )
		{
			m_pServer.SetCurSel(atoi(sz));
		} else {
			return -1;
		}
	}
	RegCloseKey(key);

	return 0;
}

//Exit
void CWoWCubeDlg::OnBnClickedButtonExit()
{
	OnCancel();
}

void CWoWCubeDlg::OnBnClickedButtonRun()
{/*
	CStringA strA(m_sWoWFile);
	LPCSTR lpWoW = strA;
	WinExec( lpWoW, SW_SHOW );
*/
	// amazing it will be *virus* after Aspack scan by NOD32
	//AfxGetApp()->GetMainWnd()->ShowWindow(SW_MINIMIZE);			//way 1
	::ShowWindow(this->m_hWnd, SW_MINIMIZE);					//way 2
	

    STARTUPINFO si;
    PROCESS_INFORMATION pi;

    ZeroMemory( &si, sizeof(si) );
    si.cb = sizeof(si);
    ZeroMemory( &pi, sizeof(pi) );

	CreateProcess( NULL,   // No module name (use command line)
        (LPTSTR)(LPCTSTR)m_sWoWFile,        // Command line
        NULL,           // Process handle not inheritable
        NULL,           // Thread handle not inheritable
        FALSE,          // Set handle inheritance to FALSE
        0,              // No creation flags
        NULL,           // Use parent's environment block
        NULL,           // Use parent's starting directory 
        &si,            // Pointer to STARTUPINFO structure
        &pi );           // Pointer to PROCESS_INFORMATION structure

/*
   // Wait until child process exits.
    WaitForSingleObject( pi.hProcess, INFINITE );

    // Close process and thread handles. 
    CloseHandle( pi.hProcess );
    CloseHandle( pi.hThread );
*/
}

void CWoWCubeDlg::OnBnClickedButtonUpdate()
{
	strTempInterface = m_TempPath + _T("WoWCube\\Interface\\");

	m_progress_dl.SetPos(0);
	m_progress_total.SetPos(0);
	SetDlgItemText(IDC_STATIC_TIP, _T("正在准备更新..."));
	//GetDlgItem(IDC_BUTTON_UPDATE)->EnableWindow(FALSE);

	CString lpUrl = sSvnServer + _T("/trunk/filelist.xml");
/*
	int idx = lpUrl.ReverseFind('/');
	CString lpFile = lpUrl.Mid(idx + 1, lpUrl.GetLength());
	lpFile = m_TempPath + lpFileName;
*/
	CString lpFile = m_TempPath + _T("filelist.xml");

	DownloadInfo *pDownload = new DownloadInfo;
	pDownload->url = lpUrl;
	pDownload->filename = lpFile;
	pDownload->showinfo = true;
	pDownload->after = 1;
	/*
	//WaitForSingleObject 和线程里的SendMessage修改UI会造成死锁
	CWinThread* pThread;
	pThread = AfxBeginThread(
					DownloadIt,
					(LPVOID)pDownload,
					THREAD_PRIORITY_NORMAL,
					0,
					CREATE_SUSPENDED
				);
	assert(pThread);
	pThread->m_bAutoDelete = FALSE;
	pThread->ResumeThread();
	
	WaitForSingleObject(pThread->m_hThread, INFINITE);
	delete pThread;
	*/
	AfxBeginThread(DownloadIt, (LPVOID)pDownload);
	//GetDlgItem(IDC_BUTTON_UPDATE)->EnableWindow(TRUE);
}

void CWoWCubeDlg::OnBnClickedButtonInstall()
{
	HKEY key = HKEY_LOCAL_MACHINE;
	LPCTSTR subkey = _T("SOFTWARE\\Asura Software\\WoWCube Patcher"); 
	LONG res = RegCreateKeyEx(key, subkey, 0, NULL, REG_OPTION_NON_VOLATILE, KEY_WRITE, NULL, &key, NULL);
	if ( res == ERROR_SUCCESS )
	{
		wchar_t *newValue = _T("ok");
		res = RegSetValueEx(key, _T("WoWCube Installed"), NULL, REG_SZ, (LPBYTE)newValue, sizeof(LPBYTE));
		if ( res == ERROR_SUCCESS )
		{
			GetDlgItem(IDC_BUTTON_UPDATE)->EnableWindow(TRUE);
			GetDlgItem(IDC_BUTTON_UPDATE)->ShowWindow(TRUE);
			GetDlgItem(IDC_BUTTON_INSTALL)->ShowWindow(FALSE);
			GetDlgItem(IDC_BUTTON_UNINSTALL)->EnableWindow(TRUE);
		}
		int i = m_pServer.GetCurSel();
		char str[12];
		sprintf_s(str, "%d", i);
		res = RegSetValueEx(key, _T("Game Server"), NULL, REG_SZ, (BYTE *)str, strlen(str)+1);
	}
	RegCloseKey(key);

	SetDlgItemText(IDC_STATIC_TIP, _T("安装完成,等待进行更新。"));
	//AfxMessageBox(_T("安装完成,感谢使用 WoWCube Patcher\n如果在使用的过程中有任何意见或建议\n请与我们取得联系:\n\nhttp://wowcube.cn。"), MB_ICONINFORMATION|MB_OK);
}

void CWoWCubeDlg::OnBnClickedButtonUninstall()
{
	GetDlgItem(IDC_BUTTON_UPDATE)->EnableWindow(FALSE);
	GetDlgItem(IDC_BUTTON_EXIT)->EnableWindow(FALSE);
	HKEY key = HKEY_LOCAL_MACHINE;
	LPCTSTR subkey = _T("SOFTWARE\\Asura Software\\WoWCube Patcher"); 
	LONG res = RegDeleteKey(key, subkey);
	if ( res == ERROR_SUCCESS )
	{/*
		GetDlgItem(IDC_BUTTON_UPDATE)->ShowWindow(FALSE);
		GetDlgItem(IDC_BUTTON_INSTALL)->ShowWindow(TRUE);
		GetDlgItem(IDC_BUTTON_UNINSTALL)->EnableWindow(FALSE);
	*/}
	RegCloseKey(key);
	SetDlgItemText(IDC_STATIC_TIP, _T("卸载中,可能需要花费一点时间,请耐心等候..."));

	addonList.RemoveAll();
	CWinThread *pThread;
	pThread = AfxBeginThread(UninstallApp, (LPVOID)NULL);
}

void CWoWCubeDlg::OnBnClickedButtonManage()
{
//
}

void CWoWCubeDlg::OnBnClickedButtonCxml()
{
	//TraverseDirectory(m_sWoWPath + _T("Interface\\AddOns"));
	CString sDir;
	GetDlgItem(IDC_EDIT_WOWPATH)->GetWindowText(sDir);
	TraverseDirectory(sDir);
}

void CWoWCubeDlg::OnCbnSelchangeComboServer()
{
	CStdioFileEx file;
	if( file.Open( m_sWoWPath+"realmlist.wtf", CFile::modeCreate | CFile::modeReadWrite | CFile::typeText) )
	{
		CString text(_T("SET realmlist \""));
		text += WoWServers.GetAt(m_pServer.GetCurSel());
		text += _T("\"");
		file.WriteString(text);
		file.Flush();
		file.Close();
	}

	HKEY key = HKEY_LOCAL_MACHINE;
	LPCTSTR subkey = _T("SOFTWARE\\Asura Software\\WoWCube Patcher"); 
	//LONG res = RegOpenKeyEx(key, subkey, 0, KEY_READ, &key);
	LONG res = RegCreateKeyEx(key, subkey, 0, NULL, REG_OPTION_NON_VOLATILE, KEY_WRITE, NULL, &key, NULL);
	if ( res == ERROR_SUCCESS )
	{	
		int i = m_pServer.GetCurSel();
		char str[12];
		sprintf_s(str, "%d", i);
		res = RegSetValueEx(key, _T("Game Server"), NULL, REG_SZ, (BYTE *)str, strlen(str)+1);
	}
	RegCloseKey(key);

	AfxBeginThread(Echo, (LPVOID)(LPCTSTR)WoWServers.GetAt(m_pServer.GetCurSel()));
}

void CWoWCubeDlg::OnStnClickeServerIcon()
{
	GetRealm();	
}

void CWoWCubeDlg::OnStnClickStaticDelay()
{
	AfxBeginThread(Echo, (LPVOID)(LPCTSTR)WoWServers.GetAt(m_pServer.GetCurSel()));
}

BEGIN_EVENTSINK_MAP(CWoWCubeDlg, CDialog)
	ON_EVENT(CWoWCubeDlg, IDC_EXPLORER_WEB, 259, CWoWCubeDlg::DocumentCompleteExplorerWeb, VTS_DISPATCH VTS_PVARIANT)
END_EVENTSINK_MAP()

void CWoWCubeDlg::DocumentCompleteExplorerWeb(LPDISPATCH pDisp, VARIANT* URL)
{
	//GetDlgItem(IDC_EXPLORER_WEB)->AnimateWindow(500, AW_BLEND );
}
