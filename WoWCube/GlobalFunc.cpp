#include "stdafx.h"
#include "GlobalFunc.h"
//#include <afxinet.h>
#include <Wininet.h>
#include <Winver.h>
#include <string>
#include <fstream>
#include "Crc32Static.h"
#include "StdioFileEx.h"
#include "FileOperations.h"
#include "WoWCube.h"
#include "WoWCubeDlg.h"
#include <comdef.h>	//smart pointers
#include <mshtml.h>
#pragma warning(disable : 4146)	//see Q231931 for explaintation
#import <mshtml.tlb> no_auto_exclude
#import "msxml3.dll"


#define LOCATION_CHECKSUM_FILE _T("checksum.txt")
CString sSvnServer = _T("http://17cube.googlecode.com/svn");
extern CString sAppServer;
CStringArray downloadList, addonList, disableList;
//All Realm List Update On 3/13/2009
const int RI = 12;
const int RJ = 250;
wchar_t *RealmList[RI][RJ] = {
	//1
	{ L"阿格拉玛", L"艾苏恩", L"安威玛尔", L"奥达曼", L"奥蕾莉亚", L"白银之手", L"暴风祭坛", L"藏宝海湾", L"尘风峡谷", L"达纳斯", L"迪托马斯", L"国王之谷", L"黑龙军团", L"黑石尖塔", L"红龙军团", L"回音山", L"基尔罗格", L"卡德罗斯", L"卡扎克", L"库德兰", L"蓝龙军团", L"雷霆之王", L"烈焰峰", L"罗宁", L"洛萨", L"玛多兰", L"玛瑟里顿", L"莫德古得", L"耐萨里奥", L"诺莫瑞根", L"普瑞斯托", L"燃烧平原", L"萨格拉斯", L"山丘之王", L"死亡之翼", L"索拉丁", L"索瑞森", L"铜龙军团", L"图拉扬", L"伊瑟拉", },
	//2
	{ L"阿迦玛甘", L"阿克蒙德", L"埃加洛尔", L"埃苏雷格", L"艾萨拉", L"艾森娜", L"爱斯特纳", L"暗影之月", L"奥拉基尔", L"冰霜之刃", L"达斯雷玛", L"地狱咆哮", L"地狱之石", L"风暴之怒", L"风行者", L"弗塞雷迦", L"戈古纳斯", L"毁灭之锤", L"火焰之树", L"卡德加", L"拉文凯斯", L"玛法里奥", L"麦维影歌", L"梅尔加尼", L"梦境之树", L"迷雾之海", L"耐普图隆", L"海加尔", L"轻风之语", L"夏维安", L"塞纳里奥", L"闪电之刃", L"石爪峰", L"泰兰德", L"屠魔山谷", L"伊利丹", L"月光林地", L"月神殿", L"战歌", L"主宰之剑", }, 
	//3
	{ L"鲜血之环", L"埃德萨拉", L"血环", L"布莱克摩", L"杜隆坦", L"符文图腾", L"鬼雾峰", L"黑暗之矛", L"红龙女王", L"红云台地", L"黄金之路", L"古雷曼格", L"火羽山", L"迦罗娜", L"亚门纳尔", L"凯恩血蹄", L"狂风峭壁", L"雷斧堡垒", L"雷霆号角", L"奥蕾塞丝", L"雷克萨", L"玛里苟斯", L"纳沙塔尔", L"诺兹多姆", L"普罗德摩", L"千针石林", L"燃烧之刃", L"萨尔", L"灰烬使者", L"死亡之门", L"圣火神殿", L"禁魔监狱", L"甜水绿洲", L"熊猫酒仙", L"血牙魔王", L"勇士岛", L"羽月", L"蜘蛛王国", L"自由之风", },
	//4
	{ L"阿尔萨斯", L"阿拉索", L"埃雷达尔", L"艾欧纳尔", L"暗影议会", L"奥特兰克", L"巴尔古恩", L"冰风岗", L"达隆米尔", L"耳语海岸", L"古尔丹", L"寒冰皇冠", L"基尔加丹", L"激流堡", L"巨龙之吼", L"拉格纳罗斯", L"莱斯霜语", L"利刃之拳", L"玛诺洛斯", L"麦迪文", L"凯尔萨斯", L"耐奥祖", L"克尔苏加德", L"瑞文戴尔", L"霜狼", L"霜之哀伤", L"斯坦索姆", L"提瑞斯法", L"通灵学院", L"希尔瓦娜斯", L"血色十字军", L"遗忘海岸", L"银松森林", L"银月", L"鹰巢山", L"影牙要塞", },
	//5
	{ L"狂热之刃", L"卡珊德拉", L"迅捷微风", L"守护之剑", L"泰坦之拳", L"斩魔者", L"布兰卡德", L"世界之树", L"玛格索尔", L"恶魔之翼", L"万色星辰", L"激流之傲", L"加兹鲁维", L"水晶之刺", L"苏塔恩", L"雏龙之翼", L"黑暗魅影", L"寒霜皇冠", L"浸毒之骨", L"阴影之刺", L"大地之怒", L"伊森利恩", L"神圣之歌", L"午夜之镰", L"暮色森林", L"元素之力", L"加拉德尔", L"日落沼泽", L"踏梦者", L"密林游侠", L"芬里斯", L"加德纳尔", L"伊萨里奥斯", L"安多哈尔", L"风暴之眼", L"提尔之手", L"永夜港", L"金色平原(RP)", L"朵丹尼尔", L"法拉希姆", },
	//6
	{ L"安其拉", L"安纳塞隆", L"阿努巴拉克", L"阿拉希", L"瓦里玛萨斯", L"巴纳扎尔", L"黑手军团", L"血羽", L"燃烧军团", L"克洛玛古斯", L"破碎岭", L"克苏恩", L"阿纳克洛斯", L"雷霆之怒", L"桑德兰", L"黑翼之巢", L"德拉诺", L"龙骨平原", L"卡拉赞", L"熔火之心", L"格瑞姆巴托", L"古拉巴什", L"哈卡", L"海克泰尔", L"库尔提拉斯", L"洛丹伦", L"奈法利安", L"奎尔萨拉斯", L"拉贾克斯", L"拉文霍德", L"森金", L"范达尔鹿盔", L"泰拉尔", L"瓦拉斯塔兹", L"永恒之井", L"海达希亚", L"萨菲隆", L"纳克萨玛斯", L"无尽之海", L"莱索恩", },
	//7
	{ L"阿卡玛", L"阿扎达斯", L"灰谷", L"艾维娜", L"巴瑟拉斯", L"血顶", L"恐怖图腾", L"古加尔", L"达文格尔", L"黑铁", L"恶魔之魂", L"迪瑟洛克", L"丹莫德", L"艾莫莉丝", L"埃克索图斯", L"菲拉斯", L"加基森", L"加里索斯", L"格雷迈恩", L"布莱恩", L"伊莫塔尔", L"大漩涡", L"诺森德", L"奥妮克希亚", L"奥斯里安", L"外域", L"天空之墙", L"风暴之鳞", L"荆棘谷", L"逐日者", L"塔纳利斯", L"瑟莱德丝", L"塞拉赞恩", L"托塞德林", L"黑暗虚空", L"安戈洛", L"维克尼拉斯", L"祖尔金", L"祖鲁希德", L"达卡尼", },
	//8
	{ L"冰川之拳", L"刺骨利刃", L"深渊之巢", L"迪塔格", L"巨槌", L"火烟之谷", L"伊兰尼库斯", L"火喉", L"戈杜尼", L"艾隆纳亚", L"迦玛兰", L"金度", L"邪恶颅壳", L"巫妖之王", L"玛加萨", L"米奈希尔", L"莫格莱尼", L"莫什奥格", L"噬灵沼泽", L"幽暗沼泽", L"耐克鲁斯", L"匹瑞诺德", L"破碎之手", L"碎颅者", L"烈焰荆棘", L"夺灵者", L"岩石巨塔", L"碎裂之拳", L"石锤", L"风暴裂隙", L"塞拉摩", L"瑟玛普拉格", L"奥丹姆", L"维克洛尔", L"邪枝", L"怀特迈恩", L"冬泉谷", L"伊森德雷", L"扎拉赞恩", L"亚雷戈斯", },
	//9
	{ L"深渊之喉", L"凤凰之神", L"阿古斯", L"鲜血熔炉", L"血槌", L"黑暗之门", L"死亡熔炉", L"迪门修斯", L"火焰之地", L"格鲁尔", L"军团要塞", L"摩摩尔", L"雷德", L"试炼之环", L"希雷诺斯", L"塞泰克", L"破碎大厅", L"太阳之井", L"范克里夫", L"祖阿曼", L"翡翠梦境", },
	//10
	{ L"阿比迪斯", L"阿曼尼", L"安苏", L"生态船", L"阿斯塔洛", L"白骨荒野", L"布鲁塔卢斯", L"达尔坎", L"末日行者", L"达基萨斯", L"熵魔", L"能源舰", L"菲米丝", L"加尔", L"迦顿", L"血吼", L"戈提克", L"盖斯", L"壁炉谷", L"贫瘠之地", },
	//11 taiwan
	{ L"撒爾薩里安", L"凜風峽灣", L"諾姆瑞根", L"戰歌", L"寒冰皇冠", L"阿薩斯", L"眾星之子", L"銀翼要塞", L"憤怒使者", L"聖光之願", L"夜空之歌", L"暴風祭壇", L"血之谷", L"亞雷戈斯", L"語風", L"奧妮克希亞", L"鬼霧峰", L"屠魔山谷", L"米奈希爾", L"冰風崗哨", L"狂熱之刃", L"巴納札爾", L"水晶之刺", L"天空之牆", L"世界之樹", L"雷鱗", L"巨龍之喉", L"冰霜之刺", L"日落沼澤", L"地獄吼", L"暗影之月", L"尖石",},
	//12 us
	{ L"Aegwynn", L"Aerie Peak", L"Agamaggan", L"Aggramar", L"Akama", L"Alexstrasza", L"Alleria", L"Altar of Storms", L"Alterac Mountains", L"Aman'Thul", L"Andorhal", L"Anetheron", L"Antonidas", L"Anub'arak", L"Anvilmar", L"Arathor", L"Archimonde", L"Area 52", L"Arena Tournament 1", L"Arena Tournament 2", L"Argent Dawn", L"Arthas", L"Arygos", L"Auchindoun", L"Azgalor", L"Azjol-Nerub", L"Azshara", L"Azuremyst", L"Baelgun", L"Balnazzar", L"Barthilas", L"Black Dragonflight", L"Blackhand", L"Blackrock", L"Blackwater Raiders", L"Blackwing Lair", \
		L"Blade's Edge", L"Bladefist", L"Bleeding Hollow", L"Blood Furnace", L"Bloodhoof", L"Bloodscalp", L"Bonechewer", L"Borean Tundra", L"Boulderfist", L"Bronzebeard", L"Burning Blade", L"Burning Legion", L"Caelestrasz", L"Cairne", L"Cenarion Circle", L"Cenarius", L"Cho'gall", L"Chromaggus", L"Coilfang", L"Crushridge", L"Daggerspine", L"Dalaran", L"Dalvengyr", L"Dark Iron", L"Darkspear", L"Darrowmere", L"Dath'Remar", L"Dawnbringer", L"Deathwing", L"Demon Soul", L"Dentarg", L"Destromath", L"Dethecus", L"Detheroc", L"Doomhammer", L"Draenor",\
		L"Dragonblight", L"Dragonmaw", L"Drak'Tharon", L"Drak'thul", L"Draka", L"Drakkari", L"Dreadmaul", L"Drenden", L"Dunemaul", L"Durotan", L"Duskwood", L"Earthen Ring", L"Echo Isles", L"Eitrigg", L"Eldre'Thalas", L"Elune", L"Emerald Dream", L"Eonar", L"Eredar", L"Executus", L"Exodar", L"Farstriders", L"Feathermoon", L"Fenris", L"Firetree", L"Fizzcrank", L"Frostmane", L"Frostmourne", L"Frostwolf", L"Galakrond", L"Garithos", L"Garona", L"Garrosh", L"Ghostlands", L"Gilneas", L"Gnomeregan", L"Gorefiend", L"Gorgonnash", L"Greymane", L"Grizzly Hills",\
		L"Gul'dan", L"Gundrak", L"Gurubashi", L"Hakkar", L"Haomarush", L"Hellscream", L"Hydraxis", L"Hyjal", L"Icecrown", L"Illidan", L"Jaedenar", L"Jubei'Thos", L"Kael'thas", L"Kalecgos", L"Kargath", L"Kel'Thuzad", L"Khadgar", L"Khaz Modan", L"Khaz'goroth", L"Kil'Jaeden", L"Kilrogg", L"Kirin Tor", L"Korgath", L"Korialstrasz", L"Kul Tiras", L"Laughing Skull", L"Lethon", L"Lightbringer", L"Lightning's Blade", L"Lightninghoof", L"Llane", L"Lothar", L"Madoran", L"Maelstrom", L"Magtheridon", L"Maiev", L"Mal'Ganis", L"Malfurion", L"Malorne", L"Malygos",\
		L"Mannoroth", L"Medivh", L"Misha", L"Mok'Nathal", L"Moon Guard", L"Moonrunner", L"Mug'thol", L"Muradin", L"Nagrand", L"Nathrezim", L"Nazgrel", L"Nazjatar", L"Ner'zhul", L"Nesingwary", L"Nordrassil", L"Norgannon", L"Onyxia", L"Perenolde", L"Proudmoore", L"Quel'dorei", L"Quel'Thalas", L"Ragnaros", L"Ravencrest", L"Ravenholdt", L"Rexxar", L"Rivendare", L"Runetotem", L"Sargeras", L"Saurfang", L"Scarlet Crusade", L"Scilla", L"Sen'Jin", L"Sentinels", L"Shadow Council", L"Shadowmoon", L"Shadowsong", L"Shandris", L"Shattered Halls", L"Shattered Hand",\
		L"Shu'halo", L"Silver Hand", L"Silvermoon", L"Sisters of Elune", L"Skullcrusher", L"Skywall", L"Smolderthorn", L"Spinebreaker", L"Spirestone", L"Staghelm", L"Steamwheedle Cartel", L"Stonemaul", L"Stormrage", L"Stormreaver", L"Stormscale", L"Suramar", L"Tanaris", L"Terenas", L"Terokkar", L"Thaurissan", L"The Forgotten Coast", L"The Scryers", L"The Underbog", L"The Venture Co", L"Thorium Brotherhood", L"Thrall", L"Thunderhorn", L"Thunderlord", L"Tichondrius", L"Tortheldrin", L"Trollbane", L"Turalyon", L"Twisting Nether", L"Uldaman", L"Uldum",\
		L"Undermine", L"Ursin", L"Uther", L"Vashj", L"Vek'nilash", L"Velen", L"Warsong", L"Whisperwind", L"WildHammer", L"Windrunner", L"Winterhoof", L"Wyrmrest Accord", L"Ysera", L"Ysondre", L"Zangarmarsh", L"Zul'jin", L"Zuluhed", },
	//...
};
extern CString m_TempPath;
extern CString m_AppFileName;
extern CString strInterfacePath;
extern CString strTempInterface;
//-------------------------------------------------------------------------
// Function Name    :IsFileExist	[static]
// Parameter(s)     :CString sFilePath	文件路径和名称
// Return           :BOOL
// Memo             :判断文件是否存在
//-------------------------------------------------------------------------
bool IsFileExist(LPCTSTR sFilePath)
{
	bool bExist = FALSE;
	HANDLE hFile = NULL;

	hFile = CreateFile(	sFilePath
		, GENERIC_READ
		, FILE_SHARE_READ | FILE_SHARE_WRITE
		, NULL
		, OPEN_EXISTING
		, 0
		, 0
		);

	if( hFile != INVALID_HANDLE_VALUE )
	{
		CloseHandle( hFile );
		bExist = TRUE;
	}

	return (bExist);
}

