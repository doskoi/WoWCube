
// WoWCube.h : PROJECT_NAME 应用程序的主头文件
//

#pragma once

#ifndef __AFXWIN_H__
	#error "在包含此文件之前包含“stdafx.h”以生成 PCH 文件"
#endif

#include "resource.h"		// 主符号


// CWoWCubeApp:
// 有关此类的实现，请参阅 WoWCube.cpp
//

class CWoWCubeApp : public CWinAppEx
{
public:
	/*
	BOOL IsCloneExe(void);	//判断是否为重复进程
	BOOL CheckSum(void);	//验证程序完整性
	BOOL UpdateSelf(void);	//更新程序自身
	BOOL CheckUpdate();	//检测是否需要更新
	*/
	CWoWCubeApp();
	~CWoWCubeApp();
	class CImpIDispatch* m_pDispOM;

// 重写
	public:
	virtual BOOL InitInstance();

// 实现

	DECLARE_MESSAGE_MAP()

};

extern CWoWCubeApp theApp;