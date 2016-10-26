
// WoWCubeDlg.h : ͷ�ļ�
//

#pragma once
#include "afxcmn.h"
#include "afxwin.h"
#include "explorer_web.h"
#include "pictureex.h"

// CWoWCubeDlg �Ի���
class CWoWCubeDlg : public CDialog
{
// ����
public:
	bool GetWoWPath( void ); //ȡ����ϷĿ¼
	void GetInstallStatus( void ); //��ò����װ״̬
	void CheckSum();
	int GetServerList( void );
	int SetServerList( void );
	int GetRealm( void );
	CWoWCubeDlg(CWnd* pParent = NULL);	// ��׼���캯��

// �Ի�������
	enum { IDD = IDD_WOWCUBE_DIALOG };
	
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV ֧��

// ʵ��
protected:
	HICON m_hIcon;
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	// ���ɵ���Ϣӳ�亯��
	virtual BOOL OnInitDialog();
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnDestroy();
	DECLARE_MESSAGE_MAP()

public:
	CToolTipCtrl* m_pToolTip;
	CStringArray WoWServers;
public:
	afx_msg void OnBnClickedButtonExit();
	afx_msg void OnBnClickedButtonRun();
	afx_msg void OnBnClickedButtonUpdate();
	afx_msg void OnBnClickedButtonInstall();
	afx_msg void OnBnClickedButtonUninstall();
	afx_msg void OnBnClickedButtonManage();
	afx_msg void OnBnClickedButtonCxml();
	afx_msg void OnCbnSelchangeComboServer();
	afx_msg void OnStnClickeServerIcon();
	afx_msg void OnStnClickStaticDelay();
	CProgressCtrl m_progress_dl;
	CProgressCtrl m_progress_total;
	CComboBox m_pServer;
	CWebBrowser2 m_browser;
	CPictureEx m_Icon;
	CStatic m_Name;
	DECLARE_EVENTSINK_MAP()
	void DocumentCompleteExplorerWeb(LPDISPATCH pDisp, VARIANT* URL);
};