bool IsFolderExists(CString sPath)
{
    DWORD attr; 
    attr = GetFileAttributes(sPath); 
    return (attr != (DWORD)(-1) ) &&
        ( attr & FILE_ATTRIBUTE_DIRECTORY); 
}

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

UINT DownloadIt(LPVOID pDownload)
{
	BOOL bResult;
	CString szUrl = ((DownloadInfo *)pDownload)->url;
	CString szFileName = ((DownloadInfo *)pDownload)->filename;
	bool showinfo = ((DownloadInfo *)pDownload)->showinfo;
	int after = ((DownloadInfo *)pDownload)->after;
	HWND hWnd = ::AfxGetApp()->GetMainWnd()->m_hWnd;

	::EnableWindow(GetDlgItem(hWnd, IDC_BUTTON_UPDATE), FALSE);
	//::SetDlgItemText(hWnd, IDC_STATIC_TIP, _T(""));
	if ( InternetGetFile(szUrl, szFileName, showinfo) == 0 ) {
		switch (after) {
			case 1:
				::SetDlgItemText(hWnd, IDC_STATIC_TIP, _T("正在查找可用的更新..."));
				if ( ParseXml(szFileName) == 0)
					if ( downloadList.GetCount() > 0 ) {
						RemoveUI();
						//AfxBeginThread(UninstallApp, (LPVOID)NULL);
						::SetDlgItemText(hWnd, IDC_STATIC_TIP, _T("开始下载更新文件..."));
						if ( DownloadUI() == 0 )
							::SetDlgItemText(hWnd, IDC_STATIC_TIP, _T("更新完成。"));
					} else {
						::SetDlgItemText(hWnd, IDC_STATIC_TIP, _T("没有可用的更新。"));
					}
			break;
		}
		bResult = 0;
	} else {
		bResult = -1;
	}

	::EnableWindow(GetDlgItem(hWnd, IDC_BUTTON_UPDATE), TRUE);

	return bResult;
}

