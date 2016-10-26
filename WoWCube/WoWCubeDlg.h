
// WoWCubeDlg.h : 头文件
//

#pragma once
#include "afxcmn.h"
#include "afxwin.h"
#include "explorer_web.h"
#include "pictureex.h"

// CWoWCubeDlg 对话框
class CWoWCubeDlg : public CDialog
{
// 构造
public:
	bool GetWoWPath( void ); //取得游戏目录
	void GetInstallStatus( void ); //获得插件安装状态
	void CheckSum();
	int GetServerList( void );
	int SetServerList( void );
	int GetRealm( void );
	CWoWCubeDlg(CWnd* pParent = NULL);	// 标准构造函数

// 对话框数据
	enum { IDD = IDD_WOWCUBE_DIALOG };
	
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 支持

// 实现
protected:
	HICON m_hIcon;
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	// 生成的消息映射函数
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
