cultware.ui = { }
local ui = cultware.ui;
local functions = cultware.functions;
local library = loadstring(game:HttpGet("https://pastebin.com/raw/W7wZjEkT"))()

ui.debug = function(...)
    cultware.debug("UI", ...)
end

ui.ready = function()
    ui.debug("Starting...")

    local window = library:CreateWindow("cult.com", Vector2.new(492, 598), Enum.KeyCode.RightShift)
    local watermark = library:CreateWatermark("cult.com |{fps}| {game}")
    local tab1 = window:CreateTab("Aiming")
    local tab2 = window:CreateTab("Blatant")
    local tab3 = window:CreateTab("Visuals")
    local tab4 = window:CreateTab("Teleports")
    local tab5 = window:CreateTab("Miscellaneous")
    local sector1 = tab1:CreateSector("Aimbot")
    local sector2 = tab1:CreateSector("Aimbot Settings", "Right")
    local sector3 = tab1:CreateSector("Silent Aim")
    local sector4 = tab1:CreateSector("Silent Settings", "Right")
    local sector5 = tab1:CreateSector("Target Aim")
    local sector6 = tab1:CreateSector("Target Settings", "Right")
    local sector7 = tab1:CreateSector("Fov Settings")
    local TriggerBotSettings = tab1:CreateSector("Triggerbot", "Right")
    local Loadoptions = tab1:CreateSector("Load Modules", "Right")
    local sector8 = tab2:CreateSector("Movement", "Right")
    local sector9 = tab2:CreateSector("Blatent Anti Aim")
    local sector10 = tab2:CreateSector("Map Ground Cheats")
    local sector11 = tab2:CreateSector("Fake Lag")
    local sector12 = tab2:CreateSector("Tools")
    local sector13 = tab2:CreateSector("Anti Hit")
    local sector14 = tab2:CreateSector("Character", "Right")
    local sector15 = tab2:CreateSector("Human", "Right")
    local sector16 = tab2:CreateSector("Misc", "Right")
    local sector17 = tab2:CreateSector("Extra", "Right")
    local sector18 = tab3:CreateSector("Esp")
    local sector19 = tab4:CreateSector("Teleports")
    local sector20 = tab4:CreateSector("", "Right")
    local sector21 = tab5:CreateSector("Watermark")
    local sector22 = tab5:CreateSector("Field Of View")
    local sector23 = tab5:CreateSector("Custom Cursor")
    local sector24 = tab5:CreateSector("Character")
    local AnimationSector = tab5:CreateSector("Animations", "Right")

 sector1:AddToggle("Enabled", false, functions.AimingToggle)
 sector1:AddToggle("Assistance", false, functions.AssistToggle)
    

    ui.debug("Loaded!")
end

return ui.ready;