UINT CompareSha1(LPVOID pVer)
{
	CString Version = ((VersionInfo *)pVer)->Version;
	CString Sha1 = ((VersionInfo *)pVer)->Sha1;
	
	CString lpUrl = sAppServer + _T("/tags/") + Version + _T("/") + LOCATION_CHECKSUM_FILE;
	CString rSha1;
	if ( InternetGetFileToString(lpUrl, rSha1) == 0 ) {
		int i = wcscmp(Sha1, rSha1);
		if ( i != 0 )
			AfxMessageBox(_T("检测到更新程序效验码不正确。\n请到官方网站重新下载:\nhttp://wowcube.cn\n\n请及时修改密码和进行杀毒。\n今后请勿从第三方网站下载。"), MB_ICONINFORMATION|MB_OK);
	}

	return 0;
}

int InternetGetFile(CString szUrl, CString szFileName, bool showinfo)
{
	HWND hWnd = ::AfxGetApp()->GetMainWnd()->m_hWnd;
    DWORD dwFlags;
	InternetGetConnectedState(&dwFlags, 0);
	CHAR strAgent[64];

	CString szFileShow;
	if ( szFileName.Find(strTempInterface) != -1 ) {
		szFileShow =szFileName.Mid(strTempInterface.GetLength(), szFileName.GetLength());
	} else {
		int i = szFileName.ReverseFind('\\');
		szFileShow =szFileName.Mid(i + 1, szFileName.GetLength());
	}

	memset(strAgent,0,sizeof(strAgent));
	CTime t(CTime::GetCurrentTime());
	sprintf_s(strAgent, "WoWCubeAgent%s",t.Format("%H:%M:%S"));
	HINTERNET hOpen;
	if(!(dwFlags & INTERNET_CONNECTION_PROXY))
		hOpen = InternetOpenA(strAgent, INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY, NULL, NULL, 0);
	else
		hOpen = InternetOpenA(strAgent, INTERNET_OPEN_TYPE_PRECONFIG, NULL, NULL, 0);
	if(!hOpen)
	{
		//下载失败
		::SetDlgItemText(hWnd, IDC_STATIC_TIP, _T("创建连接失败，请稍候再试。"));
		return -1;
	}

	DWORD dwSize;
	//LPCTSTR szHead = _T("Accept: */*\r\n\r\n");
	LPCTSTR szHead = _T("Accept: */*\r\nUser-Agent: WoWCube Patcher\r\n");
	BYTE szTemp[8192]; //4096
	HINTERNET  hConnect;
	CFile file;

	if ( !(hConnect = InternetOpenUrl ( hOpen, szUrl, szHead,
			lstrlen(szHead), INTERNET_FLAG_DONT_CACHE | INTERNET_FLAG_PRAGMA_NOCACHE | INTERNET_FLAG_RELOAD, 0)))
	{
		//访问错误
		::SetDlgItemText(hWnd, IDC_STATIC_TIP, _T("访问网络失败，请稍候再试。"));
		InternetCloseHandle(hOpen);
	    return -1;
	}
	DWORD dwIndex = 0,	dwCodeLen = 10;
	char dwcode[20];
	HttpQueryInfo(hConnect, HTTP_QUERY_STATUS_CODE, &dwcode, &dwCodeLen, &dwIndex);
	CString strErr;
	strErr.Format(_T("%s"), dwcode);
	if(strErr.Find(_T("404"))!=-1)
	{
		::SetDlgItemText(hWnd, IDC_STATIC_TIP, _T("没有在服务器上找到文件，请联系管理员。"));
		InternetCloseHandle(hConnect);
		InternetCloseHandle(hOpen);
		return -1;
	}

	DWORD dwByteToRead = 0;   
	DWORD dwSizeOfRq = 4;   
	if (!HttpQueryInfo(hConnect,HTTP_QUERY_CONTENT_LENGTH | HTTP_QUERY_FLAG_NUMBER, (LPVOID)&dwByteToRead, &dwSizeOfRq, NULL))
	{
		dwByteToRead = 0; 
	};

	if  (file.Open(szFileName,CFile::modeWrite|CFile::modeCreate)==FALSE )
	{
		::SetDlgItemText(hWnd, IDC_STATIC_TIP, _T("创建本地文件失败，请检查磁盘空间或用户权限。"));
		InternetCloseHandle(hOpen);
		return -1;
	}

	SYSTEMTIME modiTime;
	DWORD dwTime = sizeof(SYSTEMTIME);
	BOOL bTime=true;
	DWORD dwBytes = 0;  
    if (!HttpQueryInfo(hConnect, HTTP_QUERY_LAST_MODIFIED |HTTP_QUERY_FLAG_SYSTEMTIME, (LPVOID)&modiTime, &dwTime, NULL))
	{
		bTime=false;
	}

	if ( showinfo == true ) {
		if ( szFileShow == _T("filelist.xml") )
			szFileShow = _T("更新文件列表");
		::SetDlgItemText(hWnd, IDC_STATIC_TIP, _T("正在下载: ") + szFileShow);
	}

	memset(szTemp,0,sizeof(szTemp));
	do
	{
		if (!InternetReadFile(hConnect, szTemp, sizeof(szTemp),  &dwSize))
		{
			break;
		}
		if (dwSize==0)
			break;
		else 
		file.Write(szTemp,dwSize);
		dwBytes+=dwSize;
		
		if ( showinfo == true ) {
			double dPos = ( (double)dwBytes / (double)dwByteToRead ) * 100;
			int nPos = int(dPos * 100);
			::PostMessage(GetDlgItem(hWnd, IDC_PROGRESS_DL), PBM_SETPOS, (WPARAM)nPos, 0L);
		}
	}while (TRUE);

	file.Flush();
	file.Close();
	if(bTime)
	{
		CFileStatus status;
		CFile::GetStatus(szFileName,status);
		status.m_ctime=status.m_mtime =CTime(modiTime);
		CFile::SetStatus(szFileName,status);
	}
	InternetCloseHandle(hConnect);
	InternetCloseHandle(hOpen);

	//::SetDlgItemText(hWnd, IDC_STATIC_TIP, _T(""));

	return 0;
}

