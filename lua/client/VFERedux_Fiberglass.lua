local function modelSetter(weapon)
    VFESetWeaponModel(weapon, false)
    VFESetWeaponIcon(weapon)
end

local ISRemoveWeaponUpgrade_completeHook = ISRemoveWeaponUpgrade.complete
function ISRemoveWeaponUpgrade:complete()
    local part = self.weapon:getWeaponPart(self.partType)

    if part and part:getFullType() == "Base.FiberglassStock" then
        self.weapon:detachWeaponPart(part)
    end

    modelSetter(self.weapon)
    ISRemoveWeaponUpgrade_completeHook(self)
end

local ISUpgradeWeapon_completeHook = ISUpgradeWeapon.complete
function ISUpgradeWeapon:complete()
    local part = self.part

    if part and part:getFullType() == "Base.FiberglassStock" then
        self.weapon:attachWeaponPart(part)
    end

    modelSetter(self.weapon)
    ISUpgradeWeapon_completeHook(self)
end
