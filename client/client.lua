local plants = {}

-- Hent data
RegisterNetEvent('drugscript:client:loadPlants', function(loadedPlants)
    plants = loadedPlants
end)

-- Plant frø
RegisterNetEvent('drugscript:client:plantSeed', function(plantType, coords)
    local prop = Config.Plants[plantType].props[1]
    local plant = CreateObject(GetHashKey(prop), coords.x, coords.y, coords.z, true, true, true)
    FreezeEntityPosition(plant, true)

    local plantData = {
        type = plantType,
        prop = plant,
        coords = coords,
        plantedTime = os.time(),
        lastWatered = os.time()
    }

    TriggerServerEvent('drugscript:server:savePlant', plantData)
end)

-- Høst 
RegisterNetEvent('drugscript:client:harvestPlant', function(plantId)
    local plantData = plants[plantId]
    if plantData then
        DeleteObject(plantData.prop)
        plants[plantId] = nil
        TriggerServerEvent('drugscript:server:removePlant', plantId)
        TriggerServerEvent('drugscript:server:giveHarvestItem', plantData.type)
    end
end)

-- Opdater status
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for id, plantData in pairs(plants) do
            local currentTime = os.time()
            local growTime = currentTime - plantData.plantedTime

            if growTime > Config.Plants[plantData.type].growTime then
                plantData.stage = 3
            elseif growTime > Config.Plants[plantData.type].growTime / 2 then
                plantData.stage = 2
            else
                plantData.stage = 1
            end

            if currentTime - plantData.lastWatered > Config.Plants[plantData.type].waterTime then
                DeleteObject(plantData.prop)
                plants[id] = nil
                TriggerServerEvent('drugscript:server:removePlant', id)
            else
                local prop = Config.Plants[plantData.type].props[plantData.stage]
                DeleteObject(plantData.prop)
                plantData.prop = CreateObject(GetHashKey(prop), plantData.coords.x, plantData.coords.y, plantData.coords.z, true, true, true)
                FreezeEntityPosition(plantData.prop, true)
            end
        end
    end
end)

-- Brug ox_target på props
exports.ox_target:addModel(Config.Plants.weed.props, {
    options = {
        {
            label = 'Tjek plante',
            event = 'drugscript:client:checkPlant',
            icon = 'fas fa-seedling'
        },
        {
            label = 'Høst plante',
            event = 'drugscript:client:harvestPlant',
            icon = 'fas fa-hand-scythe'
        },
        {
            label = 'Ødelæg plante',
            event = 'drugscript:client:destroyPlant',
            icon = 'fas fa-trash'
        }
    },
    distance = 2.5
})

-- Tjek status
RegisterNetEvent('drugscript:client:checkPlant', function(data)
    local plantId = data.entity
    local plantData = plants[plantId]

    if plantData then
        local timeRemaining = Config.Plants[plantData.type].growTime - (os.time() - plantData.plantedTime)
        local waterRemaining = Config.Plants[plantData.type].waterTime - (os.time() - plantData.lastWatered)

        exports.ox_lib:contextMenu({
            {
                title = 'Frø: ' .. plantData.type,
                description = 'Tid tilbage: ' .. timeRemaining .. ' sekunder'
            },
            {
                title = 'Tid til vanding: ' .. waterRemaining .. ' sekunder',
                description = 'Status: ' .. (waterRemaining > 0 and 'Vandet' or 'Skal vandes')
            }
        })
    end
end)

-- Ødelæg plante
RegisterNetEvent('drugscript:client:destroyPlant', function(data)
    local plantId = data.entity
    local plantData = plants[plantId]

    if plantData then
        DeleteObject(plantData.prop)
        plants[plantId] = nil
        TriggerServerEvent('drugscript:server:removePlant', plantId)
    end
end)