//////////////////////////////////////////////////////////////////////////////
//功能：从网上下载文件到内存
//作者
//日期：2006.1
/////////////////////////////////////////////////////////////////////////////
int InternetGetFileToString(CString szUrl, CString& szMem)
{
    DWORD dwFlags;
	InternetGetConnectedState(&dwFlags, 0);
	CHAR strAgent[64];
	memset(strAgent,0,sizeof(strAgent));
	CTime t(CTime::GetCurrentTime());
	sprintf_s(strAgent, "WoWCubeAgent%s",t.Format("%H:%M:%S"));
	
	HINTERNET hOpen;
	if(!(dwFlags & INTERNET_CONNECTION_PROXY))
		hOpen = InternetOpenA(strAgent, INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY, NULL, NULL, 0);
	else
		hOpen = InternetOpenA(strAgent, INTERNET_OPEN_TYPE_PRECONFIG, NULL, NULL, 0);
	if(!hOpen)
	{
		return -1;
	}

	HINTERNET  hConnect;
	LPCTSTR szHead = _T("Accept: text/*\r\nUser-Agent: WoWCube Patcher\r\n");//_T("Accept: */*\r\n\r\n");
	if ( !(hConnect = InternetOpenUrl ( hOpen, szUrl, szHead,
		 lstrlen (szHead), INTERNET_FLAG_DONT_CACHE | INTERNET_FLAG_PRAGMA_NOCACHE | INTERNET_FLAG_RELOAD, 0)))
	{
		InternetCloseHandle(hOpen);
	    return -1;
	}

	DWORD dwIndex = 0,	dwCodeLen = 10;
	char dwcode[20];
	HttpQueryInfo(hConnect, HTTP_QUERY_STATUS_CODE, &dwcode, &dwCodeLen, &dwIndex);
	CString strErr;
	strErr.Format(_T("%s"), dwcode);
	if(strErr.Find(_T("404"))!=-1)
	{
		InternetCloseHandle(hConnect);
		InternetCloseHandle(hOpen);
		return -1;
	}

	BYTE* szTemp=new BYTE[1024];
	DWORD dwSize;
	do
	{
		if (!InternetReadFile (hConnect, szTemp, 1023,  &dwSize))
		{
			break;
		}
		if (dwSize==0)
			break;
		else
		{
			szTemp[dwSize]=0;
			szMem+=CString(szTemp);
		}
		
	}while (TRUE);	

	delete [] szTemp;
	InternetCloseHandle(hConnect);
	InternetCloseHandle(hOpen);
	return 0;
}

struct VS_VERSIONINFO
{
    WORD                wLength;
    WORD                wValueLength;
    WORD                wType;
    WCHAR               szKey[1];
    WORD                wPadding1[1];
    VS_FIXEDFILEINFO    Value;
    WORD                wPadding2[1];
    WORD                wChildren[1];
};

std::string to_utf8(const wchar_t* buffer, int len)
{
        int nChars = ::WideCharToMultiByte(
                CP_UTF8,
                0,
                buffer,
                len,
                NULL,
                0,
                NULL,
                NULL);
        if (nChars == 0) return "";

        std::string newbuffer;
        newbuffer.resize(nChars) ;
        ::WideCharToMultiByte(
                CP_UTF8,
                0,
                buffer,
                len,
                const_cast< char* >(newbuffer.c_str()),
                nChars,
                NULL,
                NULL); 

        return newbuffer;
}

std::string to_utf8(const std::wstring& str)
{
        return to_utf8(str.c_str(), (int)str.size());
}

