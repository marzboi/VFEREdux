local function refreshSpriteNextTick(weapon)
    local w = weapon
    local function once()
        Events.OnTick.Remove(once)
        VFESetWeaponModel(w, false)
        VFESetWeaponIcon(w)
    end
    Events.OnTick.Add(once)
end

-- local ISUpgradeWeapon_perform_old = ISUpgradeWeapon.perform
-- function ISUpgradeWeapon:perform()
--     ISUpgradeWeapon_perform_old(self)
--     refreshSpriteNextTick(self.weapon)
-- end

-- local ISRemoveWeaponUpgrade_perform_old = ISRemoveWeaponUpgrade.perform
-- function ISRemoveWeaponUpgrade:perform()
--     ISRemoveWeaponUpgrade_perform_old(self)
--     refreshSpriteNextTick(self.weapon)
-- end

local ISRemoveWeaponUpgrade_performHook = ISRemoveWeaponUpgrade.perform
function ISRemoveWeaponUpgrade:perform()
    local clip = self.weapon:getWeaponPart("Clip")
    local scope = self.weapon:getWeaponPart("Scope")
    local sling = self.weapon:getWeaponPart("Sling")
    local canon = self.weapon:getWeaponPart("Canon")
    local stock = self.weapon:getWeaponPart("Stock")
    local pad = self.weapon:getWeaponPart("RecoilPad")

    if scope then
        if scope:getFullType() == "Base.x2Scope_Fake" then
            self.weapon:detachWeaponPart(self.part)
            self.character:getInventory():DoRemoveItem(self.part)
            self.part = instanceItem("Base.x2Scope")
        elseif scope:getFullType() == "Base.x4Scope_Fake" then
            self.weapon:detachWeaponPart(self.part)
            self.character:getInventory():DoRemoveItem(self.part)
            self.part = instanceItem("Base.x4Scope")
        elseif scope:getFullType() == "Base.x8Scope_Fake" then
            self.weapon:detachWeaponPart(self.part)
            self.character:getInventory():DoRemoveItem(self.part)
            self.part = instanceItem("Base.x8Scope")
        end
    end

    ISRemoveWeaponUpgrade_performHook(self)
    refreshSpriteNextTick(self.weapon)
end

local ISUpgradeWeapon_performHook = ISUpgradeWeapon.perform
function ISUpgradeWeapon:perform()
    local clip = self.weapon:getWeaponPart("Clip")
    local scope = self.weapon:getWeaponPart("Scope")
    local sling = self.weapon:getWeaponPart("Sling")
    local canon = self.weapon:getWeaponPart("Canon")
    local stock = self.weapon:getWeaponPart("Stock")
    local pad = self.weapon:getWeaponPart("RecoilPad")

    if scope then
        if scope:getFullType() == "Base.x2Scope_Fake" then
            self.character:getInventory():DoRemoveItem(self.part)
            self.part = instanceItem("Base.x2Scope")
        elseif scope:getFullType() == "Base.x4Scope_Fake" then
            self.character:getInventory():DoRemoveItem(self.part)
            self.part = instanceItem("Base.x4Scope")
        elseif scope:getFullType() == "Base.x8Scope_Fake" then
            self.character:getInventory():DoRemoveItem(self.part)
            self.part = instanceItem("Base.x8Scope")
        end
    end

    ISUpgradeWeapon_performHook(self)
    refreshSpriteNextTick(self.weapon)
end
