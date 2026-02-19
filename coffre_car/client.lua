local inTrunk = false
local currentVehicle = nil
local blackScreen = false

local trunkAnim = {
    dict = "timetable@floyd@cryingonbed@base",
    anim = "base"
}

local function Notify(title, message, type)
    if title and message then
        exports.ox_lib:notify({
            title = tostring(title),
            description = tostring(message),
            type = type or "inform",
            position = "top"
        })
    end
end

local function loadAnim(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

local function enterTrunk(vehicle)
    local ped = PlayerPedId()

    if inTrunk then return end

    if GetVehicleDoorLockStatus(vehicle) ~= 1 then
        Notify("Coffre", "Le vehicule est verrouille", "error")
        return
    end

    loadAnim(trunkAnim.dict)

    SetEntityCollision(ped, false, false)

    AttachEntityToEntity(
        ped,
        vehicle,
        0,
        0.0, -2.2, 0.45,
        0.0, 0.0, 0.0,
        false, false, false, false, 2, true
    )

    TaskPlayAnim(
        ped,
        trunkAnim.dict,
        trunkAnim.anim,
        8.0, -8.0, -1,
        1, 0, false, false, false
    )

    SetVehicleDoorOpen(vehicle, 5, false, false)

    inTrunk = true
    currentVehicle = vehicle
    blackScreen = true

    SetFollowPedCamViewMode(4) 

    Notify("Coffre", "Vous etes enferme dans le coffre", "inform")
end

local function exitTrunk()
    local ped = PlayerPedId()

    if not inTrunk then return end

    ClearPedTasks(ped)
    DetachEntity(ped, true, true)
    SetEntityCollision(ped, true, true)

    local coords = GetEntityCoords(ped)
    SetEntityCoords(ped, coords.x, coords.y - 1.5, coords.z)

    if currentVehicle then
        SetVehicleDoorShut(currentVehicle, 5, false)
    end

    inTrunk = false
    currentVehicle = nil
    blackScreen = false

    SetFollowPedCamViewMode(1)

    Notify("Coffre", "Vous etes sorti du coffre", "success")
end

CreateThread(function()
    while true do
        if blackScreen then
            Wait(0)
            DrawRect(0.5, 0.5, 1.0, 1.0, 0, 0, 0, 255)
            SetFollowPedCamViewMode(4)

            DisableControlAction(0, 0, true)
            DisableControlAction(0, 26, true)
        else
            Wait(500)
        end
    end
end)

exports.ox_target:addGlobalVehicle({
    {
        name = 'enter_trunk',
        icon = 'fa-solid fa-box',
        label = 'Monter dans le coffre',
        bones = { 'boot' },
        distance = 2.0,
        canInteract = function(entity)
            return not inTrunk and GetVehicleDoorAngleRatio(entity, 5) > 0.1
        end,
        onSelect = function(data)
            enterTrunk(data.entity)
        end
    }
})

exports.ox_target:addGlobalVehicle({
    {
        name = 'exit_trunk',
        icon = 'fa-solid fa-person-walking',
        label = 'Sortir du coffre',
        distance = 2.0,
        canInteract = function(entity)
            return inTrunk and entity == currentVehicle
        end,
        onSelect = function()
            exitTrunk()
        end
    }
})

CreateThread(function()
    while true do
        Wait(1000)
        if inTrunk and currentVehicle then
            if not DoesEntityExist(currentVehicle) then
                exitTrunk()
            end
        end
    end
end)