/* Recursively traverse a directory and its subdirectories. */
BOOL TraverseDirectory(LPCTSTR lpszDirectory)
{
    HANDLE SearchHandle;
    WIN32_FIND_DATA FindData;
    TCHAR CurrPath[MAX_PATH + 1];

    static int tabCnt = 0;
	static CString sAddon;
	static bool bEnter = true;

	static CString szFilelist = m_AppFileName.Left(m_AppFileName.ReverseFind('\\')+1) + _T("filelist.xml");
	//static HANDLE hFile;
	//static DWORD dwWritten;

	static std::ofstream myFile;
	static std::wstring wtext;
	static std::string text;

	DWORD dwCrc32, dwErrorCode = NO_ERROR;

    if (!lpszDirectory)
        return false;

 /*
	if ( myFile.Open( szFilelist , CFile::modeCreate | CFile::modeReadWrite, NULL ) )
	{
		//strcpy(szBuffer, (char*)(LPCSTR)lpszDirectory);
		myFile.Write( lpszDirectory, sizeof( lpszDirectory ) ); 
		myFile.Flush();
		myFile.Seek( 0, CFile::begin );
		//nActual = myFile.Read( szBuffer, sizeof( szBuffer ) ); 
		myFile.Close();
	}
*/
	if ( tabCnt == 0 ) {
		/*
		hFile = CreateFile(
			szFilelist, 
			GENERIC_WRITE, 
			FILE_SHARE_WRITE, 
			NULL, CREATE_ALWAYS, 
			FILE_ATTRIBUTE_NORMAL, 
			NULL
		);
		if(hFile != INVALID_HANDLE_VALUE)
		{	
			//WriteFile(hFile, "\xFF\xFE", 2, &dwWritten, NULL);
			WriteFile(hFile, _T("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"), lstrlen(_T("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"))*sizeof(WCHAR), &dwWritten, NULL);
			WriteFile(hFile, _T("\r\n"), lstrlen(_T("\r\n"))*sizeof(WCHAR), &dwWritten, NULL);
			WriteFile(hFile, _T("<AddOns version=\"1.0\">"), lstrlen(_T("<AddOns version=\"1.0\">"))*sizeof(WCHAR), &dwWritten, NULL);
		}
		*/
		myFile.open(szFilelist, std::ios::out | std::ios::binary);
		wtext = _T("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>")
				_T("\r\n")
				_T("<AddOns version=\"1.0\">");
		/*
		TRACE(_T("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"));
		TRACE(_T("\n"));
		TRACE(_T("<AddOns version=\"1.0\">"));
		*/
	} else if ( tabCnt == 1 ) {
		wtext += _T("<AddOn Name=\"");
		wtext += lpszDirectory;
		wtext += _T("\">");
		/*
		TRACE(_T("<AddOn Name=\""));
		TRACE(lpszDirectory);
		TRACE(_T("\">"));
		*/
		sAddon = (CString)lpszDirectory;
		bEnter = false;
	}

	SetCurrentDirectory(lpszDirectory);
    GetCurrentDirectory(MAX_PATH, CurrPath);
    CString strPath(CurrPath);
    if (strPath.Right (1) != _T ("\\"))
        strPath += _T ("\\");
    strPath += _T ("*.*");

    /* Open up the directory search handle and get the first file name to satisfy the path name. */
    SearchHandle = FindFirstFile(strPath, &FindData);
    if (SearchHandle == INVALID_HANDLE_VALUE) {
        return false;
    }
    /* Scan the directory and its subdirectories. */
    do {
        if (wcscmp(FindData.cFileName, _T(".") ) == 0 || wcscmp(FindData.cFileName, _T("..") ) == 0)
            continue;
        if (FindData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) {
			++tabCnt;
			if ( bEnter == true ) {
				wtext += _T("\r\n");
				//TRACE("\n");
				for (int i = 0; i != tabCnt; ++i)
					wtext += _T("\t");
					//TRACE("\t");
			}
			int idx = strPath.ReverseFind('\\');
			CString strChildPath = CString(strPath, idx + 1);
			strChildPath += FindData.cFileName;
			SetCurrentDirectory(strChildPath);
			/* Traverse the subdirectory recursively. */
			TraverseDirectory(FindData.cFileName);
			//TraverseDirectory(strChildPath);
			SetCurrentDirectory(_T(".."));
			--tabCnt;
        } else if (FindData.dwFileAttributes) {  //FILE_ATTRIBUTE_NORMAL, FILE_ATTRIBUTE_ARCHIVE, FILE_ATTRIBUTE_COMPRESSED, FILE_ATTRIBUTE_HIDDEN, FILE_ATTRIBUTE_READONLY, FILE_ATTRIBUTE_SYSTEM
			wtext += _T("\r\n");
			//TRACE("\n");
			if ( tabCnt < 2 ) {
				++tabCnt;
				for (int i = 0; i != tabCnt; ++i)
					wtext += _T("\t");
					//TRACE("\t");
				int idx = strPath.ReverseFind('\\');
				CString strChildPath = CString(strPath, idx + 1);
				strChildPath += FindData.cFileName;
				wtext += _T("<File Path=\"");
				wtext += FindData.cFileName;
				dwErrorCode = CCrc32Static::FileCrc32Assembly(strChildPath, dwCrc32);

				CString strResult;
				if(dwErrorCode == NO_ERROR)
					strResult.Format(_T("%08x"), dwCrc32);
				else
					strResult.Format(_T("Error: %08x"), dwErrorCode);

				wtext += _T("\" CRC32=\"");
				wtext += strResult;

				wtext += _T("\" />");
				/*
				TRACE(_T("<File Path=\""));
				TRACE( FindData.cFileName );
				TRACE(_T("\" />"));
				*/
				--tabCnt;
			} else {
				for (int i = 0; i != 2; ++i)
					wtext += _T("\t");
					//TRACE("\t");			
				int idx = strPath.ReverseFind('\\');
				CString strChildPath = CString(strPath, idx + 1);
				strChildPath += FindData.cFileName;
				dwErrorCode = CCrc32Static::FileCrc32Assembly(strChildPath, dwCrc32);

				idx = strPath.Find(sAddon);
				CString szFileName = CString(CurrPath);
				szFileName = szFileName.Mid(idx + 1 + sAddon.GetLength() , szFileName.GetLength()-1);
				szFileName += _T("\\");
				szFileName += FindData.cFileName;

				wtext += _T("<File Path=\"");
				wtext += szFileName;

				CString strResult;
				if(dwErrorCode == NO_ERROR)
					strResult.Format(_T("%08x"), dwCrc32);
				else
					strResult.Format(_T("Error: [0x%08x]"), dwErrorCode);

				wtext += _T("\" CRC32=\"");
				wtext += strResult;

				wtext += _T("\" />");
				/*
				TRACE(_T("<File Path=\""));
				TRACE( strChildPath );
				TRACE(_T("\" />"));
				*/
			}
		}
        /* Get the next file or directory name. */
    } while (FindNextFile(SearchHandle, &FindData));
	if  ( tabCnt == 0 ) {
		FindClose(SearchHandle);
		wtext += _T("\r\n");
		//TRACE("\n");
		for (int i = 0; i != tabCnt; ++i)
			wtext += _T("\t");
			//TRACE("\t");

		--tabCnt;
		wtext += _T("</AddOns>");
		//TRACE("</AddOns>");

		tabCnt = 0;
		sAddon = "";
		bEnter = true;
		//CloseHandle(hFile);
		text = to_utf8(wtext);
		myFile << text;
		myFile.close();

		return true;
	} else if ( tabCnt == 1 ) {
		wtext += _T("\r\n");
		//TRACE("\n");
		for (int i = 0; i != tabCnt; ++i)
			wtext += _T("\t");
			//TRACE("\t");
		wtext += _T("</AddOn>");
		//TRACE("</AddOn>");
		bEnter = true;
		SetCurrentDirectory(_T(".."));

		return true;
	} else {
		return true;
	}
}

int ParseXml(CString szFile)
{
	::CoInitialize(NULL);
	MSXML2::IXMLDOMDocumentPtr spDoc;
	HRESULT hr = spDoc.CreateInstance(__uuidof(MSXML2::DOMDocument));  
	hr = spDoc->load(CComVariant(szFile));               //load xml文件
	MSXML2::IXMLDOMElementPtr spElement;
	downloadList.RemoveAll();
	addonList.RemoveAll();
	hr = spDoc->get_documentElement(&spElement);   //获取根结点
	/*
	CComBSTR strTagName;
	hr = spElement->get_tagName(&strTagName);
	TRACE(_T("Tag:"));
	TRACE(strTagName);	//Addons
	*/
	MSXML2::IXMLDOMNodeListPtr spNodeList;
	hr = spElement->get_childNodes(&spNodeList);   //获取子结点列表

	long lCount;                                      
	hr = spNodeList->get_length(&lCount);

	for (long i=0; i<lCount; ++i)
	{
		MSXML2::IXMLDOMNodePtr spNode;
		MSXML2::DOMNodeType NodeType;
		MSXML2::IXMLDOMNodeListPtr spChildNodeList;
		DWORD dwCrc32, dwErrorCode = NO_ERROR;

		hr = spNodeList->get_item(i, &spNode);    //获取结点

		//CComBSTR bsNodeName;
		CComVariant varNodeValue;	//插件名
		/*
		hr = spNode->get_nodeName(&bsNodeName);
		TRACE(bsNodeName);	//Addon
		
		Move to DisabledAddOn
		*/
		spNode->Getattributes()->getNamedItem("Name")->get_nodeValue(&varNodeValue);
		addonList.Add((LPCTSTR)(_bstr_t)varNodeValue);

		hr = spNode->get_nodeType(&NodeType);     //获取结点信息的类型
		if (NODE_ELEMENT == NodeType)
		{
			hr = spNode->get_childNodes(&spChildNodeList);
			long childLen;
			hr = spChildNodeList->get_length(&childLen);

			for (int j=0; j<childLen; ++j)
			{
				MSXML2::IXMLDOMNodePtr spChildNode;
				CComBSTR bsChildNodeName;
				CComVariant varChildNodeValue;

				hr = spChildNodeList->get_item(j, &spChildNode);
				/*
				hr = spChildNode->get_nodeName(&bsChildNodeName); 
				TRACE(bsChildNodeName);  //File
				*/

				spChildNode->Getattributes()->getNamedItem("Path")->get_nodeValue(&varChildNodeValue);
				CString szRemoteFile = (_bstr_t)varNodeValue + "\\" + (_bstr_t)varChildNodeValue;
				CString szLocalFile = strInterfacePath + _T("AddOns\\") + szRemoteFile;
				/*
				if (IsFolderExists(strTempInterface) && !IsFolderExists(strInterfacePath)) {
					szLocalFile = strTempInterface + _T("AddOns\\") + szRemoteFile;
				} else {
					szLocalFile = strInterfacePath + _T("AddOns\\") + szRemoteFile;
				}
				*/
				dwErrorCode = CCrc32Static::FileCrc32Assembly(szLocalFile, dwCrc32);

				CString szCrc;
				if(dwErrorCode == NO_ERROR)
					szCrc.Format(_T("%08x"), dwCrc32);
				else
					szCrc.Format(_T("Error: %08x"), dwErrorCode);

				spChildNode->Getattributes()->getNamedItem("CRC32")->get_nodeValue(&varChildNodeValue);
				if ( szCrc != (LPCTSTR)(_bstr_t)varChildNodeValue )
				{
					downloadList.Add(szRemoteFile);
				}

				spChildNode.Release();
			}
		}
		spNode.Release();
		spChildNodeList.Release();
	}
	spNodeList.Release();
	spElement.Release();
	spDoc.Release();
	::CoUninitialize();

	return 0;
}

