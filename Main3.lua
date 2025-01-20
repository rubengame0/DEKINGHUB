-- Valores globales
_G.autoRebirth = false  -- Inicializamos el auto rebirth en falso

-- Función Auto Rebirth
function autoRebirth()
    while _G.autoRebirth do
        local args = {
            [1] = 1,      -- Ajusta según tus necesidades
            [2] = 90000,  -- Ejemplo de valores
            [3] = 100
        }

        -- Llamamos al evento remoto para confirmar el rebirth
        game:GetService("ReplicatedStorage").Remotes.RebirthConfirmEvent:FireServer(unpack(args))
        wait(1)  -- Esperamos un segundo entre cada rebirth
    end
end

-- Función para agregar dinero
local function addMoney(amount)
    local args = {
        [1] = "Cash",
        [2] = tostring(amount)  -- Usamos la cantidad ingresada para dinero
    }
    game:GetService("ReplicatedStorage").Remotes.AddValueEvent:FireServer(unpack(args))
    print("Dinero agregado: " .. amount)
end

-- Función para agregar gemas
local function addGems(amount)
    local args = {
        [1] = amount  -- Usamos la cantidad ingresada para gemas
    }
    game:GetService("ReplicatedStorage").Remotes.GemEvent:FireServer(unpack(args))
    print("Gemas agregadas: " .. amount)
end

-- Cargar OrionLib
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

if not OrionLib then
    warn("Error al cargar OrionLib.")
    return
end

-- Crear la ventana de la interfaz
local Window = OrionLib:MakeWindow({
    Name = "Merge For Speed KingHub V2",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "KingHubV2.4"
})

-- Crear la pestaña de Farming
local FarmTab = Window:MakeTab({
    Name = "Farming",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Agregar TextBox para ingresar cantidad de dinero
FarmTab:AddTextbox({
    Name = "Add Money",
    Default = "1000",  -- Valor predeterminado
    TextDisappear = true,  -- El texto desaparece después de ingresar un valor
    Callback = function(Value)
        local amount = tonumber(Value) or 0  -- Convertir el valor a número
        if amount > 0 then
            addMoney(amount)  -- Llamar a la función para agregar dinero
        else
            warn("Por favor ingresa una cantidad válida.")  -- Si el valor no es válido
        end
    end
})

-- Agregar TextBox para ingresar cantidad de gemas
FarmTab:AddTextbox({
    Name = "Add Gems",
    Default = "15",  -- Valor predeterminado para las gemas
    TextDisappear = true,  -- El texto desaparece después de ingresar un valor
    Callback = function(Value)
        local amount = tonumber(Value) or 0  -- Convertir el valor a número
        if amount > 0 then
            addGems(amount)  -- Llamar a la función para agregar gemas
        else
            warn("Por favor ingresa una cantidad válida.")  -- Si el valor no es válido
        end
    end
})

-- Agregar Toggle para activar Auto Rebirth
FarmTab:AddToggle({
    Name = "Auto Rebirth",
    Default = false,
    Callback = function(Value)
        _G.autoRebirth = Value  -- Cambiar el valor global de autoRebirth
        if _G.autoRebirth then
            autoRebirth()  -- Llamar a la función autoRebirth
        end
    end    
})

-- Inicializar la interfaz
OrionLib:Init()
