cultware.functions = { }
local functions = cultware.functions
local modules = cultware.modules

functions.debug = function(...)
    cultware.debug("Functions", ...)
end

functions.ready = function()
    functions.debug("Starting...")

    local OldAimPart = "Head"
    local AimPart = "Head"
    local AimRadius = 30
    local ThirdPerson = true
    local FirstPerson = true
    local TeamCheck = false
    local PredictMovement = true
    local PredictionVelocity = 10
    local CheckIfJumped = true
    local Smoothness = false
    local SmoothnessAmount = 0.035
    local FakeLagSpeed = 0.000001

    local services = setmetatable({ }, {
        __index = function(t,k)
            return game:GetService(k)
        end
    })
    local Players = services.Players
    local Uis = services.UserInputService
    local Workspace = services.Workspace
    local RService = services.RunService
    local SGui = services.StarterGui

    local Client = Players.LocalPlayer
    local Character = Client.Character
    local Mouse = Client:GetMouse()
    local Camera = Workspace.CurrentCamera
    
    local CF = CFrame.new
    local RNew = Ray.new
    local Vec3 = Vector3.new
    local Vec2 = Vector2.new

    local Aimlock, MousePressed, CanNotify = false, false, false
    local AimlockTarget, OldPre

    local CiazwareUniversalAimbotLoaded = true

    local Target, PartMode, Partz, NotifMode, Prediction
    local SpinBotSpeed

    local GetNearestTarget = function()
        local plr = nil;
        local distance = 99999;
        
        for i, v in next, Players:GetPlayers() do
            if v.Name ~= Client.Name then
                if v.Character and v.Team ~= Client.Team then
                    local pos,aaaa = Camera:WorldToViewportPoint(v.Character.Head.Position);
                    local mouse = Uis:GetMouseLocation()
                    local magnitude = (Vec2(pos.X, pos.Y) - Vec2(mouse.X, mouse.Y)).magnitude;
    
                    if aaaa and (magnitude < distance) then
                        plr = v;
                        distance = magnitude;
                    end
                end
            end
        end
        
        return plr;
    end

    Uis.InputBegan:connect(function(key)
        if not (Uis:GetFocusedTextBox()) then
            if key.UserInputType == Enum.UserInputType.MouseButton2 and AimlockTarget == nil then
                warn'ayo'
                if MousePressed ~= true then MousePressed = true end 
                local Target;Target = GetNearestTarget()
                print(Target)
                if Target ~= nil then
                    AimlockTarget = Target
                end
            elseif key.UserInputType == Enum.UserInputType.MouseButton2 and AimlockTarget ~= nil then
                if AimlockTarget ~= nil then AimlockTarget = nil end
                if MousePressed ~= false then 
                    MousePressed = false 
                end
            end
        end
    end)
    
    RService.RenderStepped:Connect(function()
        if ThirdPerson == true and FirstPerson == true then 
            if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 or (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1 then 
                CanNotify = true 
            else 
                CanNotify = false 
            end
        elseif ThirdPerson == true and FirstPerson == false then 
            if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 then 
                CanNotify = true 
            else 
                CanNotify = false 
            end
        elseif ThirdPerson == false and FirstPerson == true then 
            if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1 then 
                CanNotify = true 
            else 
                CanNotify = false 
            end
        end
        if Aimlock == true and MousePressed == true then 
            if AimlockTarget and AimlockTarget.Character and AimlockTarget.Character:FindFirstChild(AimPart) then 
                if FirstPerson == true then
                    if CanNotify == true then
                        if PredictMovement == true then
                            if Smoothness == true then
                                --// The part we're going to lerp/smoothen \\--
                                local Main = CF(Camera.CFrame.p, AimlockTarget.Character[AimPart].Position + AimlockTarget.Character[AimPart].Velocity/PredictionVelocity)
                                
                                --// Making it work \\--
                                Camera.CFrame = Camera.CFrame:Lerp(Main, SmoothnessAmount, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut)
                            else
                                Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[AimPart].Position + AimlockTarget.Character[AimPart].Velocity/PredictionVelocity)
                            end
                        elseif PredictMovement == false then 
                            if Smoothness == true then
                                --// The part we're going to lerp/smoothen \\--
                                local Main = CF(Camera.CFrame.p, AimlockTarget.Character[AimPart].Position)
    
                                --// Making it work \\--
                                Camera.CFrame = Camera.CFrame:Lerp(Main, SmoothnessAmount, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut)
                            else
                                Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[AimPart].Position)
                            end
                        end
                    end
                end
            end
        end
         if CheckIfJumped == true and AimlockTarget then
       if AimlockTarget.Character.Humanoid.FloorMaterial == Enum.Material.Air then
    
           AimPart = "RightFoot"
       else
         AimPart = OldAimPart
    
       end
    end
    end)

    local AnimationModule = {
        Astronaut = {
            "rbxassetid://891621366",
            "rbxassetid://891633237",
            "rbxassetid://891667138",
            "rbxassetid://891636393",
            "rbxassetid://891627522",
            "rbxassetid://891609353",
            "rbxassetid://891617961"
        },
        Bubbly = {
            "rbxassetid://910004836",
            "rbxassetid://910009958",
            "rbxassetid://910034870",
            "rbxassetid://910025107",
            "rbxassetid://910016857",
            "rbxassetid://910001910",
            "rbxassetid://910030921",
            "rbxassetid://910028158"
        },
        Cartoony = {
            "rbxassetid://742637544",
            "rbxassetid://742638445",
            "rbxassetid://742640026",
            "rbxassetid://742638842",
            "rbxassetid://742637942",
            "rbxassetid://742636889",
            "rbxassetid://742637151"
        },
        Confindent = {
            "rbxassetid://1069977950",
            "rbxassetid://1069987858",
            "rbxassetid://1070017263",
            "rbxassetid://1070001516",
            "rbxassetid://1069984524",
            "rbxassetid://1069946257",
            "rbxassetid://1069973677"
        },
        Cowboy = {
            "rbxassetid://1014390418",
            "rbxassetid://1014398616",
            "rbxassetid://1014421541",
            "rbxassetid://1014401683",
            "rbxassetid://1014394726",
            "rbxassetid://1014380606",
            "rbxassetid://1014384571"
        },
        Default = {
            "http://www.roblox.com/asset/?id=507766666",
            "http://www.roblox.com/asset/?id=507766951",
            "http://www.roblox.com/asset/?id=507777826",
            "http://www.roblox.com/asset/?id=507767714",
            "http://www.roblox.com/asset/?id=507765000",
            "http://www.roblox.com/asset/?id=507765644",
            "http://www.roblox.com/asset/?id=507767968"
        },
        Elder = {
            "rbxassetid://845397899",
            "rbxassetid://845400520",
            "rbxassetid://845403856",
            "rbxassetid://845386501",
            "rbxassetid://845398858",
            "rbxassetid://845392038",
            "rbxassetid://845396048"
        },
        Ghost = {
            "rbxassetid://616006778",
            "rbxassetid://616008087",
            "rbxassetid://616013216",
            "rbxassetid://616013216",
            "rbxassetid://616008936",
            "rbxassetid://616005863",
            "rbxassetid://616012453",
            "rbxassetid://616011509"
        },
        Knight = {
            "rbxassetid://657595757",
            "rbxassetid://657568135",
            "rbxassetid://657552124",
            "rbxassetid://657564596",
            "rbxassetid://658409194",
            "rbxassetid://658360781",
            "rbxassetid://657600338"
        },
        Levitation = {
            "rbxassetid://616006778",
            "rbxassetid://616008087",
            "rbxassetid://616013216",
            "rbxassetid://616010382",
            "rbxassetid://616008936",
            "rbxassetid://616003713",
            "rbxassetid://616005863"
        },
        Mage = {
            "rbxassetid://707742142",
            "rbxassetid://707855907",
            "rbxassetid://707897309",
            "rbxassetid://707861613",
            "rbxassetid://707853694",
            "rbxassetid://707826056",
            "rbxassetid://707829716"
        },
        Ninja = {
            "rbxassetid://656117400",
            "rbxassetid://656118341",
            "rbxassetid://656121766",
            "rbxassetid://656118852",
            "rbxassetid://656117878",
            "rbxassetid://656114359",
            "rbxassetid://656115606"
        },
        OldSchool = {
            "rbxassetid://5319828216",
            "rbxassetid://5319831086",
            "rbxassetid://5319847204",
            "rbxassetid://5319844329",
            "rbxassetid://5319841935",
            "rbxassetid://5319839762",
            "rbxassetid://5319852613",
            "rbxassetid://5319850266"
        },
        Patrol = {
            "rbxassetid://1149612882",
            "rbxassetid://1150842221",
            "rbxassetid://1151231493",
            "rbxassetid://1150967949",
            "rbxassetid://1148811837",
            "rbxassetid://1148811837",
            "rbxassetid://1148863382"
        },
        Pirtate = {
            "rbxassetid://750781874",
            "rbxassetid://750782770",
            "rbxassetid://750785693",
            "rbxassetid://750783738",
            "rbxassetid://750782230",
            "rbxassetid://750779899",
            "rbxassetid://750780242"
        },
        Popstar = {
            "rbxassetid://1212900985",
            "rbxassetid://1150842221",
            "rbxassetid://1212980338",
            "rbxassetid://1212980348",
            "rbxassetid://1212954642",
            "rbxassetid://1213044953",
            "rbxassetid://1212900995"
        },
        Princess = {
            "rbxassetid://941003647",
            "rbxassetid://941013098",
            "rbxassetid://941028902",
            "rbxassetid://941015281",
            "rbxassetid://941008832",
            "rbxassetid://940996062",
            "rbxassetid://941000007"
        },
        Robot = {
            "rbxassetid://616088211",
            "rbxassetid://616089559",
            "rbxassetid://616095330",
            "rbxassetid://616091570",
            "rbxassetid://616090535",
            "rbxassetid://616086039",
            "rbxassetid://616087089"
        },
        Rthro = {
            "rbxassetid://2510196951",
            "rbxassetid://2510197257",
            "rbxassetid://2510202577",
            "rbxassetid://2510198475",
            "rbxassetid://2510197830",
            "rbxassetid://2510195892",
            "rbxassetid://02510201162",
            "rbxassetid://2510199791",
            "rbxassetid://2510192778"
        },
        Sneaky = {
            "rbxassetid://1132473842",
            "rbxassetid://1132477671",
            "rbxassetid://1132510133",
            "rbxassetid://1132494274",
            "rbxassetid://1132489853",
            "rbxassetid://1132461372",
            "rbxassetid://1132469004"
        },
        Stylish = {
            "rbxassetid://616136790",
            "rbxassetid://616138447",
            "rbxassetid://616146177",
            "rbxassetid://616140816",
            "rbxassetid://616139451",
            "rbxassetid://616133594",
            "rbxassetid://616134815"
        },
        Superhero = {
            "rbxassetid://782841498",
            "rbxassetid://782845736",
            "rbxassetid://782843345",
            "rbxassetid://782842708",
            "rbxassetid://782847020",
            "rbxassetid://782843869",
            "rbxassetid://782846423"
        },
        Toy = {
            "rbxassetid://782841498",
            "rbxassetid://782845736",
            "rbxassetid://782843345",
            "rbxassetid://782842708",
            "rbxassetid://782847020",
            "rbxassetid://782843869",
            "rbxassetid://782846423"
        },
        Vampire = {
            "rbxassetid://1083445855",
            "rbxassetid://1083450166",
            "rbxassetid://1083473930",
            "rbxassetid://1083462077",
            "rbxassetid://1083455352",
            "rbxassetid://1083439238",
            "rbxassetid://1083443587"
        },
        Werewolf = {
            "rbxassetid://1083195517",
            "rbxassetid://1083214717",
            "rbxassetid://1083178339",
            "rbxassetid://1083216690",
            "rbxassetid://1083218792",
            "rbxassetid://1083182000",
            "rbxassetid://1083189019"
        },
        Zombie = {
            "rbxassetid://616158929",
            "rbxassetid://616160636",
            "rbxassetid://616168032",
            "rbxassetid://616163682",
            "rbxassetid://616161997",
            "rbxassetid://616156119",
            "rbxassetid://616157476"
        }
    }
    local AnimationsName = {
        "Astronaut",
        "Bubbly",
        "Cartoony",
        "Confindent",
        "Cowboy",
        "Default",
        "Elder",
        "Ghost",
        "Knight",
        "Levitation",
        "Mage",
        "Ninja",
        "OldSchool",
        "Patrol",
        "Pirate",
        "Popstar",
        "Princess",
        "Robot",
        "Rthro",
        "Sneaky",
        "Stylish",
        "Superhero",
        "Toy",
        "Vampire",
        "Werewolf",
        "Zombie"
    }
    local AnimationState = {
        Idle = "Default",
        Walk = "Default",
        Run = "Default",
        Jump = "Default",
        Climb = "Default",
        Fall = "Default"
    }

    functions.AimingToggle = function(AimT)
        Aimlock = AimT
    end

    functions.AssistToggle = function(AssistT)
        Smoothness = AssistT 
    end

    functions.CheckPredictionA = function(PredictionA)
        PredictMovement = PredictionA
    end

    functions.TeamCheckA = function(TeamA)
        TeamCheck = TeamA
    end

    functions.AimPartA = function(AimPartAA)
        AimPart = AimPartAA
        OldAimPart = AimPartAA
    end

    functions.PingBasedA = function(AutoPreA)
        AutoPrediction = AutoPreA
    end

    functions.AimingRadius = function(AimingRadiusA)
        AimRadius = AimingRadiusA
    end

    functions.AimingPrediction = function(AimingPredictionA)
        PredictionVelocity = AimingPredictionA
    end

    functions.SilentToggle = function(SilentT)
        DaHoodSettings.SilentAim = SilentT
    end

    functions.SilentWall = function(SetWall)
        Aiming.VisibleCheck = SetWall
    end

    functions.SilentTeam = function(SetTeam)
        Aiming.TeamCheck = SetTeam
    end

    functions.SilentPart = function(SetPart)
        Aiming.TargetPart = SetPart
    end

    functions.SilentVisiblity = function(SetVis)
        Aiming.ShowFOV = SetVis
    end

    functions.SilentVisiblityColor = function(Color)
        Aiming.FOVColour = Color
    end

    functions.SilentPrediction = function(SilentPredictionS)
        DaHoodSettings.Prediction = SilentPredictionS
    end

    functions.SilentAiming = function(SetRadiusS)
        Aiming.FOV = SetRadiusS
    end

    functions.SilentChance = function(SilentChanceS)
        Aiming.HitChance = SilentChanceS
    end

    functions.TargetToggle = function(TargetToggleE)
        Target = TargetToggleE
    end

    functions.TargetHitBoxShow = function(TargetShowBox)
        PartMode = TargetShowBox
    end

    functions.TargetDropdown = function(TargetHitbox)
        Partz = TargetHitbox
    end

    functions.TargetNotifications = function(TargetNotificationsT)
        NotifMode = TargetNotificationsT
    end

    functions.TargetPrediction = function(TargetPredictionT)
        Prediction = TargetPredictionT
    end

    local circle = Drawing.new("Circle")
    circle.Color = Color3.fromRGB(204, 43, 94)
    circle.Thickness = 0.1
    circle.NumSides = 350
    circle.Radius = 50
    circle.Transparency = 0.3
    circle.Visible = false
    circle.Filled = false

    RService.RenderStepped:Connect(function()
        circle.Position = Vec2(Mouse.X, Mouse.Y + 40)
    end)
    
    functions.FovVisiblitity = function(FovVisiblitityF)
        circle.Visible = FovVisiblitityF
    end

    functions.FovVisiblitityColor = function(FovColor)
        circle.Color = FovColor
    end

    functions.FovFilled = function(FovFilledF)
        circle.Filled = FovFilledF
    end

    functions.FovSizeRadius = function(FovSizeRadiusF)
        circle.Radius = FovSizeRadiusF
    end

    functions.FovSideNumbers = function(FovSideNumbersF)
        circle.NumSides = FovSideNumbersF
    end

    functions.FovTransparency = function(FovTransparencyF)
        circle.Transparency = FovTransparencyF/10
    end

    local TriggerBotDelay = 0.1
    functions.TriggerBotSettingsT = function(state)
        if state then
            repeat
                wait(TriggerBotDelay)
                local target = mouse.Target
                local parent = target.Parent;
                if target and parent:IsA("Model") then
                    for i, v in pairs(Players:GetChildren()) do
                        if v.Name == parent.Name or v.Name == parent.Parent.Name then
                            mouse1click()
                        end
                    end
                end
            until not state
        end
    end

    functions.TriggerBotSettingsD = function(TriggerBotSettingsDE)
        TriggerBotDelay = TriggerBotSettingsDE/10
    end

    functions.Silent = function()
        if getgenv().Aiming then return getgenv().Aiming end

        local GuiService = game:GetService("GuiService")
        local RunService = game:GetService("RunService")

        -- // Vars
        local Heartbeat = RunService.Heartbeat
        local LocalPlayer = Players.LocalPlayer
        local CurrentCamera = Workspace.CurrentCamera
        local Mouse = LocalPlayer:GetMouse()

        -- // Optimisation Vars (ugly)
        local Drawingnew = Drawing.new
        local Color3fromRGB = Color3.fromRGB
        local Vector2new = Vector2.new
        local GetGuiInset = GuiService.GetGuiInset
        local Randomnew = Random.new
        local mathfloor = math.floor
        local CharacterAdded = LocalPlayer.CharacterAdded
        local CharacterAddedWait = CharacterAdded.Wait
        local WorldToViewportPoint = CurrentCamera.WorldToViewportPoint
        local RaycastParamsnew = RaycastParams.new
        local EnumRaycastFilterTypeBlacklist = Enum.RaycastFilterType.Blacklist
        local Raycast = Workspace.Raycast
        local GetPlayers = Players.GetPlayers
        local Instancenew = Instance.new
        local IsDescendantOf = Instancenew("Part").IsDescendantOf
        local FindFirstChildWhichIsA = Instancenew("Part").FindFirstChildWhichIsA
        local FindFirstChild = Instancenew("Part").FindFirstChild
        local tableremove = table.remove
        local tableinsert = table.insert

        -- // Silent Aim Vars
        getgenv().Aiming = {
            Enabled = true,

            ShowFOV = false,
            FOV = 119,
            FOVSides = 300,
            FOVColour = Color3fromRGB(0, 255, 0),

            VisibleCheck = true,
            
            HitChance = 100,

            Selected = nil,
            SelectedPart = nil,

            TargetPart = {"Head", "HumanoidRootPart"},

            Ignored = {
                Teams = {
                    {
                        Team = LocalPlayer.Team,
                        TeamColor = LocalPlayer.TeamColor,
                    },
                },
                Players = {
                    LocalPlayer,
                    91318356
                }
            }
        }
        local Aiming = getgenv().Aiming

        -- // Create circle
        local circle = Drawingnew("Circle")
        circle.Transparency = 1
        circle.Thickness = 2
        circle.Color = Aiming.FOVColour
        circle.Filled = false
        Aiming.FOVCircle = circle

        -- // Update
        function Aiming.UpdateFOV()
            -- // Make sure the circle exists
            if not (circle) then
                return
            end

            -- // Set Circle Properties
            circle.Visible = Aiming.ShowFOV
            circle.Radius = (Aiming.FOV * 3)
            circle.Position = Vector2new(Mouse.X, Mouse.Y + GetGuiInset(GuiService).Y)
            circle.NumSides = Aiming.FOVSides
            circle.Color = Aiming.FOVColour

            -- // Return circle
            return circle
        end

        -- // Custom Functions
        local CalcChance = function(percentage)
            -- // Floor the percentage
            percentage = mathfloor(percentage)

            -- // Get the chance
            local chance = mathfloor(Randomnew().NextNumber(Randomnew(), 0, 1) * 100) / 100

            -- // Return
            return chance <= percentage / 100
        end

        -- // Customisable Checking Functions: Is a part visible
        function Aiming.IsPartVisible(Part, PartDescendant)
            -- // Vars
            local Character = LocalPlayer.Character or CharacterAddedWait(CharacterAdded)
            local Origin = CurrentCamera.CFrame.Position
            local _, OnScreen = WorldToViewportPoint(CurrentCamera, Part.Position)

            -- //
            if (OnScreen) then
                -- // Vars
                local raycastParams = RaycastParamsnew()
                raycastParams.FilterType = EnumRaycastFilterTypeBlacklist
                raycastParams.FilterDescendantsInstances = {Character, CurrentCamera}

                -- // Cast ray
                local Result = Raycast(Workspace, Origin, Part.Position - Origin, raycastParams)

                -- // Make sure we get a result
                if (Result) then
                    -- // Vars
                    local PartHit = Result.Instance
                    local Visible = (not PartHit or IsDescendantOf(PartHit, PartDescendant))

                    -- // Return
                    return Visible
                end
            end

            -- // Return
            return false
        end

        -- // Ignore player
        function Aiming.IgnorePlayer(Player)
            -- // Vars
            local Ignored = Aiming.Ignored
            local IgnoredPlayers = Ignored.Players

            -- // Find player in table
            for _, IgnoredPlayer in ipairs(IgnoredPlayers) do
                -- // Make sure player matches
                if (IgnoredPlayer == Player) then
                    return false
                end
            end

            -- // Blacklist player
            tableinsert(IgnoredPlayers, Player)
            return true
        end

        -- // Unignore Player
        function Aiming.UnIgnorePlayer(Player)
            -- // Vars
            local Ignored = Aiming.Ignored
            local IgnoredPlayers = Ignored.Players

            -- // Find player in table
            for i, IgnoredPlayer in ipairs(IgnoredPlayers) do
                -- // Make sure player matches
                if (IgnoredPlayer == Player) then
                    -- // Remove from ignored
                    tableremove(IgnoredPlayers, i)
                    return true
                end
            end

            -- //
            return false
        end

        -- // Ignore team
        function Aiming.IgnoreTeam(Team, TeamColor)
            -- // Vars
            local Ignored = Aiming.Ignored
            local IgnoredTeams = Ignored.Teams

            -- // Find team in table
            for _, IgnoredTeam in ipairs(IgnoredTeams) do
                -- // Make sure team matches
                if (IgnoredTeam.Team == Team and IgnoredTeam.TeamColor == TeamColor) then
                    return false
                end
            end

            -- // Ignore team
            tableinsert(IgnoredTeams, {Team, TeamColor})
            return true
        end

        -- // Unignore team
        function Aiming.UnIgnoreTeam(Team, TeamColor)
            -- // Vars
            local Ignored = Aiming.Ignored
            local IgnoredTeams = Ignored.Teams

            -- // Find team in table
            for i, IgnoredTeam in ipairs(IgnoredTeams) do
                -- // Make sure team matches
                if (IgnoredTeam.Team == Team and IgnoredTeam.TeamColor == TeamColor) then
                    -- // Remove
                    tableremove(IgnoredTeams, i)
                    return true
                end
            end

            -- // Return
            return false
        end

        -- //  Toggle team check
        function Aiming.TeamCheck(Toggle)
            if (Toggle) then
                return Aiming.IgnoreTeam(LocalPlayer.Team, LocalPlayer.TeamColor)
            end

            return Aiming.UnIgnoreTeam(LocalPlayer.Team, LocalPlayer.TeamColor)
        end

        -- // Check teams
        function Aiming.IsIgnoredTeam(Player)
            -- // Vars
            local Ignored = Aiming.Ignored
            local IgnoredTeams = Ignored.Teams

            -- // Check if team is ignored
            for _, IgnoredTeam in ipairs(IgnoredTeams) do
                -- // Make sure team matches
                if (Player.Team == IgnoredTeam.Team and Player.TeamColor == IgnoredTeam.TeamColor) then
                    return true
                end
            end

            -- // Return
            return false
        end

        -- // Check if player (and team) is ignored
        function Aiming.IsIgnored(Player)
            -- // Vars
            local Ignored = Aiming.Ignored
            local IgnoredPlayers = Ignored.Players

            -- // Loop
            for _, IgnoredPlayer in ipairs(IgnoredPlayers) do
                -- // Check if Player Id
                if (typeof(IgnoredPlayer) == "number" and Player.UserId == IgnoredPlayer) then
                    return true
                end

                -- // Normal Player Instance
                if (IgnoredPlayer == Player) then
                    return true
                end
            end

            -- // Team check
            return Aiming.IsIgnoredTeam(Player)
        end

        -- // Get the Direction, Normal and Material
        function Aiming.Raycast(Origin, Destination, UnitMultiplier)
            if (typeof(Origin) == "Vector3" and typeof(Destination) == "Vector3") then
                -- // Handling
                if (not UnitMultiplier) then UnitMultiplier = 1 end

                -- // Vars
                local Direction = (Destination - Origin).Unit * UnitMultiplier
                local Result = Raycast(Workspace, Origin, Direction)

                -- // Make sure we have a result
                if (Result) then
                    local Normal = Result.Normal
                    local Material = Result.Material

                    return Direction, Normal, Material
                end
            end

            -- // Return
            return nil
        end

        -- // Get Character
        function Aiming.Character(Player)
            return Player.Character
        end

        -- // Check Health
        function Aiming.CheckHealth(Player)
            -- // Get Humanoid
            local Character = Aiming.Character(Player)
            local Humanoid = FindFirstChildWhichIsA(Character, "Humanoid")

            -- // Get Health
            local Health = (Humanoid and Humanoid.Health or 0)

            -- //
            return Health > 0
        end

        -- // Check if silent aim can used
        function Aiming.Check()
            return (Aiming.Enabled == true and Aiming.Selected ~= LocalPlayer and Aiming.SelectedPart ~= nil)
        end
        Aiming.checkSilentAim = Aiming.Check

        -- // Get Closest Target Part
        function Aiming.GetClosestTargetPartToCursor(Character)
            local TargetParts = Aiming.TargetPart

            -- // Vars
            local ClosestPart = nil
            local ClosestPartPosition = nil
            local ClosestPartOnScreen = false
            local ClosestPartMagnitudeFromMouse = nil
            local ShortestDistance = 1/0

            -- //
            local function CheckTargetPart(TargetPart)
                -- // Convert string -> Instance
                if (typeof(TargetPart) == "string") then
                    TargetPart = FindFirstChild(Character, TargetPart)
                end

                -- // Make sure we have a target
                if not (TargetPart) then
                    return
                end

                -- // Get the length between Mouse and Target Part (on screen)
                local PartPos, onScreen = WorldToViewportPoint(CurrentCamera, TargetPart.Position)
                local GuiInset = GetGuiInset(GuiService)
                local Magnitude = (Vector2new(PartPos.X, PartPos.Y - GuiInset.Y) - Vector2new(Mouse.X, Mouse.Y)).Magnitude

                -- //
                if (Magnitude < ShortestDistance) then
                    ClosestPart = TargetPart
                    ClosestPartPosition = PartPos
                    ClosestPartOnScreen = onScreen
                    ClosestPartMagnitudeFromMouse = Magnitude
                    ShortestDistance = Magnitude
                end
            end

            -- // String check
            if (typeof(TargetParts) == "string") then
                -- // Check if it all
                if (TargetParts == "All") then
                    -- // Loop through character children
                    for _, v in ipairs(Character:GetChildren()) do
                        -- // See if it a part
                        if not (v:IsA("BasePart")) then
                            continue
                        end

                        -- // Check it
                        CheckTargetPart(v)
                    end
                else
                    -- // Individual
                    CheckTargetPart(TargetParts)
                end
            end

            -- //
            if (typeof(TargetParts) == "table") then
                -- // Loop through all target parts and check them
                for _, TargetPartName in ipairs(TargetParts) do
                    CheckTargetPart(TargetPartName)
                end
            end

            -- //
            return ClosestPart, ClosestPartPosition, ClosestPartOnScreen, ClosestPartMagnitudeFromMouse
        end

        -- // Silent Aim Function
        function Aiming.GetClosestPlayerToCursor()
            -- // Vars
            local TargetPart = nil
            local ClosestPlayer = nil
            local Chance = CalcChance(Aiming.HitChance)
            local ShortestDistance = 1/0

            -- // Chance
            if (not Chance) then
                Aiming.Selected = LocalPlayer
                Aiming.SelectedPart = nil

                return LocalPlayer
            end

            -- // Loop through all players
            for _, Player in ipairs(GetPlayers(Players)) do
                -- // Get Character
                local Character = Aiming.Character(Player)

                -- // Make sure isn't ignored and Character exists
                if (Aiming.IsIgnored(Player) == false and Character) then
                    -- // Vars
                    local TargetPartTemp, _, _, Magnitude = Aiming.GetClosestTargetPartToCursor(Character)

                    -- // Check if part exists and health
                    if (TargetPartTemp and Aiming.CheckHealth(Player)) then
                        -- // Check if is in FOV
                        if (circle.Radius > Magnitude and Magnitude < ShortestDistance) then
                            -- // Check if Visible
                            if (Aiming.VisibleCheck and not Aiming.IsPartVisible(TargetPartTemp, Character)) then continue end

                            -- // Set vars
                            ClosestPlayer = Player
                            ShortestDistance = Magnitude
                            TargetPart = TargetPartTemp
                        end
                    end
                end
            end

            -- // End
            Aiming.Selected = ClosestPlayer
            Aiming.SelectedPart = TargetPart
        end

        -- // Heartbeat Function
        Heartbeat:Connect(function()
            Aiming.UpdateFOV()
            Aiming.GetClosestPlayerToCursor()
        end)
        
        Aiming.TeamCheck(false)
        local CurrentCamera = Workspace.CurrentCamera
        local DaHoodSettings = {
            SilentAim = false,
            AimLock = false,
            Prediction = 0.14,
            AimLockKeybind = Enum.KeyCode.E
        }
        getgenv().DaHoodSettings = DaHoodSettings
        function Aiming.Check()
            if Aiming.Enabled ~= true or Aiming.Selected == LocalPlayer or Aiming.SelectedPart == nil then
                return false
            end
            local Character = Aiming.Character(Aiming.Selected)
            local KOd = Character:WaitForChild("BodyEffects")["K.O"].Value
            local Grabbed = Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil
            if KOd or Grabbed then
                return false
            end
            return true
        end
        local __index
        __index = hookmetamethod(game, "__index", function(t, k)
            if t:IsA("Mouse") and (k == "Hit" or k == "Target") and Aiming.Check() then
                local SelectedPart = Aiming.SelectedPart
                if DaHoodSettings.SilentAim and (k == "Hit" or k == "Target") then
                    local Hit = SelectedPart.CFrame + SelectedPart.Velocity * DaHoodSettings.Prediction
                    return k == "Hit" and Hit or SelectedPart
                end
            end
            return __index(t, k)
        end)
        RunService:BindToRenderStep("AimLock", 0, function()
            if DaHoodSettings.AimLock and Aiming.Check() and UserInputService:IsKeyDown(DaHoodSettings.AimLockKeybind) then
                local SelectedPart = Aiming.SelectedPart
                local Hit = SelectedPart.CFrame + SelectedPart.Velocity * DaHoodSettings.Prediction
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, Hit.Position)
            end
        end)
    end

    functions.SilentBbot = function()
        getgenv().Target = false
        getgenv().Key = Enum.KeyCode.X
        getgenv().Prediction = 0.12
        getgenv().ChatMode = false
        getgenv().NotifMode = true
        getgenv().PartMode = true
        getgenv().AirshotFunccc = false
        getgenv().Partz = "HumanoidRootPart"
        local Tracer = Instance.new("Part", game.Workspace)
        Tracer.Name = "gay"
        Tracer.Anchored = true
        Tracer.CanCollide = false
        Tracer.Transparency = 0.8
        Tracer.Parent = game.Workspace
        Tracer.Shape = Enum.PartType.Block
        Tracer.Size = Vector3.new(14, 14, 14)
        Tracer.Color = Color3.fromRGB(128, 128, 128)
        local guimain = Instance.new("Folder", game.CoreGui)
        local CC = game:GetService("Workspace").CurrentCamera
        local LocalMouse = game.Players.LocalPlayer:GetMouse()
        local UIS = game:GetService("UserInputService")
        local Locking = false
        if getgenv().valiansh == true then
            game.StarterGui:SetCore("SendNotification", {
                Title = "Cultware",
                Text = "Already Loaded!",
                Duration = 5
            })
            return
        end
        getgenv().valiansh = true
        UIS.InputBegan:Connect(function(key, focused)
            if not focused and key.KeyCode == getgenv().Key and getgenv().Target == true then
                Locking = not Locking
                if Locking then
                    Plr = getClosestPlayerToCursor()
                    if getgenv().ChatMode then
                        local A_1 = "Target: " .. tostring(Plr.Character.Humanoid.DisplayName)
                        local A_2 = "All"
                        local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
                        Event:FireServer(A_1, A_2)
                    end
                    if getgenv().NotifMode then
                        game.StarterGui:SetCore("SendNotification", {
                            Title = "",
                            Text = "Target: " .. tostring(Plr.Character.Humanoid.DisplayName)
                        })
                    end
                elseif not Locking then
                    if getgenv().ChatMode then
                        local A_1 = "Unlocked!"
                        local A_2 = "All"
                        local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
                        Event:FireServer(A_1, A_2)
                    end
                    if getgenv().NotifMode then
                        game.StarterGui:SetCore("SendNotification", {
                            Title = "",
                            Text = "Unlocked",
                            Duration = 5
                        })
                    elseif getgenv().Target == false then
                        game.StarterGui:SetCore("SendNotification", {
                            Title = "",
                            Text = "Target isn't enabled",
                            Duration = 5
                        })
                    end
                end
            end
        end)
        function getClosestPlayerToCursor()
            local closestPlayer
            local shortestDistance = math.huge
            for i, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("LowerTorso") then
                    local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
                    local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(LocalMouse.X, LocalMouse.Y)).magnitude
                    if shortestDistance > magnitude then
                        closestPlayer = v
                        shortestDistance = magnitude
                    end
                end
            end
            return closestPlayer
        end
        if getgenv().PartMode then
            game:GetService("RunService").Stepped:connect(function()
                if Locking and Plr.Character and Plr.Character:FindFirstChild("LowerTorso") then
                    Tracer.CFrame = CFrame.new(Plr.Character.LowerTorso.Position + Plr.Character.LowerTorso.Velocity * Prediction)
                else
                    Tracer.CFrame = CFrame.new(0, 9999, 0)
                end
            end)
        end
        local rawmetatable = getrawmetatable(game)
        local old = rawmetatable.__namecall
        setreadonly(rawmetatable, false)
        rawmetatable.__namecall = newcclosure(function(...)
            local args = {
                ...
            }
            if Locking and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
                args[3] = Plr.Character[getgenv().Partz].Position + Plr.Character[getgenv().Partz].Velocity * Prediction
                return old(unpack(args))
            end
            return old(...)
        end)
        if getgenv.AirshotFunccc then
            if Plr.Character.Humanoid.Jump == true and Plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
                getgenv().Partz = "RightFoot"
            else
                getgenv().Partz = "LowerTorso"
            end
        end
    end

    functions.BlatentAntiAim = function(state)
        function getRoot(char)
            local rootPart = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso")
            return rootPart
        end
        if state then
            local Spin = Instance.new("BodyAngularVelocity")
            Spin.Name = "Spinning"
            Spin.Parent = getRoot(game.Players.LocalPlayer.Character)
            Spin.MaxTorque = Vector3.new(0, math.huge, 0)
            Spin.AngularVelocity = Vector3.new(0, getgenv().SpinBotSpeed, 0)
        else
            for i, v in pairs(getRoot(game.Players.LocalPlayer.Character):GetChildren()) do
                if v.Name == "Spinning" then
                    v:Destroy()
                end
            end
        end
    end

    functions.BlatentSpinJitterSpeed = function(BlatentSpinSpeed)
        SpinBotSpeed = BlatentSpinSpeed
    end

    local FakeLagSpeed
    functions.FakeSection = function(state)
        local fakelagEnableState = false
        if state then
            fakelagEnableState = true
            while fakelagEnableState do
                Character.HumanoidRootPart.Anchored = true
                wait(FakeLagSpeed)
                Character.HumanoidRootPart.Anchored = false
                wait()
            end
        else
            fakelagEnableState = false
        end
    end

    functions.FakeSectionSlider = function(FakeSectionSliderL)
        FakeLagSpeed = FakeSectionSliderL
    end

    functions.GripposSettingsTab = function()
        Side = 0
        UP = 0
        Front = 0
        local niggertool = Character:FindFirstChildOfClass("Tool")
        niggertool.GripPos = Vec3(-Side, -UP, Front)
        niggertool.Parent = Client.Backpack
        niggertool.Parent = Character
    end

    functions.GripposLeft = function(GripposLeftB)
        Side = GripposLeftB
        local niggertool = Character:FindFirstChildOfClass("Tool")
        niggertool.GripPos = Vec3(-Side, -UP, Front)
        niggertool.Parent = Client.Backpack
        niggertool.Parent = Character
    end

    functions.GripposUp = function(GripposUpB)
        UP = GripposUpB
        local niggertool = Character:FindFirstChildOfClass("Tool")
        niggertool.GripPos = Vec3(-Side, -UP, Front)
        niggertool.Parent = Client.Backpack
        niggertool.Parent = Character
    end

    functions.GripposRight = function(GripposRightB)
        Front = GripposRightB
        local niggertool = Character:FindFirstChildOfClass("Tool")
        niggertool.GripPos = Vec3(-Side, -UP, Front)
        niggertool.Parent = Client.Backpack
        niggertool.Parent = Character
    end

    functions.ResistanceHead = function()
        local player = game.Players.LocalPlayer
        player.Character.Head:BreakJoints()
        player.Character.Head.Position = Vector3.new(0, 999999999999, 0)
    end

    functions.ResistanceHumanoidRootPart = function()
        local C = game.Players.LocalPlayer.Character
        C.Parent = nil
        C.HumanoidRootPart:Destroy()
        C.Parent = game.workspace
        wait()
        local Chr = game:GetService("Players").LocalPlayer.Character
        local A = getrawmetatable(game)
        local B = A.__index
        setreadonly(A, false)
        A.__index = newcclosure(function(self, key)
            if self == Chr and key == "HumanoidRootPart" then
                return Chr.UpperTorso
            end
            return B(self, key)
        end)
    end

    functions.ResistanceHead = function()
        Character.RightUpperLeg:Destroy()
    end

    functions.ResistanceHead2 = function()
        Character.LeftUpperLeg:Destroy()
    end

    functions.SettingsAntiSlow = function(SettingsAntiSlowA)
        antislow = SettingsAntiSlowA
        repeat
            wait(0.1)
            local DeletePart = Character.BodyEffects.Movement:FindFirstChild("NoJumping") or Character.BodyEffects.Movement:FindFirstChild("ReduceWalk") or Character.BodyEffects.Movement:FindFirstChild("NoWalkSpeed")
            if DeletePart then
                DeletePart:Destroy()
            end
            if Character.BodyEffects.Reload.Value == true then
                Character.BodyEffects.Reload.Value = false
            end
        until antislow == false
    end

    functions.SettingsUnbag = function()
        Character.Christmas_Sock:Destroy()
    end

    functions.SettingsFling = function(SettingsFlingF)
        Character.HumanoidRootPart.Anchored = SettingsFlingF
    end

    functions.SettingsSuperPower = function(SettingsSuperPowerS)
        superhumann = SettingsSuperPowerS
        Mouse.KeyDown:connect(function(key)
            if key == "M5" and superhumann == false then
                superhumann = true
                Character.Humanoid.Name = "Slider"
                Character.Slider.WalkSpeed = 16
                Character.Slider.JumpPower = 50
            elseif key == "M5" and superhumann == true then
                superhumann = false
                Character.Slider.WalkSpeed = 16
                Character.Slider.JumpPower = 50
                Character.Slider.Name = "Humanoid"
            end
        end)
    end

    functions.SettingsSuperPowerSpeed = function(SettingsSuperPowerSpeedS)
        Character.Slider.JumpPower = SettingsSuperPowerSpeedS
    end

    functions.SettingsGodmodeMelee = function()
        local unban = function()
            local localPlayer = game:GetService("Players").LocalPlayer
            local localCharacter = localPlayer.Character
            localCharacter:FindFirstChildOfClass("Humanoid").Health = 0
            local newCharacter = localPlayer.CharacterAdded:Wait()
            local spoofFolder = Instance.new("Folder")
            spoofFolder.Name = "FULLY_LOADED_CHAR"
            spoofFolder.Parent = newCharacter
            newCharacter:WaitForChild("RagdollConstraints"):Destroy()
            local spoofValue = Instance.new("BoolValue", newCharacter)
            spoofValue.Name = "RagdollConstraints"
            local ps = game:GetService("Players")
            local lp = ps.LocalPlayer
            local char = lp.Character
            char.BodyEffects.Armor:Destroy()
            char.BodyEffects.Defense:Destroy()
            local Clone2 = Instance.new("NumberValue")
            Clone2.Name = "Defense"
            Clone2.Parent = char.BodyEffects
            local Clone3 = Instance.new("NumberValue")
            Clone3.Name = "Armor"
            Clone3.Parent = char.BodyEffects
            game.ReplicatedStorage.MainEvent:FireServer("Block", true)
        end
    
        unban()
        while wait() do
            for _, v in pairs(game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):GetPlayingAnimationTracks()) do
                if v.Name == "Block" then
                    v:Stop()
                end
            end
        end
    end

    functions.SettingsGodmodeGuns = function()
        local LP = game.Players.LocalPlayer
        LP.Character:FindFirstChild("FULLY_LOADED_CHAR").Parent = game.ReplicatedStorage
        LP.Character:Remove()
        game.ReplicatedStorage:FindFirstChild("FULLY_LOADED_CHAR").Parent = LP.Character
        local xd = true
        while wait() do
            pcall(function()
                if game.Players.LocalPlayer.Character.BodyEffects:FindFirstChild("BreakingParts") and xd == true then
                    game.Players.LocalPlayer.Character.BodyEffects.BreakingParts:Destroy()
                    local meh = Instance.new("Folder", game.Players.LocalPlayer.Character)
                    meh.Name = "FULLY_LOADED_CHAR"
                    wait()
                    game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
                    LP.Character:FindFirstChild("FULLY_LOADED_CHAR").Parent = game.ReplicatedStorage
                end
            end)
        end
    end

    functions.GodBlockSettings = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/ztvkeCDL"))()
    end

    functions.InfiniteJump = function()
        _G.infinjump = true
        local Player = game:GetService("Players").LocalPlayer
        local Mouse = Player:GetMouse()
        Mouse.KeyDown:connect(function(k)
            if _G.infinjump and k:byte() == 32 then
                Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                Humanoid:ChangeState("Jumping")
                wait(0.1)
                Humanoid:ChangeState("Seated")
            end
        end)
        local Player = game:GetService("Players").LocalPlayer
        local Mouse = Player:GetMouse()
        Mouse.KeyDown:connect(function(k)
            k = k:lower()
            if k == "M4" then
                if _G.infinjump == true then
                    _G.infinjump = false
                else
                    _G.infinjump = true
                end
            end
        end)
    end

    functions.NoRecoilSettings = function()
        function isframework(scriptInstance)
            if tostring(scriptInstance) == "Framework" then
                return true
            end
            return false
        end
        function checkArgs(instance, index)
            if tostring(instance):lower():find("camera") and tostring(index) == "CFrame" then
                return true
            end
            return false
        end
        newindex = hookmetamethod(game, "__newindex", function(self, index, value)
            local callingScr = getcallingscript()
            if isframework(callingScr) and checkArgs(self, index) then
                return
            end
            return newindex(self, index, value)
        end)
    end

    functions.BtoolsSettings = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/GyZ5cwpV"))()
    end

    local ESP = loadstring(game:HttpGet("https://pastebin.com/raw/TvXc1RUb", true))()

    functions.EspBoxesS = function(State)
        ESP.Boxes = State
    end

    functions.EspBoxesSColor = function(Color)
        ESP.BoxesColor = Color
    end

    functions.NameToggle = function(State)
        ESP.Names = State
    end

    functions.NameToggleColor = function(Color)
        ESP.NamesColor = Color
    end

    functions.DistanceToggle = function(State)
        ESP.Distance = State
    end

    functions.DistanceToggleColor = function(Color)
        ESP.DistanceColor = Color
    end

    functions.ChamToggle = function(State)
        ESP.Cham = State
    end

    functions.ChamToggleColor1 = function(Color)
        ESP.ChamColor1 = Color
    end

    functions.ChamToggleColor2 = function(Color)
        ESP.ChamColor2 = Color
    end

    functions.BankTpButton = function()
        Character.HumanoidRootPart.CFrame = CFrame.new(-874.903992, -32.6492004, -525.215698)
    end

    functions.FoodTeleportB = function()
        Character.HumanoidRootPart.CFrame = CFrame.new(-788.39318847656, -39.649200439453, -935.27795410156)
    end

    functions.ArmorTeleportB = function()
        Character.HumanoidRootPart.CFrame = CFrame.new(-934.73651123047, -28.492471694946, 565.99884033203)
    end

    functions.UphillMountainB = function()
        Character.HumanoidRootPart.CFrame = CFrame.new(485.651947, 112.5, -644.316833, -0.998899043, 1.33881997E-6, 0.0469136797, 8.00526664E-7, 1, -1.14929126E-5, -0.0469136797, -1.14426994E-5, -0.998899043)
    end

    functions.AKMountain = function()
        Character.HumanoidRootPart.CFrame = CFrame.new(-658.31897, 80.9998474, -778.077576, -0.142138869, 1.05273443E-8, -0.989845812, 4.51260629E-9, 1, 9.98731764E-9, 0.989845812, -3.04721426E-9, -0.142138869)
    end

    functions.PlaygroundB = function()
        Character.HumanoidRootPart.CFrame = CFrame.new(-260.836182, 126.424866, -877.783875, -0.977067351, -1.56508904E-5, -0.212922528, 9.92513264E-7, 1, -7.80593255E-5, 0.212922528, -7.64806027E-5, -0.977067351)
    end

    functions.RevMountainB = function()
        Character.HumanoidRootPart.CFrame = CFrame.new(-659.053162, 110.748001, -158.224365, 0.146754071, -2.38941595E-8, -0.989172995, -1.60316838E-9, 1, -2.43935396E-8, 0.989172995, 5.16566212E-9, 0.146754071)
    end

    functions.CasinoMonB = function()
        Character.HumanoidRootPart.CFrame = CFrame.new(-1048.95093, 110.254997, -154.554016, 0.198458344, 0.0412604436, -0.979240835, -4.06676299E-5, 0.999113858, 0.0420895219, 0.98010987, -0.00831318926, 0.198284075)
    end

    functions.BankMonB = function()
        Character.HumanoidRootPart.CFrame = CFrame.new(-327.583862, 80.4338913, -278.811951, -0.0466220938, -1.94237373E-8, 0.998912573, 1.07243459E-7, 1, 2.44502392E-8, -0.998912573, 1.08266761E-7, -0.0466220938)
    end

    functions.FlankMB = function()
        Character.HumanoidRootPart.CFrame = CFrame.new(376.730621, 130.748001, -245.620468, 0.996583343, 5.90310174E-6, -0.0825867951, -1.72590728E-6, 1, 5.06508768E-5, 0.0825867951, -5.03353003E-5, 0.996583343)
    end

    functions.GasM = function()
        Character.HumanoidRootPart.CFrame = CFrame.new(608.599426, 65.3087997, -267.643066, -0.414288431, -1.04483455E-9, -0.91014564, -1.30518893E-8, 1, 4.79309215E-9, 0.91014564, 1.38648408E-8, -0.41428)
    end

    functions.SchoolMB = function()
        Character.HumanoidRootPart.CFrame = CFrame.new(-581.790283, 68.4947281, 331.046448, 0.220051467, -7.56681329E-5, 0.975498199, -3.96428077E-5, 0.999999583, 8.65130132E-5, -0.975498199, -5.77078645E-5, 0.22005)
    end

    functions.CircusMB = function()
        Character.HumanoidRootPart.CFrame = CFrame.new(170.510178, 59.6617432, -944.884216, 0.806685388, -8.34191383E-8, 0.590979934, 9.47717194E-9, 1, 1.28217792E-7, -0.590979934, -9.78305081E-8, 0.806685388)
    end

    functions.UFOMB = function()
        Character.HumanoidRootPart.CFrame = CFrame.new(65.1504517, 138.999954, -691.819031, -0.935115993, -5.9791418E-8, -0.354341775, -3.10840989E-8, 1, -8.67077574E-8, 0.354341775, -7.0067415E-8, -0.935115993)
    end

    functions.BankTMB = function()
        Character.HumanoidRootPart.CFrame = CFrame.new(-374.538391, 102.052887, -440.20871, 0.958144963, 9.24065989E-6, -0.286283433, -9.98981818E-7, 1, 2.89345699E-5, 0.286283433, -2.74375216E-5, 0.958144963)
    end

    functions.CircusMB2 = function()
        Character.HumanoidRootPart.CFrame = CFrame.new(292.643799, 122.749977, -860.128784, 0.986730993, 5.09704545E-9, 0.162363499, -9.24942123E-10, 1, -2.57716568E-8, -0.162363499, 2.52795154E-8, 0.986730993)
    end

    functions.GymMB = function()
        Character.HumanoidRootPart.CFrame = CFrame.new(-76.178093, 56.6998138, -629.940979, -0.9998914, -1.09370752E-7, 0.0147391548, -1.0945012E-7, 1, -4.57786342E-9, -0.0147391548, -6.1905685E-9, -0.9998914)
    end

    functions.WatermarkToggle = function(Watermarkvisiblity)
        watermark.Visible = Watermarkvisiblity
    end

    functions.WatermarkToggleText = function(WatermarkText)
        watermark.text = WatermarkText
    end

    functions.CustomizeName = function(UiNameSettings)
        window.text = UiNameSettings
    end

    functions.CustomFovSize = function(FovSizeControl)
        FieldOfViewSize = FovSizeControl
        game:GetService("Workspace").Camera.FieldOfView = FieldOfViewSize
    end

    functions.CustomCrossair = function(xddddddd)
        game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Visible = xddddddd
        game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Top.Visible = xddddddd
        game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Bottom.Visible = xddddddd
        game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Right.Visible = xddddddd
        game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Left.Visible = xddddddd
    end

    functions.CustomCrossairColor = function(summerandback)
        game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.BackgroundColor3 = summerandback
        game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Top.BackgroundColor3 = summerandback
        game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Bottom.BackgroundColor3 = summerandback
        game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Right.BackgroundColor3 = summerandback
        game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Left.BackgroundColor3 = summerandback
    end

    functions.AnimationSectorIdle = function(State)
        if Alive(LocalPlayer) then
            LocalPlayer.Character.Animate.idle.Animation1.AnimationId = AnimationModule[State][1]
            LocalPlayer.Character.Animate.idle.Animation2.AnimationId = AnimationModule[State][2]
            AnimationState.Idle = State
        end
    end

    functions.AnimationSectorWalk = function(State)
        if Alive(LocalPlayer) then
            LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId = AnimationModule[State][3]
            AnimationState.Walk = State
        end
    end

    functions.AnimationSectorRun = function(State)
        if Alive(LocalPlayer) then
            LocalPlayer.Character.Animate.run.RunAnim.AnimationId = AnimationModule[State][4]
            AnimationState.Run = State
        end
    end

    functions.AnimationSectorJump = function(State)
        if Alive(LocalPlayer) then
            LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId = AnimationModule[State][5]
            AnimationState.Jump = State
        end
    end

    functions.AnimationSectorClimb = function(State)
        if Alive(LocalPlayer) then
            LocalPlayer.Character.Animate.climb.ClimbAnim.AnimationId = AnimationModule[State][6]
            AnimationState.Climb = State
        end
    end

    functions.AnimationSectorFall = function(State)
        if Alive(LocalPlayer) then
            LocalPlayer.Character.Animate.fall.FallAnim.AnimationId = AnimationModule[State][7]
            AnimationState.Fall = State
        end
    end

    local cframetogglespeed;
    functions.MovementEnabledSpeed = function(MovementEnabledB)
        cframespeedtoggle = MovementEnabledB
    end

    local speedvalue
    functions.MovementSliderSpeed = function(MovementSpeedB)
        speedvalue = MovementSpeedB
    end

    coroutine.wrap(function()
        while wait() do
            if cframespeedtoggle then
                Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame + Character.Humanoid.MoveDirection * speedvalue
            end
        end        
    end)()

    functions.debug("Loaded!")
end

return functions.ready