int RemoveUI( void )
{
	disableList.RemoveAll();
	int nCount;

    HANDLE SearchHandle;
    WIN32_FIND_DATA FindData;
	CString strPath = strInterfacePath + _T("AddOns\\*.*");
	SearchHandle = FindFirstFile(strPath, &FindData);
	if (SearchHandle == INVALID_HANDLE_VALUE) {
        return -1;
    }
    do {
        if (wcscmp(FindData.cFileName, _T(".") ) == 0 || wcscmp(FindData.cFileName, _T("..") ) == 0)
            continue;
        if (FindData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) {
			CString dir, sAddon;
			dir = FindData.cFileName;
			if ( dir.Find(_T("Blizzard_")) != -1 )
				continue;
			nCount = addonList.GetCount();
			bool bFind = false;
			for (int i=0; i<nCount; i++) {
				sAddon = addonList.GetAt(i);
				if ( dir.Compare(sAddon) == 0) {
					bFind = true;
					break;
				}
			}
			if ( bFind == false ) {
				CStdioFileEx f;
				f.SetCodePage(CP_UTF8);
				CString lpFile = strInterfacePath + _T("AddOns\\") + dir + _T("\\") + dir + _T(".toc");
				if ( f.Open(lpFile, CFile::modeRead | CFile::typeText ) ) {
					CString buffer, context;
					while ( f.ReadString(buffer) ) {
						context += buffer;
					}
					f.Close();
					if ( context.Find(_T("X-Revision: gLimMod")) != -1 ) {
						disableList.Add(dir);
					}
				}
			}
		}
        /* Get the next file or directory name. */
    } while (FindNextFile(SearchHandle, &FindData));

	RecMakeDir(strInterfacePath + _T("DisabledAddOn"));
	CFileOperation fo;
	fo.SetOverwriteMode(true);
	nCount = disableList.GetCount();
	for (int i=0; i<nCount; i++)
	{
		if (!fo.Replace(strInterfacePath + _T("AddOns\\" + disableList.GetAt(i)), strInterfacePath + _T("DisabledAddOn"))) {
			fo.ShowError();
		}
	}

	return 0;
}

UINT UninstallApp(LPVOID param)
{
	HWND hWnd = ::AfxGetApp()->GetMainWnd()->m_hWnd;
	if ( RemoveUI() == 0 ) {
		
		::ShowWindow(::GetDlgItem(hWnd, IDC_BUTTON_UPDATE), SW_HIDE);
		::ShowWindow(::GetDlgItem(hWnd, IDC_BUTTON_INSTALL), SW_SHOW);
		::EnableWindow(::GetDlgItem(hWnd, IDC_BUTTON_UNINSTALL), TRUE);
		::SetDlgItemText(hWnd, IDC_STATIC_TIP, _T("卸载完成,失效的插件可以在DisabledAddOn目录里找到。欢迎下次使用。"));
		//::AfxMessageBox(_T("卸载完成，移除的插件可以在DisabledAddOn目录里找到。\n欢迎下次使用。"), MB_ICONINFORMATION|MB_OK);
	}
	::EnableWindow(::GetDlgItem(hWnd, IDC_BUTTON_EXIT), TRUE);

	return 0;
}


int DownloadUI( void )
{
	int nCount = downloadList.GetCount();
	CString sAddonRoot = sSvnServer + "/trunk/Interface/AddOns/";
	CString sAddonUrl, sAddFile;
	HWND hWnd = ::AfxGetApp()->GetMainWnd()->m_hWnd;

	for (int i=0; i<nCount; i++)
	{
		CString sLocalFile, sRemoteFile;
		sLocalFile = sRemoteFile = downloadList.GetAt(i);
		sRemoteFile.Replace(_T("\\"), _T("/"));
		sAddonUrl = sAddonRoot + sRemoteFile;
		//TRACE(sAddonUrl);
		//TRACE("\n");
		sAddFile = strTempInterface + _T("AddOns\\") + sLocalFile;
		//TRACE(sAddFile);
		//TRACE("\n");
		CString sAddDir;
		sAddDir = sAddFile.Left(sAddFile.ReverseFind('\\'));
		if ( RecMakeDir(sAddDir) == true )
			InternetGetFile(sAddonUrl, sAddFile, true);

		double dPos = ( (double)i / (double) (nCount - 1) );
		int nPos = int(dPos * 100);
		CString sTitle;
		if ( nPos < 100 ) {
			sTitle.Format(_T("(%d%%) WoWCube Patcher"), nPos);
		} else if ( nPos == 100 ) {
			sTitle = _T("WoWCube Patcher");
		}
		::AfxGetApp()->GetMainWnd()->SetWindowText(sTitle);
		::PostMessage(GetDlgItem(hWnd, IDC_PROGRESS_TOTAL), PBM_SETPOS, (WPARAM)nPos, 0L);
	}

	CFileOperation fo;
	fo.SetOverwriteMode(true);
	if (!fo.Copy(strTempInterface + _T("AddOns\\"), strInterfacePath))
	{
		fo.ShowError();
	}
	if (!fo.Delete(strTempInterface))
	{
		fo.ShowError();
	}

	return 0;
}

bool RecMakeDir(CString sPath)
{
    int len=sPath.GetLength();
    if ( len <2 ) return false; 

    if('\\'==sPath[len-1])
    {
        sPath=sPath.Left(len-1);
        len=sPath.GetLength();
    }
    if ( len <=0 ) return false;
    
    if (len <=3) 
    {
        if (IsFolderExists(sPath))return true;
        else return false; 
    }

    if (IsFolderExists(sPath))return true;

    CString Parent;
    Parent=sPath.Left(sPath.ReverseFind('\\') );
    
    if(Parent.GetLength()<=0)return false; 
    
    bool Ret=RecMakeDir(Parent); 
    
    if(Ret) 
    {
        SECURITY_ATTRIBUTES sa;
        sa.nLength=sizeof(SECURITY_ATTRIBUTES);
        sa.lpSecurityDescriptor=NULL;
        sa.bInheritHandle=0;
        Ret=(CreateDirectory(sPath,&sa)==TRUE);
        return Ret;
    }
    else
        return false;
}


