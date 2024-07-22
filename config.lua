Config = {}
Config.Inventory = "qb-inventory"  -- Ændr til "qb-inventory" hvis du bruger qb-inventory. Supporter ox_inventory og qb-inventory for nu.
Config.Plants = {
    ["weed"] = {
        growTime = 5 * 60 * 60,  -- 5 timer
        waterTime = 4 * 60 * 60,  -- 4 timer
        props = {
            "bkr_prop_weed_01_small_01c", -- Stage 1
            "bkr_prop_weed_01_small_01b", -- Stage 2
            "bkr_prop_weed_lrg_01a" -- Stage 3
        }
    },
    ["skunk"] = {
        growTime = 5 * 60 * 60,  -- 5 timer
        waterTime = 4 * 60 * 60,  -- 4 timer
        props = {
            "bkr_prop_weed_01_small_01c", -- Stage 1
            "bkr_prop_weed_01_small_01b", -- Stage 2
            "bkr_prop_weed_lrg_01a" -- Stage 3
        }
    },
    ["shrooms"] = {
        growTime = 5 * 60 * 60,  -- 5 timer
        waterTime = 4 * 60 * 60,  -- 4 timer
        props = {
            "bkr_prop_weed_01_small_01c", -- Stage 1
            "bkr_prop_weed_01_small_01b", -- Stage 2
            "bkr_prop_weed_lrg_01a" -- Stage 3
        }
    }
}
Config.PotItem = "plant_pot"  -- Krukke item, husk at tilføje det i shared/items.lua
Config.HarvestItems = {
    ["weed"] = "weed_seed", -- Weed frø hvis det ikke gav sig selv
    ["skunk"] = "skunk_seed", -- Skunk frø
    ["shrooms"] = "shrooms_seed" -- Svampe frø
}
Config.PoliceConfiscationReward = 5000  -- Beløb politiet modtager for konfiskation
