// WoWCube.cpp : 定义应用程序的类行为。
//

#include "stdafx.h"
#include "WoWCube.h"
#include "WoWCubeDlg.h"
#include <Wininet.h>

#include "GlobalFunc.h"
#include "CustSite.h"


#ifdef _DEBUG
#define new DEBUG_NEW
#endif


CString m_TempPath;	//临时文件的目录
CString m_AppFileName;	//应用程序的路径和名称
//extern CString sSvnServer;

// CWoWCubeApp

BEGIN_MESSAGE_MAP(CWoWCubeApp, CWinAppEx)
	ON_COMMAND(ID_HELP, &CWinApp::OnHelp)
END_MESSAGE_MAP()


// CWoWCubeApp 构造

CWoWCubeApp::CWoWCubeApp()
{
	// TODO: 在此处添加构造代码，
	// 将所有重要的初始化放置在 InitInstance 中
}

CWoWCubeApp::~CWoWCubeApp()
{
	if ( m_pDispOM != NULL)
	{
		delete m_pDispOM;
	}
}


// 唯一的一个 CWoWCubeApp 对象

CWoWCubeApp theApp;


// CWoWCubeApp 初始化

BOOL CWoWCubeApp::InitInstance()
{
	// 如果一个运行在 Windows XP 上的应用程序清单指定要
	// 使用 ComCtl32.dll 版本 6 或更高版本来启用可视化方式，
	//则需要 InitCommonControlsEx()。否则，将无法创建窗口。
	INITCOMMONCONTROLSEX InitCtrls;
	InitCtrls.dwSize = sizeof(InitCtrls);
	// 将它设置为包括所有要在应用程序中使用的
	// 公共控件类。
	InitCtrls.dwICC = ICC_WIN95_CLASSES;
	InitCommonControlsEx(&InitCtrls);

	CWinAppEx::InitInstance();
	
	if (!AfxSocketInit())
	{
		AfxMessageBox(IDP_SOCKETS_INIT_FAILED);
		return FALSE;
	}

	// Create a custom control manager class so we can overide the site
	CCustomOccManager *pMgr = new CCustomOccManager;

	// Create an IDispatch class for extending the Dynamic HTML Object Model 
	m_pDispOM = new CImpIDispatch;

	// Set our control containment up but using our control container 
	// management class instead of MFC's default
	AfxEnableControlContainer(pMgr);
	
	//AfxEnableControlContainer();

	// 标准初始化
	// 如果未使用这些功能并希望减小
	// 最终可执行文件的大小，则应移除下列
	// 不需要的特定初始化例程
	// 更改用于存储设置的注册表项
	// TODO: 应适当修改该字符串，
	// 例如修改为公司或组织名
	//SetRegistryKey(_T("WoWCube"));

	TCHAR szPath[255];
	szPath[::GetModuleFileName(NULL, szPath, 255)]=0; //取得应用程序的名称
	m_AppFileName = szPath;
	szPath[::GetTempPath(255, szPath)]=0; //取得系统临时目录
	if (szPath[0]==0)
		m_TempPath = m_AppFileName.Left(m_AppFileName.ReverseFind('\\')+1);
	else
		m_TempPath = szPath;

	CWoWCubeDlg dlg;

	//检查网络状态
	if(!InternetGetConnectedState(NULL, 0))
	{
		AfxMessageBox(_T("请连接到Internet网络。"), MB_ICONSTOP|MB_OK);
		return FALSE;
	}
	/*
	if( !CheckMD5() )
		if(::AfxMessageBox(_T("该程序与月光官方发布的版本不符,为保证您的账户安全,请检查您的系统和修改密码,是否继续?"),MB_YESNO | MB_ICONQUESTION)==IDNO)
			return FALSE;
	*/

	if(!dlg.GetWoWPath())
	{
		AfxMessageBox(_T("无法找到魔兽世界游戏目录。"), MB_ICONSTOP|MB_OK);
		return FALSE;	//查找游戏目录
	}
	m_pMainWnd = &dlg;
	INT_PTR nResponse = dlg.DoModal();
	if (nResponse == IDOK)
	{
		// TODO: 在此放置处理何时用
		//  “确定”来关闭对话框的代码
	}
	else if (nResponse == IDCANCEL)
	{
		// TODO: 在此放置处理何时用
		//  “取消”来关闭对话框的代码
	}

	// 由于对话框已关闭，所以将返回 FALSE 以便退出应用程序，
	//  而不是启动应用程序的消息泵。
	return FALSE;
}