int SearchRealm(CString sRealm)
{
	int i, j;
	for (i=0; i < RI; i ++ ) {
		for (j=0; j < RJ ; j++ ) {
			if ( RealmList[i][j] )
				if (wcscmp(RealmList[i][j], sRealm) == 0 )
					return i+1;
		}
	}
	return 0;
}

UINT Echo(LPVOID parma)
{
	if (!AfxSocketInit())
	{
		return -1;
	}
	// Initialize the AfxSocket
	AfxSocketInit(NULL);

	HWND hWnd = ::AfxGetApp()->GetMainWnd()->m_hWnd;
	LPCTSTR sHost = (LPCTSTR)parma;
	const int RECVBUFSIZE = 32; // Size of receive buffer
	unsigned int t1,t2,t3;

	SetDlgItemText(hWnd, IDC_STATIC_DELAY,  _T("网络延时\n获取中..."));

	UINT nPort = 3724;
	char echoString[] = "\0"; // Second arg: string to echo

	CSocket *pSocket = new CSocket();

	if (!pSocket->Create()) {
		SetDlgItemText(hWnd, IDC_STATIC_DELAY,  _T("网络延时\n获取失败"));
		return -1;
	}

	if (!pSocket->Connect(sHost, nPort)) {
		//TRACE("ERROR: %d !\n", pSocket->GetLastError() );
		pSocket->Close();
		SetDlgItemText(hWnd, IDC_STATIC_DELAY,  _T("网络延时\n连接失败"));
		return -1;
	}


	int echoStringLen = strlen(echoString);
	if ( pSocket->Send(echoString, strlen(echoString), 0) != echoStringLen ) {
		//TRACE("ERROR: %d !\n", pSocket->GetLastError() );
		pSocket->ShutDown(1);
		pSocket->Close();
		return -1;
	} else {
		t1 = GetTickCount();
	}
	pSocket->ShutDown(1);

	//int totalBytesRcvd = 0;
	char echoBuffer[RECVBUFSIZE]; // Buffer for echo string

	//int bytesRcvd; // Bytes read in single Receive()
	// Receive up to the buffer size (minus 1 to leave space
	// for a null terminator) bytes from the sender

	//if ( ( bytesRcvd = pSocket->Receive(echoBuffer, RECVBUFSIZE, 0) ) == 0 ) {
	if ( pSocket->Receive(echoBuffer, RECVBUFSIZE, 0) == 0 ) {
		//TRACE("ERROR: %d !\n", pSocket->GetLastError() );
		t2 = GetTickCount();
	} else {
		//TRACE("ERROR: %d !\n", pSocket->GetLastError() );
		pSocket->ShutDown(0);
		pSocket->Close();
		SetDlgItemText(hWnd, IDC_STATIC_DELAY,  _T("网络延时\n连接超时"));
		return -1;
	}
	pSocket->ShutDown(2);

	// Keep tally of total bytes (in a while, buy I remove it)
	//totalBytesRcvd += bytesRcvd;
	// Terminate the string
	//echoBuffer[bytesRcvd] = '\0';

	t3 = t2 - t1;
	CString str;
	str.Format(_T("网络延时\n%d毫秒"), t3);
	SetDlgItemText(hWnd, IDC_STATIC_DELAY,  str);

	pSocket->Close(); // Close the connection

	return 0;
}


