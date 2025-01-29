repeat wait() until game:IsLoaded()
local Players = game:GetService("Players")
repeat wait() until Players.LocalPlayer
local plr = Players.LocalPlayer
repeat wait() until plr.PlayerGui
repeat wait() until plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

local hmr = plr.Character:FindFirstChild("HumanoidRootPart")
local PlayerGUI = plr:FindFirstChildOfClass("PlayerGui")

local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- Cargar ArrayField
local success, ArrayField = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/ArrayField/main/Source.lua'))()
end)
if not success then
    warn("Error al cargar ArrayField")
    return
end

-- Crear ventana
local Window = ArrayField:CreateWindow({
   Name = "Blox Fruits - KingHubV2",
   LoadingTitle = "Cargando KingHubV2",
   LoadingSubtitle = "By Birux KingHubV2",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "KingHubV2Goat"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false
})

-- Variables
_G.selectedFruit = "Dragon (East) Fruit"
_G.Mas = 1000

-- Función para ejecutar RemoteEvents de forma segura
local function fireRemote(fruitName)
    local args
    if fruitName then
        args = {
            "EMMFOSS__!ZCNSJNXCSDWQSANBX",
            "AddToolToBackpackKKK",
            {
                fruitName,
                plr.Backpack,
                true,
                true
            }
        }
    else
        args = {
            "EMMFOSS__!ZCNSJNXCSDWQSANBX",
            "AddToolToBackpackKKK",
            {
                "Hito Fruit",
                plr.Backpack,
                true,
                true
            }
        }
    end

    local RemoteEvent = ReplicatedStorage:FindFirstChild("ALLREMBINDS")
    if RemoteEvent and RemoteEvent:FindFirstChild("MainRemoteEvent") then
        RemoteEvent.MainRemoteEvent:FireServer(unpack(args))
    else
        warn("Error: RemoteEvent no encontrado en ReplicatedStorage.")
    end
end

-- Crear Tabs
local FarmTab = Window:CreateTab("FarmTab", 113995428920478)
local FruitTab = Window:CreateTab("Fruits Givens", 75494093579270)

-- Botón para recolectar cofres
local Button = FarmTab:CreateButton({
   Name = "Auto Collect Chest",
   Interact = 'Click',
   Callback = function()
        for _, v in ipairs(Workspace.World.Chests:GetChildren()) do
            if v:FindFirstChild("TouchInterest") then
                firetouchinterest(plr.Character.HumanoidRootPart, v, 0)
                wait(1)
                firetouchinterest(plr.Character.HumanoidRootPart, v, 1)
            end
        end
   end,
})

-- Slider para configurar la maestría
local Slider = FarmTab:CreateSlider({
   Name = "Custom Mastery Fruit",
   Range = {0, 100000},
   Increment = 10,
   Suffix = "Add Mastery",
   CurrentValue = 1000,
   Flag = "Slider1",
   Callback = function(Value)
        _G.Mas = Value
   end,
})

-- Toggle para activar la maestría personalizada
local Toggle = FarmTab:CreateToggle({
   Name = "Active Mastery Custom Fruit",
   CurrentValue = true,
   Flag = "Toggle1",
   Callback = function(Value)
       if Value then
           local fruit = plr:FindFirstChild("PlayerStats") and plr.PlayerStats:FindFirstChild("UsingBloxFruit")
           if fruit then
               local args = {
                   "EMMFOSS__!ZCNSJNXCSDWQSANBX",
                   "GiveMasteryEXPTO__Smthh",
                   {
                       plr,
                       fruit.Value,
                       _G.Mas,
                       true
                   }
               }
               local RemoteEvent = ReplicatedStorage:FindFirstChild("ALLREMBINDS")
               if RemoteEvent and RemoteEvent:FindFirstChild("MainRemoteEvent") then
                   RemoteEvent.MainRemoteEvent:FireServer(unpack(args))
               else
                   warn("Error: No se encontró 'MainRemoteEvent' en ReplicatedStorage.")
               end
           else
               warn("Error: No se encontró 'UsingBloxFruit' en PlayerStats.")
           end
       end
   end,
})

-- Dropdown para seleccionar frutas
local Dropdown = FruitTab:CreateDropdown({
   Name = "Fruit Givens",
   Options = {
       "Dragon (East) Fruit", "Dragon (West) Fruit",
       "Spirit Fruit", "Dough Fruit", "Hito Fruit",
       "Barrier Fruit", "Control Fruit", "Kitsune Fruit",
       "Leopard Fruit"
   },
   CurrentOption = "Dragon (West) Fruit",
   MultiSelection = true,
   Flag = "Dropdown1",
   Callback = function(Option)
        _G.selectedFruit = Option
   end,
})
