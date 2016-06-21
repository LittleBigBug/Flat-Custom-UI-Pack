local function shadeColor(color)
  return Color(color.r*(.5), color.g*(.5), color.b*(.5), color.a)
end

local function drawBarThing(w, h, a, c, c2, x, y, full)
  if full == nil then full = 100 end
  draw.RoundedBox(0, x, y, w, h, c)
  local at = math.Clamp((a/full)*w, 0, w)
  draw.RoundedBox(0, x, y, at, h, c2)
  draw.RoundedBox(0, x, y+h-h/5, at, h/5, shadeColor(c2))
end

local ply = LocalPlayer()

local health = 0
local armor = 0
local money = 0
local salary = 0
local xp = 0
local xpt = 0
local function drawHud()
  if ply:IsValid() then
    scrh = ScrH()
    scrw = ScrW()
    w = scrw
    h = 30

    if ply:GetMaterial() == "models/effects/vol_light001" and CUI.showiscloaked then
      draw.SimpleText("You are cloaked!", "DNAScoreboard24", ScrW()/2, ScrH()-35, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
    end

    local oct1 = {
      -- Left Side
      {x = 0, y = scrh},
      {x = 0, y = scrh-h/2},
      {x = 10, y = scrh-h},
      -- Right Side
      {x = scrw-10, y = scrh-h},
      {x = scrw, y = scrh-h/2},
      {x = scrw, y = scrh}
    }

    draw.RoundedBox(0, 0, scrh-(h+5), w, h+5, Color(102, 153, 255))

    --[[
    draw.RoundedBox(0, 10, scrh-h, w-10, h, Color(51, 102, 204))
    ]]

    surface.SetDrawColor(51, 102, 204)
    draw.NoTexture()
    surface.DrawPoly(oct1)

    drawBarThing(200, 20, health, Color(0, 0, 0, 250), Color(255, 20, 20), w/2-200/2-200*3+100, scrh-20-5)
    local text = "Health:"
    surface.SetFont("DNAScoreboard18BOLD")
    local tw, th = surface.GetTextSize(text)
    draw.SimpleText(text, "DNAScoreboard18BOLD", w/2-200/2+5-200*3+100, scrh-20-5, color_white)
    draw.SimpleText(math.Round(math.max(0, health)).. "%", "DNAScoreboard18", w/2-200/2+14+tw-200*3+100, scrh-20-5, color_white)

    text = "Money:"
    surface.SetFont("DNAScoreboard18BOLD")
    tw, th = surface.GetTextSize(text)
    draw.SimpleText(text, "DNAScoreboard18BOLD", w/2-200/2-200*2+7+10+100, scrh-20-5, color_white)
    draw.SimpleText("$" ..string.Comma(math.Round(math.max(0, money))), "DNAScoreboard18", w/2-200/2+14+tw-200*2+100+14, scrh-20-5, color_white)

    text = "Salary:"
    surface.SetFont("DNAScoreboard18BOLD")
    tw, th = surface.GetTextSize(text)
    draw.SimpleText(text, "DNAScoreboard18BOLD", w/2-200/2-200+10+100 , scrh-20-5, color_white)
    draw.SimpleText("+$" ..string.Comma(math.Round(math.max(0, salary))), "DNAScoreboard18", w/2-200/2+14+tw-200+100, scrh-20-5, color_white)

    text = "Job:"
    surface.SetFont("DNAScoreboard18BOLD")
    tw, th = surface.GetTextSize(text)
    draw.SimpleText(text, "DNAScoreboard18BOLD", w/2-200/2+200-100, scrh-20-5, color_white)
    draw.SimpleText(team.GetName(ply:Team()), "DNAScoreboard18", w/2-200/2+200+tw+7+5-100, scrh-20-5, color_white)

    text = "Name:"
    surface.SetFont("DNAScoreboard18BOLD")
    tw, th = surface.GetTextSize(text)
    draw.SimpleText(text, "DNAScoreboard18BOLD", w/2-200/2+200*2-100, scrh-20-5, color_white)
    draw.SimpleText(ply:Nick(), "DNAScoreboard18", w/2-200/2+200*2+tw+7+5-100, scrh-20-5, color_white)

    drawBarThing(200, 20, armor, Color(0, 0, 0, 250), Color(20, 20, 255), w/2-200/2+200*3-100, scrh-20-5)
    local text = "Armor:"
    surface.SetFont("DNAScoreboard18BOLD")
    local tw, th = surface.GetTextSize(text)
    draw.SimpleText(text, "DNAScoreboard18BOLD", w/2-200/2+200*3-100+5, scrh-20-5, color_white)
    draw.SimpleText(math.Round(math.max(0, armor)).. "%", "DNAScoreboard18", w/2-200/2+200*3+tw+7+5-100, scrh-20-5, color_white)

    drawBarThing(ScrW()*.8, 10, xp, color_white, Color(51, 102, 204, 255), w/2-(ScrW()*.8)/2, 10, xpt)
    draw.SimpleText(tostring(math.Round(xp)) .."/".. tostring(math.Round(xpt)), "DNAScoreboard18", w/2, 10+10, color_white, TEXT_ALIGN_CENTER)
    draw.SimpleText(tostring(ply:GetNWInt("level")), "DNAScoreboard24", w/2, 10+10+18, color_white, TEXT_ALIGN_CENTER)

    health = Lerp(0.1, health, ply:Health())
    armor = Lerp(0.1, armor, ply:Armor())
    money = Lerp(0.1, money, ply:getDarkRPVar("money") or 0)
    salary = Lerp(0.1, salary, ply:getDarkRPVar("salary") or 0)
    xp = Lerp(0.1, xp, ply:GetNWInt("XP") or 0 )
    xpt = Lerp(0.1, xpt, ply:GetNWInt("XPToLevelUp") or 0)
  end
end

hook.Add("HUDPaint", "randomshud", drawHud)