UINT WatchRealmStatus(LPVOID pRealm)
{
	CString area;
	CString lpUrl;
	CString sRealm = ((RealmInfo *)pRealm)->realm;
	int i = ((RealmInfo *)pRealm)->idx;
	if ( 1<= i && i <=10 ) {
		area = _T("cn");
		lpUrl.Format(_T("http://status.wowchina.com/server/realmlist%d.htm"), i);	//china
	} else if ( i == 11 ) {
		area = _T("tw");
		lpUrl = _T("http://www.wowtaiwan.com.tw/index/realmstatus.asp");
	} else if ( i == 12 ) {
		area = _T("us");
		//Webpage http://www.worldofwarcraft.com/realmstatus/
		//Translate http://www.worldofwarcraft.com/realmstatus/index.xml
		//rss http://www.worldofwarcraft.com/realmstatus/status-events-rss.html?r=Area%2052
		lpUrl = _T("http://www.worldofwarcraft.com/realmstatus/status.xml");
	} else return -1;
	LPCTSTR mStatus = MAKEINTRESOURCE(IDR_GIFFAIL);
	CString sStatus;
	CString SaveFile = m_TempPath + _T("status.tmp");;
	if ( InternetGetFile(lpUrl, SaveFile, false) == 0 )
	{
		::CoInitialize(NULL);
		if ( area == "cn" ) {
			CStdioFileEx file;
			file.SetCodePage(CP_UTF8);
			CString sContext;
			if (file.Open(SaveFile, CFile::modeRead | CFile::typeText ))
			{
				CString buffer;
				while ( file.ReadString(buffer) )
				{
					sContext += buffer;
				}
				file.Close();

				//declare our MSHTML variables and create a document
				MSHTML::IHTMLDocument2Ptr pDoc;
				MSHTML::IHTMLDocument3Ptr pDoc3;
				MSHTML::IHTMLElementCollectionPtr pCollection, pc;
				MSHTML::IHTMLElementPtr pElement;
				MSHTML::IHTMLElementPtr pParent;

				HRESULT hr = CoCreateInstance(CLSID_HTMLDocument, NULL, CLSCTX_INPROC_SERVER, IID_IHTMLDocument2, (void**)&pDoc);
				
				//put the code into SAFEARRAY and write it into document
				SAFEARRAY* psa = SafeArrayCreateVector(VT_VARIANT, 0, 1);
				VARIANT *param;
				bstr_t bsData = (LPCTSTR)sContext;
				hr = SafeArrayAccessData(psa, (LPVOID*)&param);
				param->vt = VT_BSTR;
				param->bstrVal = (BSTR)bsData;
				
				hr = pDoc->write(psa);
				hr = pDoc->close();
				
				SafeArrayDestroy(psa);

				//I'll use IHTMLDocument3 to retrieve tags. Note it is available only in IE5+
				//If you don't want to use it, u can just run through all tags in HTML
				//(IHTMLDocument2->all property)
				pDoc3 = pDoc;

				pCollection = pDoc3->getElementsByTagName(L"P");
				for(long i=0; i<pCollection->length; i++)
				{
					pElement = pCollection->item(i, (long)0);
					if(pElement != NULL){
						//second parameter says that you want to get text inside attribute as is
						//(LPCTSTR)bstr_t(pParent->getAttribute("href", 2));
						CString strName = (LPCTSTR)(pElement->GetinnerText());
						if ( strName == sRealm )
						{
							pParent = pElement->GetparentElement()->GetparentElement();
							CString html = (LPCTSTR)pParent->GetouterHTML();
							if ( html.Find( _T("Uparrow.gif")) != -1 )
							{
								mStatus = MAKEINTRESOURCE(IDR_GIFUP);
							} else if ( html.Find( _T("Downarrow.gif")) != -1 )
							{
								mStatus = MAKEINTRESOURCE(IDR_GIFDOWN);
							} else
							{
								mStatus = MAKEINTRESOURCE(IDR_GIFFAIL);
							}
							sStatus = (LPCTSTR)pParent->GetinnerText();
							sStatus.Replace(strName, _T("负载: "));
							break;
						}
					}
				}
			} 
		} else if ( area == "tw" ) {
			CStdioFileEx file;
			CString sContext;
			if (file.Open(SaveFile, CFile::modeRead | CFile::typeText ))
			{
				CString buffer;
				while ( file.ReadString(buffer) )
				{
					sContext += buffer;
				}
				file.Close();

				//declare our MSHTML variables and create a document
				MSHTML::IHTMLDocument2Ptr pDoc;
				MSHTML::IHTMLDocument3Ptr pDoc3;
				MSHTML::IHTMLElementCollectionPtr pCollection, pc;
				MSHTML::IHTMLElementPtr pElement;
				MSHTML::IHTMLElementPtr pParent;

				HRESULT hr = CoCreateInstance(CLSID_HTMLDocument, NULL, CLSCTX_INPROC_SERVER, IID_IHTMLDocument2, (void**)&pDoc);
				
				//put the code into SAFEARRAY and write it into document
				SAFEARRAY* psa = SafeArrayCreateVector(VT_VARIANT, 0, 1);
				VARIANT *param;
				bstr_t bsData = (LPCTSTR)sContext;
				hr = SafeArrayAccessData(psa, (LPVOID*)&param);
				param->vt = VT_BSTR;
				param->bstrVal = (BSTR)bsData;
				
				hr = pDoc->write(psa);
				hr = pDoc->close();
				
				SafeArrayDestroy(psa);

				//I'll use IHTMLDocument3 to retrieve tags. Note it is available only in IE5+
				//If you don't want to use it, u can just run through all tags in HTML
				//(IHTMLDocument2->all property)
				pDoc3 = pDoc;

				pCollection = pDoc3->getElementsByTagName(L"TD");
				for(long i=0; i<pCollection->length; i++)
				{
					pElement = pCollection->item(i, (long)0);
					if(pElement != NULL){
						//second parameter says that you want to get text inside attribute as is
						//(LPCTSTR)bstr_t(pParent->getAttribute("href", 2));
						//CString str = (LPCTSTR)pElement->GetinnerText();
						wchar_t buf[32];
						::MultiByteToWideChar(950, 0, pElement->GetinnerText(), -1, buf, 32);
						CString strName = buf;
						if ( strName == sRealm )
						{
							pParent = pElement->GetparentElement()->GetparentElement();
							CString html = (LPCTSTR)pParent->GetouterHTML();
							if ( html.Find( _T("icon_up.gif")) != -1 )
							{
								mStatus = MAKEINTRESOURCE(IDR_GIFUP);
							} else if ( html.Find( _T("icon_stop.gif")) != -1 )
							{
								mStatus = MAKEINTRESOURCE(IDR_GIFDOWN);
							} else  //icon_down.gif
							{
								mStatus = MAKEINTRESOURCE(IDR_GIFFAIL);
							}
							sStatus = (LPCTSTR)pParent->GetinnerText();
							sStatus.Replace((LPCTSTR)pElement->GetinnerText(), _T("類型: "));
							break;
						}
						//delete buf;
					}
				}
			}
		} else if ( area == "us" ) {
			MSXML2::IXMLDOMDocumentPtr spDoc;
			HRESULT hr = spDoc.CreateInstance(__uuidof(MSXML2::DOMDocument));  
			hr = spDoc->load(CComVariant(SaveFile));               //load xml文件
			MSXML2::IXMLDOMElementPtr spElement;
			hr = spDoc->get_documentElement(&spElement);   //获取根结点

			MSXML2::IXMLDOMNodeListPtr spNodeList;
			hr = spElement->get_childNodes(&spNodeList);   //获取子结点列表

			long lCount;                                      
			hr = spNodeList->get_length(&lCount);

			for (long i=0; i<lCount; ++i)
			{
				MSXML2::IXMLDOMNodePtr spNode;
				MSXML2::DOMNodeType NodeType;
				MSXML2::IXMLDOMNodeListPtr spChildNodeList;

				hr = spNodeList->get_item(i, &spNode);    //获取结点

				hr = spNode->get_nodeType(&NodeType);     //获取结点信息的类型
				if (NODE_ELEMENT == NodeType)
				{
					hr = spNode->get_childNodes(&spChildNodeList);
					long childLen;
					hr = spChildNodeList->get_length(&childLen);

					for (int j=0; j<childLen; ++j)
					{
						MSXML2::IXMLDOMNodePtr spChildNode;
						CComVariant varChildNodeValue;
						hr = spChildNodeList->get_item(j, &spChildNode);

						/* decode
						n name
						t  type 0=Unknown 1=PVE 2=PVP 3=RP 4=RPPVP
						s  status 0=Unknown 1=Up 2=Down
						l  load 0=Unknown 1=Low 2=Medium 3=High
						*/
						spChildNode->Getattributes()->getNamedItem("n")->get_nodeValue(&varChildNodeValue);
						if ( (LPCTSTR)(_bstr_t)varChildNodeValue == sRealm ) {
							int i;
							spChildNode->Getattributes()->getNamedItem("t")->get_nodeValue(&varChildNodeValue);
							CString type;
							i = atoi((_bstr_t)varChildNodeValue);
							if ( i == 1 ) {
								type = _T("PVE");
							} else if ( i == 2 ) {
								type = _T("PVE");
							} else if ( i == 3 ) {
								type = _T("RP");
							} else if ( i == 4 ) {
								type = _T("RPPVP");
							} else {
								type = _T("Unknown");
							}
							spChildNode->Getattributes()->getNamedItem("s")->get_nodeValue(&varChildNodeValue);
							i = atoi((_bstr_t)varChildNodeValue);
							if ( i == 1 ) {
								mStatus = MAKEINTRESOURCE(IDR_GIFUP);
							} else if ( i == 2 ) {
								mStatus = MAKEINTRESOURCE(IDR_GIFDOWN);
							} else {
								mStatus = MAKEINTRESOURCE(IDR_GIFFAIL);
							}
							spChildNode->Getattributes()->getNamedItem("l")->get_nodeValue(&varChildNodeValue);
							CString load;
							i = atoi((_bstr_t)varChildNodeValue);
							if ( i == 1 ) {
								load = _T("Low");
							} else if ( i == 2 ) {
								load = _T("Medium");
							} else if ( i == 3 ) {
								load = _T("High");
							} else {
								load = _T("Unknown");
							}
							sStatus.Format(_T("Type: %s\r\nPopulation: %s"), type, load);
							break;
						}
						spChildNode.Release();
					}
				}
				spNode.Release();
				spChildNodeList.Release();
			}
			spNodeList.Release();
			spElement.Release();
			spDoc.Release();
		}
		::CoUninitialize();
	}


	CWoWCubeDlg *dlg = (CWoWCubeDlg *)((RealmInfo *)pRealm)->me;
	if ( dlg->m_Icon.Load(mStatus, _T("GIF")) )
	{
		dlg->m_Icon.SetBkColor(dlg->m_Icon.GetBkColor());
		dlg->m_Icon.Draw();
		dlg->m_pToolTip->AddTool(&dlg->m_Icon, sStatus);
		dlg->m_pToolTip->AddTool(&dlg->m_Name, sStatus);
		dlg->m_pToolTip->SetDelayTime(200);
		dlg->m_pToolTip->SetMaxTipWidth(200);
	}

	return 0;
}
