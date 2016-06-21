if not CLIENT then return end

if DNA == nil then DNA = {} end
DNA.Scoreboard = {}

function GAMEMODE:ScoreboardShow()end
function GAMEMODE:ScoreboardHide()end

local selected = false
local selectply = nil

DNA.Scoreboard.Create = function()
  local sw = ScrW()
  local sh = ScrH()

  DNA.Scoreboard.Instance = vgui.Create("DFrame")
  local f = DNA.Scoreboard.Instance
  f:SetSize(sw*.8, sh*.8)
  f.x = f:GetWide()*-1
  f:SetTitle("")
  f:ShowCloseButton(false)
  f.Paint = function(self, w, h)
    draw.RoundedBox(0,0,0,w,h,Color(102, 153, 255))
    draw.RoundedBox(0,5,5,w-10,h/16,Color(51, 102, 204))
    draw.SimpleText(CUI.tabtitle,"DNAScoreboard32",w/2,15,color_white,TEXT_ALIGN_CENTER)
  end
  f.Think = function(self)
    f.x = Lerp(.3, f.x, ScrW()/2-self:GetWide()/2)
    f.y = ScrH()/2-self:GetTall()/2
  end

  local b = vgui.Create("DScrollPanel", f)
  b:SetSize(250, f:GetTall()-(f:GetTall()/16)-15)
  b:SetPos(f:GetWide()-5-b:GetWide(), f:GetTall()/16+10)
  b.open = false
  b.wide = not selected and 0 or b:GetWide()
  local bvar = b:GetVBar()
  bvar:SetWide( 5 )
  b.Paint = function(self, w, h)
    draw.RoundedBox(0,0+(w-self.wide),0,self.wide,h,Color(51, 102, 204))
    if selected then
      draw.SimpleText(selectply:Nick(), "DNAScoreboard24", w/2, 5, Color(255, 255, 255), TEXT_ALIGN_CENTER)
      draw.SimpleText("$" ..string.Comma(selectply:getDarkRPVar("money")), "DNAScoreboard18", w/2, 260, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
  end
  b.Think = function(self)
    if math.Round(self.wide) == self:GetWide() then
      self.open = true
    else
      self.open = false
    end
    if selected then
      self.wide = Lerp(.1, self.wide, self:GetWide())
      if not selectply:IsValid() then
        selected = false
        selectply = nil
      end
    end
    if not selected then
      self.wide = Lerp(.1, self.wide, 0)
      for k, v in pairs(b:GetChildren()) do
        v:Remove()
        v = nil
      end
    else
      if sdb == nil then
        sdb = vgui.Create("DButton", b)
        sdb:SetSize(b:GetWide()-20, 40)
        sdb:SetPos(10, 280)
        sdb:SetText("Copy SteamID")
        sdb.DoClick = function( button )
      		SetClipboardText(selectply:SteamID())
      	end
        sdb.Paint = function(self, w, h)
          draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
          draw.RoundedBox(0,0,0,w,5, Color(0, 25, 255))
        end

        sdb2 = vgui.Create("DButton", b)
        sdb2:SetSize(b:GetWide()-20, 40)
        sdb2:SetPos(10, 280+(45))
        sdb2:SetText("Open Profile")
        sdb2.DoClick = function( button )
      		gui.OpenURL("http://steamcommunity.com/profiles/" ..tostring(selectply:SteamID64()))
      	end
        sdb2.Paint = function(self, w, h)
          draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
          draw.RoundedBox(0,0,0,w,5, Color(0, 25, 255))
        end

        local ug = LocalPlayer():GetNWString('usergroup')

        if CUI.staffgroups[ug] then
          sdb4 = vgui.Create("DButton", b)
          sdb4:SetSize(b:GetWide()-20, 40)
          sdb4:SetPos(10, 280+(45*2))
          sdb4:SetText("Ban")
          sdb4.DoClick = function( button )
            -- Being lazy
            Derma_StringRequest(
            "Ban " ..selectply:Nick(),
            "Enter a reason for banning the player",
            "No Reason Entered",
            function(string)
              Derma_StringRequest(
              "Ban " ..selectply:Nick(),
              "Enter a time for banning the player (Leave 0 for perma)",
              "0",
              function(string2)
                RunConsoleCommand("ulx", "ban", selectply:Nick(), string2, string)
              end)
            end)
          end
          sdb4.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
            draw.RoundedBox(0,0,0,w,5, Color(0, 25, 255))
          end

          sdb3 = vgui.Create("DButton", b)
          sdb3:SetSize(b:GetWide()-20, 40)
          sdb3:SetPos(10, 280+(45*3))
          sdb3:SetText("Kick")
          sdb3.DoClick = function( button )
        		Derma_StringRequest(
            "Kick " ..selectply:Nick(),
            "Enter a reason for kicking",
            "No Reason Entered",
            function(string)
              RunConsoleCommand("ulx", "kick", selectply:Nick(), string)
            end)
        	end
          sdb3.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
            draw.RoundedBox(0,0,0,w,5, Color(0, 25, 255))
          end

          sdb5 = vgui.Create("DButton", b)
          sdb5:SetSize(b:GetWide()-20, 40)
          sdb5:SetPos(10, 280+(45*4))
          sdb5:SetText("Goto")
          sdb5.DoClick = function( button )
            RunConsoleCommand("ulx", "goto", selectply:Nick())
        	end
          sdb5.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
            draw.RoundedBox(0,0,0,w,5, Color(0, 25, 255))
          end

          sdb6 = vgui.Create("DButton", b)
          sdb6:SetSize(b:GetWide()-20, 40)
          sdb6:SetPos(10, 280+(45*5))
          sdb6:SetText("Bring")
          sdb6.DoClick = function( button )
            RunConsoleCommand("ulx", "bring", selectply:Nick())
        	end
          sdb6.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
            draw.RoundedBox(0,0,0,w,5, Color(0, 25, 255))
          end

          sdb8 = vgui.Create("DButton", b)
          sdb8:SetSize(b:GetWide()-20, 40)
          sdb8:SetPos(10, 280+(45*6))
          sdb8:SetText("Teleport and Jail")
          sdb8.DoClick = function( button )
            RunConsoleCommand("ulx", "jailtp", selectply:Nick())
          end
          sdb8.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
            draw.RoundedBox(0,0,0,w,5, Color(0, 25, 255))
          end
        end

        sdm = vgui.Create("DModelPanel", b)
        sdm:SetSize(b:GetWide(), 250)
        sdm:SetPos(0, 0)
        sdm.LayoutEntity = function(ent) return end

        cls = vgui.Create("DButton", b)
        cls:SetSize(18, 18)
        cls:SetPos(b:GetWide()-18-5, 5)
        cls:SetText("")
        cls.DoClick = function( button )
          selected = false
          selectply = nil
          sdb = nil
        end
        cls.Paint = function(self, w, h)
          draw.SimpleText("X", "DNAScoreboard18", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
      end
      if sdm ~= nil and sdm:IsValid() then sdm:SetModel(selectply:GetModel()) end
    end
  end

  DNA.Scoreboard.playerpanel = vgui.Create("DScrollPanel", f)
  DNA.Scoreboard.playerpanel:SetSize(f:GetWide()-10-b:GetWide()-5, f:GetTall()-(f:GetTall()/16)-15)
  DNA.Scoreboard.playerpanel.BaseWide = DNA.Scoreboard.playerpanel:GetWide()
  DNA.Scoreboard.playerpanel:SetPos(5, f:GetTall()/16+10)
  DNA.Scoreboard.playerpanel.Paint = function(self, w, h)
    draw.RoundedBox(0,0,0,w,h,Color(51, 102, 204))
  end
  DNA.Scoreboard.playerpanel.Think = function(self)
    self:SetWide(self.BaseWide+(b:GetWide()-b.wide+((math.Round(b.wide) == 0) and 5 or 0)))
  end
  scroll = DNA.Scoreboard.playerpanel:GetVBar()
  scroll:SetWide( 5 )

  local npl = player.GetAll()
  table.sort(npl, function( a, b ) return a:Team() > b:Team() end)

  local valid = 0

  for k, v in pairs(npl) do
    if IsValid( v ) and v ~= nil then
      valid = valid + 1
      local p = vgui.Create("DPanel", DNA.Scoreboard.playerpanel)
      p:SetSize(DNA.Scoreboard.playerpanel:GetWide()-10, 40)
      p:SetPos(5, 5+((p:GetTall()+5)*(valid-1)))
      p.Paint = function(self, w, h)
        if not IsValid( v ) then return end
        draw.RoundedBox(0,0,0,w,h,Color(255, 255, 255))
        draw.RoundedBox(0,0,0,w,5,team.GetColor(v:Team() or 1))

        draw.SimpleText(v:Nick(), "DNAScoreboard18", 32+15, 13, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.SimpleText(team.GetName(v:Team() or 1), "DNAScoreboard18", w/4, 13, team.GetColor(v:Team() or 1), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

        draw.SimpleText(string.firstToUpper(v:GetNWString('usergroup')), "DNAScoreboard18", w-123, 13, Color(0, 0, 0, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
        draw.SimpleText(v:Frags(), "DNAScoreboard18", w-83, 13, Color(0, 0, 0, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
        draw.SimpleText(v:Deaths(), "DNAScoreboard18", w-45, 13, Color(0, 0, 0, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
        draw.SimpleText(v:Ping(), "DNAScoreboard18", w-10, 13, Color(0, 0, 0, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
      end
      p.Think = function(self)
        self:SetWide(DNA.Scoreboard.playerpanel:GetWide()-10)
      end
      p.OnMousePressed = function(self)
        if selected then
          if selectply == v then return end
          selected = false
          selectply = nil
          sdb = nil
          timer.Simple(.5, function()
            selected = true
            selectply = v
          end)
        else
          selected = true
          selectply = v
        end
      end

      local a = vgui.Create("AvatarImage", p)
      a:SetSize(32, 32)
      a:SetPos(5, 13/2+.5)
      a:SetPlayer(v)
    end
  end

end

DNA.Scoreboard.Show = function()
  DNA.Scoreboard.Create()
  if not DNA.Hud == nil then DNA.Hud.Close(temp) end
  DNA.Scoreboard.Open()
end

DNA.Scoreboard.Open = function()
  gui.EnableScreenClicker(true)
end

DNA.Scoreboard.Hide = function()
  sdb = nil
  sdb2 = nil
  sdb3 = nil
  sdm = nil
  DNA.Scoreboard.Instance:Close()
  DNA.Scoreboard.Instance = nil
  gui.EnableScreenClicker(false)
end

hook.Add("ScoreboardShow", "DNA Scoreboard Show", DNA.Scoreboard.Show)
hook.Add("ScoreboardHide", "DNA Scoreboard Hide", DNA.Scoreboard.Hide)
