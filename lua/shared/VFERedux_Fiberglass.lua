require "TimedActions/ISBaseTimedAction"

function FiberglassStock(wielder, weapon)
    if not weapon or not weapon:IsWeapon() or not weapon:isRanged() then return end

    local baseSprite = weapon:getWeaponSprite()

    baseSprite = string.gsub(baseSprite, "FGS$", "")

    local stock = weapon:getWeaponPart("Stock")

    if stock and string.find(stock:getType(), "FiberglassStock") then
        weapon:setWeaponSprite(baseSprite .. "FGS")
    else
        weapon:setWeaponSprite(baseSprite)
    end
end

Events.OnEquipPrimary.Add(FiberglassStock)

Events.OnGameStart.Add(function()
    local player = getPlayer()
    FiberglassStock(player, player:getPrimaryHandItem())
end)
