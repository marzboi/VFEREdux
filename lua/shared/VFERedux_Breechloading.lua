require "TimedActions/ISReloadWeaponAction"
require "TimedActions/ISRackFirearm"

local ISReloadWeaponAction_stop_old = ISReloadWeaponAction.stop
function ISReloadWeaponAction:stop()
    VFESetWeaponModel(self.gun, false)
    self:setOverrideHandModels(self.gun, nil)
    self.character:setPrimaryHandItem(self.gun);
    if self.gun:isTwoHandWeapon() then
        self.character:setSecondaryHandItem(self.gun);
    end
    return ISReloadWeaponAction_stop_old(self)
end

local ISReloadWeaponAction_animEvent_old = ISReloadWeaponAction.animEvent
function ISReloadWeaponAction:animEvent(event, parameter)
    if event == 'loadFinished' then
        VFESetWeaponModel(self.gun, false)
        return ISReloadWeaponAction_animEvent_old(self, event, parameter)
    end
    if event == 'changeWeaponSprite' then
        if parameter and parameter ~= '' then
            if parameter == 'open' then
                VFESetWeaponModel(self.gun, true)
                self:setOverrideHandModels(self.gun, nil)
            elseif parameter ~= 'original' then
                self.gun:setWeaponSprite(parameter)
                self:setOverrideHandModels(self.gun, nil)
            else
                VFESetWeaponModel(self.gun, false)
                self:setOverrideHandModels(self.gun, nil)
            end
        end
    else
        return ISReloadWeaponAction_animEvent_old(self, event, parameter)
    end
end

local ISRackFirearm_stop_old = ISRackFirearm.stop
function ISRackFirearm:stop()
    VFESetWeaponModel(self.gun, false)
    self:setOverrideHandModels(self.gun, nil)
    self.character:setPrimaryHandItem(self.gun);
    if self.gun:isTwoHandWeapon() then
        self.character:setSecondaryHandItem(self.gun);
    end
    return ISRackFirearm_stop_old(self)
end

local ISRackFirearm_animEvent_old = ISRackFirearm.animEvent
function ISRackFirearm:animEvent(event, parameter)
    if event == 'unloadFinished' then
        VFESetWeaponModel(self.gun, false)
        return ISRackFirearm_animEvent_old(self, event, parameter)
    end
    if event == 'rackingFinished' then
        VFESetWeaponModel(self.gun, false)
        return ISRackFirearm_animEvent_old(self, event, parameter)
    end
    if event == 'changeWeaponSprite' then
        if parameter and parameter ~= '' then
            if parameter == 'open' then
                VFESetWeaponModel(self.gun, true)
            elseif parameter ~= 'original' then
                self.gun:setWeaponSprite(parameter)
            else
                VFESetWeaponModel(self.gun, false)
            end
            self:setOverrideHandModels(self.gun, nil)
            self.character:setPrimaryHandItem(self.gun);
            if self.gun:isTwoHandWeapon() then
                self.character:setSecondaryHandItem(self.gun);
            end
        end
    else
        return ISRackFirearm_animEvent_old(self, event, parameter)
    end
end
