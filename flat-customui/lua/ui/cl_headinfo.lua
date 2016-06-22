
local vector = FindMetaTable("Vector")

local function shadeColor(color)
  return Color(color.r*(.5), color.g*(.5), color.b*(.5), color.a)
end

local usermat = Material("icon16/user.png")
local icontb = {}
local function headui()
  local ply = LocalPlayer()
  for k, v in pairs(player.GetAll()) do
    if not v:Alive() then continue end
    if ply == v then continue end
    if v:GetMaterial() == "models/effects/vol_light001" then continue end -- will not display if the user is cloaked
    if ply:GetPos():Distance(v:GetPos()) > CUI.headinfodistance then continue end

    surface.SetFont("DNAScoreboard32")
    local tw, th = surface.GetTextSize(team.GetName(v:Team()))
    local tw2 = surface.GetTextSize(string.firstToUpper(v:GetNWString('usergroup')))
    local tw3 = surface.GetTextSize(v:Nick())
    local thoffset = 1
    th = th - thoffset
    local boxw = math.max(120, tw+20, tw2+20+24, tw3+20)
    local boxh = th*3+thoffset

    local offset = Vector(0, 0, 85)
    local ang = ply:EyeAngles()
    local pos = v:GetPos() + offset + ang:Up()

    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Right(), 90)

    if icontb[v:SteamID()] == nil then
      icontb[v:SteamID()] = Material("icon16/" ..(CUI.icons[v:SteamID()] or CUI.icons[v:GetNWString('usergroup')] or "user").. ".png")
    end

    cam.Start3D2D(pos, Angle(0, ang.y, 90), .1)
      draw.RoundedBox(0, boxw/2*-1, 0, boxw, boxh, Color(51, 102, 204))
      draw.RoundedBox(0, boxw/2*-1+5, th, boxw-10, th+thoffset, shadeColor(team.GetColor(v:Team())))
      local at = math.Clamp((v:Health()/100)*boxw-10, 0, boxw-10)
      draw.RoundedBox(0, boxw/2*-1+5, th, at, th+thoffset, team.GetColor(v:Team()))
      draw.SimpleText(v:Nick(), "DNAScoreboard32", 0, 0, color_white, TEXT_ALIGN_CENTER)
      draw.SimpleText(team.GetName(v:Team()), "DNAScoreboard32", 0, th, color_white, TEXT_ALIGN_CENTER)
      draw.SimpleText(string.firstToUpper(v:GetNWString('usergroup')), "DNAScoreboard32", 0+24-12, th*2, color_white, TEXT_ALIGN_CENTER)
      surface.SetDrawColor(255, 255, 255, 255)
      surface.SetMaterial(icontb[v:SteamID()])
      surface.DrawTexturedRect(tw2/2*-1-18, th*2+4, 24, 24)
    cam.End3D2D()
  end
end

-- refresh the icons in case of a group change every 2 minutes
timer.Create("ayyremoveicons", 120, 0, function()
  icontb = {}
end)

hook.Add("HUDDrawTargetID", "dontdothat", function() return true end)
hook.Add("PostDrawOpaqueRenderables", "initializeheadui", headui)
