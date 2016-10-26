// WoWCube.cpp : ����Ӧ�ó��������Ϊ��
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


CString m_TempPath;	//��ʱ�ļ���Ŀ¼
CString m_AppFileName;	//Ӧ�ó����·��������
//extern CString sSvnServer;

// CWoWCubeApp

BEGIN_MESSAGE_MAP(CWoWCubeApp, CWinAppEx)
	ON_COMMAND(ID_HELP, &CWinApp::OnHelp)
END_MESSAGE_MAP()


// CWoWCubeApp ����

CWoWCubeApp::CWoWCubeApp()
{
	// TODO: �ڴ˴���ӹ�����룬
	// ��������Ҫ�ĳ�ʼ�������� InitInstance ��
}

CWoWCubeApp::~CWoWCubeApp()
{
	if ( m_pDispOM != NULL)
	{
		delete m_pDispOM;
	}
}


// Ψһ��һ�� CWoWCubeApp ����

CWoWCubeApp theApp;


// CWoWCubeApp ��ʼ��

BOOL CWoWCubeApp::InitInstance()
{
	// ���һ�������� Windows XP �ϵ�Ӧ�ó����嵥ָ��Ҫ
	// ʹ�� ComCtl32.dll �汾 6 ����߰汾�����ÿ��ӻ���ʽ��
	//����Ҫ InitCommonControlsEx()�����򣬽��޷��������ڡ�
	INITCOMMONCONTROLSEX InitCtrls;
	InitCtrls.dwSize = sizeof(InitCtrls);
	// ��������Ϊ��������Ҫ��Ӧ�ó�����ʹ�õ�
	// �����ؼ��ࡣ
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

	// ��׼��ʼ��
	// ���δʹ����Щ���ܲ�ϣ����С
	// ���տ�ִ���ļ��Ĵ�С����Ӧ�Ƴ�����
	// ����Ҫ���ض���ʼ������
	// �������ڴ洢���õ�ע�����
	// TODO: Ӧ�ʵ��޸ĸ��ַ�����
	// �����޸�Ϊ��˾����֯��
	//SetRegistryKey(_T("WoWCube"));

	TCHAR szPath[255];
	szPath[::GetModuleFileName(NULL, szPath, 255)]=0; //ȡ��Ӧ�ó��������
	m_AppFileName = szPath;
	szPath[::GetTempPath(255, szPath)]=0; //ȡ��ϵͳ��ʱĿ¼
	if (szPath[0]==0)
		m_TempPath = m_AppFileName.Left(m_AppFileName.ReverseFind('\\')+1);
	else
		m_TempPath = szPath;

	CWoWCubeDlg dlg;

	//�������״̬
	if(!InternetGetConnectedState(NULL, 0))
	{
		AfxMessageBox(_T("�����ӵ�Internet���硣"), MB_ICONSTOP|MB_OK);
		return FALSE;
	}
	/*
	if( !CheckMD5() )
		if(::AfxMessageBox(_T("�ó������¹�ٷ������İ汾����,Ϊ��֤�����˻���ȫ,��������ϵͳ���޸�����,�Ƿ����?"),MB_YESNO | MB_ICONQUESTION)==IDNO)
			return FALSE;
	*/

	if(!dlg.GetWoWPath())
	{
		AfxMessageBox(_T("�޷��ҵ�ħ��������ϷĿ¼��"), MB_ICONSTOP|MB_OK);
		return FALSE;	//������ϷĿ¼
	}
	m_pMainWnd = &dlg;
	INT_PTR nResponse = dlg.DoModal();
	if (nResponse == IDOK)
	{
		// TODO: �ڴ˷��ô����ʱ��
		//  ��ȷ�������رնԻ���Ĵ���
	}
	else if (nResponse == IDCANCEL)
	{
		// TODO: �ڴ˷��ô����ʱ��
		//  ��ȡ�������رնԻ���Ĵ���
	}

	// ���ڶԻ����ѹرգ����Խ����� FALSE �Ա��˳�Ӧ�ó���
	//  ����������Ӧ�ó������Ϣ�á�
	return FALSE;
}
