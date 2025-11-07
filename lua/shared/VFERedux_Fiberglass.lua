-- local ISUpgradeWeapon_perform_old = ISUpgradeWeapon.perform
-- function ISUpgradeWeapon:perform()
--     ISUpgradeWeapon_perform_old(self)
--     print('UPGRADING')
--     VFESetWeaponModel(self.weapon, false)
-- end

-- local ISRemoveWeaponUpgrade_perform_old = ISRemoveWeaponUpgrade.perform
-- function ISRemoveWeaponUpgrade:perform()
--     ISRemoveWeaponUpgrade_perform_old(self)
--     print('DOWNGRADING')
--     VFESetWeaponModel(self.weapon, false)
-- end

function FiberglassStock(wielder, weapon)
    if not weapon or not weapon:IsWeapon() or not weapon:isRanged() then return end
    VFESetWeaponModel(weapon, false)
end

Events.OnEquipPrimary.Add(FiberglassStock)

Events.OnGameStart.Add(function()
    local player = getPlayer()
    FiberglassStock(player, player:getPrimaryHandItem())
end)
