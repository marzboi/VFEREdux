local function modelSetter(weapon)
    VFESetWeaponModel(weapon, false)
    VFESetWeaponIcon(weapon)
end

local ISRemoveWeaponUpgrade_completeHook = ISRemoveWeaponUpgrade.complete
function ISRemoveWeaponUpgrade:complete()
    local part = self.weapon:getWeaponPart(self.partType)
    self.weapon:detachWeaponPart(part)

    modelSetter(self.weapon)
    ISRemoveWeaponUpgrade_completeHook(self)
end

local ISUpgradeWeapon_completeHook = ISUpgradeWeapon.complete
function ISUpgradeWeapon:complete()
    self.weapon:attachWeaponPart(self.part)

    modelSetter(self.weapon)
    ISUpgradeWeapon_completeHook(self)
end
