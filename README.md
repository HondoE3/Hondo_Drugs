# Hondo's Totalt Sygt Seje Weed/Skunk/Svampe System

## Hvordan gør du?

1. Placer mappen inde i din `resources` mappe, eksempelvis `resources/[HONDO ER LÆKKER]/Hondo_Drugs`.

2. Tilføj `ensure Hondo_Drugs` til din `server.cfg`. Hvis du er en af de seje personer som starter en hel mappe af gangen kan du bare skippe dette.

3. Sørg for at du har følgende ressourcer installeret:
   - `ox_lib`
   - `oxmysql`
   - `qb-core` (hvis du bruger qb-core)
   - `qbx_core` (hvis du bruger qbx_core)
   - `qb-inventory` (hvis du bruger qb-inventory)
   - `ox_target`
   - `ox_inventory` (hvis du bruger ox_inventory)

4. Tilføj følgende kolonne til din database:

   ```sql
   CREATE TABLE `plants` (
     `id` INT NOT NULL AUTO_INCREMENT,
     `type` VARCHAR(50) NOT NULL,
     `coords` LONGTEXT NOT NULL,
     `plantedTime` INT NOT NULL,
     `lastWatered` INT NOT NULL,
     PRIMARY KEY (`id`)
   );
