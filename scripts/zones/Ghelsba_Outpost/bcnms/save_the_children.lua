-----------------------------------
-- Area: Ghelsba Outpost
-- Name: San d'Oria Mission 1-3 Save the children
-- !pos -162 -11 78 140
-----------------------------------

require("scripts/globals/titles");
require("scripts/globals/keyitems");
require("scripts/globals/missions");
require("scripts/globals/battlefield")
local ID = require("scripts/zones/Ghelsba_Outpost/IDs");

-----------------------------------

function onBattlefieldTick(battlefield, tick)
    dsp.battlefield.onBattlefieldTick(battlefield, tick)
end

-- After registering the BCNM via bcnmRegister(bcnmid)
function onBattlefieldRegister(player,battlefield)
end;

-- Physically entering the BCNM via bcnmEnter(bcnmid)
function onBattlefieldEnter(player,battlefield)
end;

-- Leaving the BCNM by every mean possible, given by the LeaveCode
-- 1=Select Exit on circle
-- 2=Winning the BC
-- 3=Disconnected or warped out
-- 4=Losing the BC
-- via bcnmLeave(1) or bcnmLeave(2). LeaveCodes 3 and 4 are called
-- from the core when a player disconnects or the time limit is up, etc

function onBattlefieldLeave(player,battlefield,leavecode)
-- print(leave code ..leavecode);

    if leavecode == dsp.battlefield.leaveCode.WON then --play end CS. Need time and battle id for record keeping + storage
        local name, clearTime, partySize = battlefield:getRecord()
        if (player:hasCompletedMission(SANDORIA,dsp.mission.id.sandoria.SAVE_THE_CHILDREN)) then
            player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 1)
        else
            player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
        end
    elseif leavecode == dsp.battlefield.leaveCode.LOST then
        player:startEvent(32002);
    end

end;

function onEventUpdate(player,csid,option)
-- print(bc update csid ..csid.. and option ..option);
end;

function onEventFinish(player,csid,option)
-- print(bc finish csid ..csid.. and option ..option);

    if (csid == 32001 and option == 0 and player:getCurrentMission(SANDORIA) == dsp.mission.id.sandoria.SAVE_THE_CHILDREN and player:getVar("MissionStatus") == 2) then
        player:setTitle(dsp.title.FODDERCHIEF_FLAYER);
        player:addKeyItem(dsp.ki.ORCISH_HUT_KEY);
        player:messageSpecial(ID.text.KEYITEM_OBTAINED,dsp.ki.ORCISH_HUT_KEY);
        player:setVar("MissionStatus",3);
    end

end;
