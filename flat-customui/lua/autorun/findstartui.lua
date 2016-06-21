if CLIENT then

  surface.CreateFont("DNAScoreboard48", {

    font = "Roboto",
    size = 48,
    weight = 600,
    antialias = true

  })

  surface.CreateFont("DNAScoreboard32", {

    font = "Roboto",
    size = 32,
    weight = 600,
    antialias = true

  })

  surface.CreateFont("DNAScoreboard24", {

    font = "Roboto",
    size = 24,
    weight = 300,
    antialias = true

  })

  surface.CreateFont("DNAScoreboard18", {

    font = "Roboto",
    size = 18,
    weight = 300,
    antialias = true

  })

  surface.CreateFont("DNAScoreboard18BOLD", {

    font = "Roboto",
    size = 18,
    weight = 800,
    antialias = true

  })

end

function string.firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

if SERVER then
  AddCSLuaFile("ui/cl_config.lua")
elseif CLIENT then
  include("ui/cl_config.lua")
end

local function initializetab()
  if SERVER then
    AddCSLuaFile("ui/cl_tabmenu.lua")
  elseif CLIENT then
    include("ui/cl_tabmenu.lua")
  end
end

local function initializehud()
  if SERVER then
    AddCSLuaFile("ui/cl_hud.lua")
    AddCSLuaFile("ui/cl_headinfo.lua")
  elseif CLIENT then
    include("ui/cl_hud.lua")
    include("ui/cl_headinfo.lua")
  end
end

if SERVER then
  AddCSLuaFile("ui/cl_headinfo.lua")
elseif CLIENT then
  include("ui/cl_headinfo.lua")
end

local hide = {
	CHudHealth = true,
	CHudBattery = true,
  DarkRP_EntityDisplay = true,
  DarkRP_LocalPlayerHUD = true,
}

local function hsd( name )
  if hide[name] then return false end
end

hook.Add("HUDShouldDraw", "HideHUD", hsd)
hook.Add("InitPostEntity", "initializehud", initializehud)
hook.Add("PostGamemodeLoaded", "initializetab", initializetab)
