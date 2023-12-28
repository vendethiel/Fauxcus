Scorpio "Fauxcus" "0.1"

import "Scorpio.Secure"

__Sealed__()
class "FauxAuraPanelIcon" { Scorpio.Secure.UnitFrame.AuraPanelIcon }

local fauxFrame = InSecureUnitFrame("Fauxcus")
fauxFrame.Unit = "player"

BORDER_SIZE                     = 1
BAR_HEIGHT                      = 3
ICON_BORDER_SIZE                = 1

CLASSICFICATION_ELITE           = {
    elite                       = true,
    rare                        = true,
    rareelite                   = true,
    worldboss                   = true,
}

AURA_PANEL_ICON_DEBUFF_COLOR    = {
    ["none"]                    = Color(0.80, 0, 0),
    ["Magic"]                   = Color.MAGIC,
    ["Curse"]                   = Color.CURSE,
    ["Disease"]                 = Color.DISEASE,
    ["Poison"]                  = Color.POISON,
    [""]                        = DebuffTypeColor["none"],
}

AURA_PANEL_PLAYER_LOCATION      = { Anchor("BOTTOM", 0, 8, "HealthBar", "TOP") }
AURA_PANEL_NON_PLAYER_LOCATION  = { Anchor("BOTTOM", 0, 4, "NameLabel", "TOP") }

CASTBAR_NORMAL_COLOR            = Color.WHITE
CASTBAR_NONINTERRUPTIBLE_COLOR  = Color.DEATHKNIGHT

Style.UpdateSkin("Default", {
  [FauxAuraPanelIcon]          = {
    backdrop                = {
      edgeFile            = [[Interface\Buttons\WHITE8x8]],
      edgeSize            = BORDER_SIZE,
    },
    backdropBorderColor     = Wow.FromPanelProperty("AuraDebuff"):Map(function(dtype) return AURA_PANEL_ICON_DEBUFF_COLOR[dtype] or Color.WHITE end),

    -- Aura Icon
    IconTexture             = {
      drawLayer           = "BORDER",
      location            = { Anchor("TOPLEFT", BORDER_SIZE, -BORDER_SIZE), Anchor("BOTTOMRIGHT", -BORDER_SIZE, BORDER_SIZE) },
      file                = Wow.FromPanelProperty("AuraIcon"),
      texCoords           = RectType(0.1, 0.9, 0.1, 0.9),
    },

    -- Aura Count
    Label                   = {
      drawLayer           = "OVERLAY",
      fontObject          = NumberFontNormal,
      location            = { Anchor("CENTER", 0, 0, nil, "BOTTOMRIGHT") },
      text                = Wow.FromPanelProperty("AuraCount"):Map(function(val) return val and val > 1 and val or "" end),
    },

    -- Stealable
    MiddleBGTexture         = {
      drawLayer           = "OVERLAY",
      file                = [[Interface\TargetingFrame\UI-TargetingFrame-Stealable]],
      alphaMode           = "ADD",
      location            = { Anchor("TOPLEFT", -BORDER_SIZE, BORDER_SIZE), Anchor("BOTTOMRIGHT", BORDER_SIZE, -BORDER_SIZE) },
      visible             = Wow.FromPanelProperty("AuraStealable"),
    },

    -- Duration
    CooldownLabel           = {
      fontObject          = NumberFontNormal,
      cooldown            = Wow.FromPanelProperty("AuraCooldown"),
    },
  },
})


