
// WoWCube.h : PROJECT_NAME Ӧ�ó������ͷ�ļ�
//

#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"		// ������


// CWoWCubeApp:
// �йش����ʵ�֣������ WoWCube.cpp
//

class CWoWCubeApp : public CWinAppEx
{
public:
	/*
	BOOL IsCloneExe(void);	//�ж��Ƿ�Ϊ�ظ�����
	BOOL CheckSum(void);	//��֤����������
	BOOL UpdateSelf(void);	//���³�������
	BOOL CheckUpdate();	//����Ƿ���Ҫ����
	*/
	CWoWCubeApp();
	~CWoWCubeApp();
	class CImpIDispatch* m_pDispOM;

// ��д
	public:
	virtual BOOL InitInstance();

// ʵ��

	DECLARE_MESSAGE_MAP()

};

extern CWoWCubeApp theApp;