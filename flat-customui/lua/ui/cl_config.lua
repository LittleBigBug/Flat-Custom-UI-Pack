-- By LittleBigBug

CUI = {}

-- Groups that are allowed to see the staff controls on the tab menu.
CUI.staffgroups = {
  ["superadmin"] = true,
  ["admin"] = true,
  ["operator"] = true,
}

-- Icons to display
-- You can have either ulx groups or SteamIDs
-- SteamIDs are always checked first.
CUI.icons = {
  ["superadmin"] = "shield_add",
  ["admin"] = "shield",
  ["operator"] = "medal_gold_1",
  ["STEAM_0:0:52985450"] = "cog", -- LittleBigBug
}

-- The Distance you have to be from somebody to see their info above their head
CUI.headinfodistance = 260

-- Should we tell the user they are cloaked? (ULX)
CUI.showiscloaked = true

-- What should the title be on the tab menu?
CUI.tabtitle = GetHostName()
