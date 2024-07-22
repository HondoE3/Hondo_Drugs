local plants = {}

-- Gem data i databasen
RegisterNetEvent('drugscript:server:savePlant', function(plantData)
    local src = source
    local plantId = math.random(1000, 9999)
    plants[plantId] = plantData

    -- Gem i databasen
    exports.oxmysql:insert('INSERT INTO plants (id, type, coords, plantedTime, lastWatered) VALUES (?, ?, ?, ?, ?)', {
        plantId, plantData.type, json.encode(plantData.coords), plantData.plantedTime, plantData.lastWatered
    })

    -- Send data tilbage til client
    TriggerClientEvent('drugscript:client:loadPlants', -1, plants)
end)

-- Fjern data fra databasen
RegisterNetEvent('drugscript:server:removePlant', function(plantId)
    local src = source
    plants[plantId] = nil

    -- Fjern fra databasen
    exports.oxmysql:execute('DELETE FROM plants WHERE id = ?', { plantId })

    -- Send data tilbage til client
    TriggerClientEvent('drugscript:client:loadPlants', -1, plants)
end)

-- Giv item til spiller
RegisterNetEvent('drugscript:server:giveHarvestItem', function(plantType)
    local src = source
    local item = Config.HarvestItems[plantType]
    
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:AddItem(src, item, 1)
    elseif Config.Inventory == "qb_inventory" then
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.AddItem(item, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
    end
end)

-- Load data fra databasen ved server start
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        exports.oxmysql:execute('SELECT * FROM plants', {}, function(result)
            for _, plant in pairs(result) do
                local plantData = {
                    type = plant.type,
                    coords = json.decode(plant.coords),
                    plantedTime = plant.plantedTime,
                    lastWatered = plant.lastWatered,
                    prop = CreateObject(GetHashKey(Config.Plants[plant.type].props[1]), json.decode(plant.coords).x, json.decode(plant.coords).y, json.decode(plant.coords).z, true, true, true)
                }
                plants[plant.id] = plantData
            end
            TriggerClientEvent('drugscript:client:loadPlants', -1, plants)
        end)
    end
end)