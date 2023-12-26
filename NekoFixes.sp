#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <dhooks>

public Plugin myinfo =
{
	name		= "Neko L4D2 DOS Fix",
	author		= "Neko Channel / LynchMus",
	description = "Fix SB DOS",
	version		= "N1.0",
	url			= "https://himeneko.cn"
};

public void OnPluginStart()
{
	GameData hGameData = new GameData("NekoFixes");
	if (hGameData == null)
	{
		SetFailState("Failed to load atest gamedata.");
		return;
	}

	// NET_QueuePacket Detour (Fix SB DOS) 其他游戏请自行寻签名
	DynamicDetour hNET_QueuePacketDetour = DynamicDetour.FromConf(hGameData, "NET_QueuePacket");
	if (!hNET_QueuePacketDetour.Enable(Hook_Pre, NET_QueuePacket))
		SetFailState("Failed to setup detour for NET_QueuePacket");
}

public MRESReturn NET_QueuePacket(DHookReturn hReturn, DHookParam hParams)
{
	hReturn.Value = true;
	return MRES_Supercede;
}