Style[fauxFrame]             = {
  location                    = { Anchor("CENTER") },
  size                        = Size(120, 36),

  healthBar                   = {
    setAllPoints            = true,

    frameStrata             = "LOW",
    enableMouse             = false,
    statusBarTexture        = {
      file                = [[Interface\Buttons\WHITE8x8]]
    },

    value                   = Wow.UnitHealth(),
    minMaxValues            = Wow.UnitHealthMax(),
    statusBarColor          = Wow.UnitColor(),

    backgroundFrame         = {
      frameStrata         = "BACKGROUND",
      location            = { Anchor("TOPLEFT", -1, 1), Anchor("BOTTOMRIGHT", 1, -1) },
      backgroundTexture   = {
        drawLayer       = "BACKGROUND",
        setAllPoints    = true,
        color           = Color(0.2, 0.2, 0.2, 0.8),
      },
      backdrop            = {
        edgeFile        = [[Interface\Buttons\WHITE8x8]],
        edgeSize        = 1,
      },

      backdropBorderColor = Color.BLACK,
    },
  },

  nameLabel                   = {
    location                = { Anchor("CENTER") },

    drawLayer               = "BORDER",
    fontObject              = GameFontNormalSmall,
    text                    = Wow.UnitName(true),
    textColor               = Wow.UnitColor(),
  },
  CastBar                 = {
    SHARE_STATUSBAR_SKIN,

    backgroundFrame     = {
      backdropBorderColor = Wow.UnitIsTarget():Map(function(val) return val and Color.WHITE or Color.BLACK end),
    },

    frameStrata         = "HIGH",
    statusBarColor      = Color.MAGE,

    height              = BAR_HEIGHT,
    location            = { Anchor("TOPLEFT", 0, -BORDER_SIZE, nil, "BOTTOMLEFT"), Anchor("RIGHT") },

    CooldownLabel       = {
      fontObject      = TextStatusBarText,
      location        = { Anchor("LEFT", 0, 0, nil, "RIGHT")},
      autoColor       = false,
      justifyH        = "LEFT",
      cooldown        = Wow.UnitCastCooldown(),
    },

    RightBGTexture      = {
      file            = [[Interface\CastingBar\UI-CastingBar-Spark]],
      alphaMode       = "ADD",
      location        = { Anchor("LEFT", -16, 0), Anchor("TOP", 0, 4), Anchor("BOTTOM", 0, -4) },
      size            = Size(32, 32),
    },

    Label               = {
      justifyH        = "CENTER",
      drawLayer       = "OVERLAY",
      fontObject      = GameFontHighlight,
      location        = { Anchor("CENTER") },
      text            = Wow.UnitCastName(),
    },

    Label2              = {
      justifyH        = "LEFT",
      drawLayer       = "OVERLAY",
      fontObject      = GameFontHighlight,
      location        = { Anchor("LEFT", 0, 0, "CooldownLabel", "RIGHT") },
      textColor       = Color.RED,
      text            = Wow.UnitCastDelay():Map(function(delay) return delay and delay > 0 and ("(+%.1f)"):format(delay) or "" end),
    },

    IconFrame           = {
      size            = Size(16, 16),
      location        = { Anchor("RIGHT", -2, BAR_HEIGHT, nil, "LEFT") },
      frameStrata     = "BACKGROUND",
      backdrop        = {
        edgeFile    = [[Interface\ChatFrame\CHATFRAMEBACKGROUND]],
        edgeSize    = ICON_BORDER_SIZE,
      },
      backdropBorderColor = Wow.UnitCastInterruptible():Map(function(val) return val and CASTBAR_NORMAL_COLOR or CASTBAR_NONINTERRUPTIBLE_COLOR end),

      IconTexture     = {
        file        = Wow.UnitCastIcon(),
        location    = { Anchor("TOPLEFT", ICON_BORDER_SIZE, -ICON_BORDER_SIZE), Anchor("BOTTOMRIGHT", -ICON_BORDER_SIZE, ICON_BORDER_SIZE) },
        texCoords   = RectType(0.1, 0.9, 0.1, 0.9),
      }
    },
  },
  AuraPanel               = {
    elementType         = FauxAuraPanelIcon,
    rowCount            = 3,
    columnCount         = 4,
    elementWidth        = 18,
    elementHeight       = 18,
    orientation         = Orientation.HORIZONTAL,
    topToBottom         = false,
    leftToRight         = true,
    location            = Wow.UnitIsPlayer():Map(function(isPlayer) return isPlayer and AURA_PANEL_PLAYER_LOCATION or AURA_PANEL_NON_PLAYER_LOCATION end),

    auraFilter          = Wow.Unit():Map(function(unit)
      return UnitIsUnit("player", unit) and "HELPFUL|INCLUDE_NAME_PLATE_ONLY"
      or (UnitReaction("player", unit) or 99) <= 4 and "HARMFUL|PLAYER|INCLUDE_NAME_PLATE_ONLY"
      or ""
    end),

    customFilter        = function(name, icon, count, dtype, duration) return duration and duration > 0 and duration <= 60 end,
  },
}

struct "SpellMacro" (function (_ENV)
  Spell = String
  Macro = String
end)

local wanted = ''

function UpdateMacro(unit, s)
  local macro = s[1] -- s.Macro
  local spell = s[2] -- s.Spell
  local body = "/use [@" .. unit .. "] " .. spell
  --print('macro '..macro..', '..body..", "..(GetMacroInfo(macro) or "nil"))
  if GetMacroInfo(macro) then
    local r = EditMacro(macro, macro, nil, body, 1)
  else
    local r = CreateMacro(macro, "INV_Misc_QuestionMark", body, false)
  end
end

function UpdateMacros(unit, spells)
  for _, spell in pairs(spells) do
    UpdateMacro(unit, spell)
  end
end

local _last
function SetUnit(unit)
  if _last == unit then return end
  _last = unit

  -- TODO when Scorpio is updated to v159, use a Subject instead, and listen to the subject for macro updates
  fauxFrame.Unit = unit
  UpdateMacros(unit, FAUXCUS_SPELLS or _Config.spells or {})
end

__NoCombat__()
__SystemEvent__ "NAME_PLATE_UNIT_ADDED" "NAME_PLATE_UNIT_REMOVED"
function refresh()
  -- No self-nameplate
  if wanted == 'player' or wanted == UnitName('player') then
    SetUnit('player')
    return
  end

  for i = 1, 4 do
    if UnitName('party'..i) == wanted then
      SetUnit('party'..i)
      return
    end
  end

  for i = 1, 40 do
    if UnitName('raid'..i) == wanted then
      SetUnit('raid'..i)
      return
    end
  end


  for _, n in pairs(C_NamePlate.GetNamePlates(true)) do
    if UnitName(n.namePlateUnitToken) == wanted then
      SetUnit(n.namePlateUnitToken)
      return
    end
  end
end

__NoCombat__()
__SlashCmd__ "fauxcus"
function FauxcusTarget()
  wanted = UnitName('target') or UnitName('player')
  refresh()
end

__NoCombat__()
__SlashCmd__ "fauxcusmo"
function FauxcusMouseover()
  wanted = UnitName('mouseover')
  refresh()
end

-- Config stuff
function OnLoad()
  _Addon:SetSavedVariable("FauxcusDB")
        :SetCharSavedVariable("FauxcusCharDB")
        :UseConfigPanel(true)
  --SetLocation(_Config.location or {x=0, y=0})
  --UpdateMacros('player', _CharConfig.spells or {})
end

__Config__(_Config, "location", { x = Number, y = Number }, { x = 0, y = 0 })
function SetLocation(pos)
  Style[fauxFrame].location = { Anchor("CENTER", pos.x, pos.y) }
end

--__Config__(_Config, "spells", { { SpellMacro } }, { })
--function SetSpells(spells)
--  print(Toolset.tostring(spells or {}, nil, true))
--  UpdateMacros(_last, spells and spells.sms or {})
--end

__SlashCmd__ "faux"
function FauxCmd()
  _Addon:ShowConfigUI()
end
