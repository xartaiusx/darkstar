-----------------------------------
--  Area: West Ronfaure (100)
--  NM:      Jaggedy-Eared_Jack
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, player, isKiller)
end;

-----------------------------------
-- onMobDespawn
-----------------------------------

function onMobDespawn(mob)

    -- Set Jaggedy-Eared_Jack's Window Open Time, and disable respawn
    local wait = math.random((3000),(21600));
    SetServerVariable("[POP]Jaggedy_Eared_Jack", os.time() + wait); -- 50 minutes - 6 hours
    DisallowRespawn(mob:getID(), true);

    -- Set PH back to normal, then set to respawn spawn
    local PH = GetServerVariable("[PH]Jaggedy_Eared_Jack");
    SetServerVariable("[PH]Jaggedy_Eared_Jack", 0);
    DisallowRespawn(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));

end;

