require "ISUI/ISInventoryPaneContextMenu"

-- I need a copy of this I guess
local function predicateNotBroken(item)
    return not item:isBroken()
end

VFEContext = {}

VFEContext.inventoryMenu = function(playerid, context, items)
    local player = getSpecificPlayer(playerid)
    for _, v in ipairs(items) do
        local item = v
        if not instanceof(v, "InventoryItem") then
            item = v.items[1]
        end
        if instanceof(item, "HandWeapon") then
            local isInInventory = item:getContainer() == player:getInventory()
            -- Bayonet weapons
            for index, preset in ipairs(VFEBayonetSet) do
                if index % 3 > 0 and preset == item:getFullType() then
                    VFEContext:Bayonet(item, index, player, context, isInInventory)
                end
            end
            -- Folding weapon stock and upgrade actions
            for index, preset in ipairs(VFEFoldingWeaponPair) do
                if preset == item:getFullType() then
                    local indexMod = (index % 2) * 2 - 1 -- 1 if stock can be folded, -1 if stock can be extended
                    VFEContext:Stock(item, index, indexMod, player, context, isInInventory)
                end
            end
            -- Alt weapon operation
            local altOperationList = VFEAltOperationSetCheck(item)
            if #altOperationList > 0 then
                for index, altOperation in ipairs(altOperationList) do
                    local target = 2
                    if altOperation.Name[2] == item:getFullType() then
                        target = 1
                    end
                    if altOperation.RequireEmpty then
                        if not (item:isContainsClip() and altOperation.RequireNoMag) and not (item:getCurrentAmmoCount() > 0) and not item:isRoundChambered() then
                            VFEContext:AltOperation(item, target, player, context, altOperation, isInInventory)
                        end
                    else
                        VFEContext:AltOperation(item, target, player, context, altOperation, isInInventory)
                    end
                end
            end

            -- To Do
            VFEContext:UpgradeSling(item, player, context)
            VFEContext:UpgradeSling2(item, player, context)
            VFEContext:UpgradeCoupleMags(item, player, context)
            VFEContext:UpgradeIrons(item, player, context)
        end
    end
end

function VFEContext:Stock(item, index, indexMod, player, context, enabled)
    local actionString = ""
    if (indexMod > 0) then
        actionString = getText("IGUI_FirearmRadial_FoldStock")
    else
        actionString = getText("IGUI_FirearmRadial_UnfoldStock")
    end
    local listEntry = context:addOption(actionString, item, VFEStockContext.callAction, index + indexMod, player)

    local tooltip = ISInventoryPaneContextMenu.addToolTip();
    tooltip.description = ""
    if (indexMod > 0) then
        actionString = getText("IGUI_ContextMenu_FoldStockArg", item:getDisplayName())
    else
        actionString = getText("IGUI_ContextMenu_UnfoldStockArg", item:getDisplayName())
    end
    tooltip:setName(tostring(actionString .. "\n"))
    tooltip.texture = item:getTex()

    if enabled then
        if (indexMod > 0) then
            tooltip.description = tooltip.description ..
                getText("IGUI_ContextMenu_AddSlingDescription") -- This happens so be the thing
        else
            tooltip.description = tooltip.description .. getText("IGUI_ContextMenu_RestoreStock")
        end
    else
        listEntry.notAvailable = true
        tooltip.description = tooltip.description .. getText("IGUI_ContextMenu_MoveToInv")
    end

    listEntry.toolTip = tooltip;
end

function VFEContext:UpgradeIrons(item, player, context)
    local hasScrewdriver = player:getInventory():containsTagEvalRecurse("Screwdriver", predicateNotBroken)
    if item and instanceof(item, "HandWeapon") and item:isRanged() and hasScrewdriver then
        -- add parts
        local weaponParts = player:getInventory():getItemsFromCategory("WeaponPart");
        if weaponParts and not weaponParts:isEmpty() then
            for i = 0, weaponParts:size() - 1 do
                local part = weaponParts:get(i);
                local allowedWeapons = part:getMountOn();
                if (part:getType() == "IronSight") and not item:getScope() and allowedWeapons:contains(item:getFullType()) then
                    -- To do: Localization
                    local listEntry = context:addOption(getText("IGUI_ContextMenu_AddSights"), item,
                        ISInventoryPaneContextMenu.onUpgradeWeapon, part, player);
                    local tooltip = ISInventoryPaneContextMenu.addToolTip();
                    tooltip.description = getText("IGUI_ContextMenu_AddSightsDescription")
                    tooltip:setName(part:getDisplayName())
                    tooltip.texture = part:getTex()
                    listEntry.toolTip = tooltip;
                    break
                end
            end
        end
    end
end

function VFEContext:UpgradeSling(item, player, context)
    local hasScrewdriver = player:getInventory():containsTagEvalRecurse("Screwdriver", predicateNotBroken)
    if item and instanceof(item, "HandWeapon") and item:isRanged() and hasScrewdriver then
        -- add parts
        local weaponParts = player:getInventory():getItemsFromCategory("WeaponPart");
        if weaponParts and not weaponParts:isEmpty() then
            for i = 0, weaponParts:size() - 1 do
                local part = weaponParts:get(i);
                local allowedWeapons = part:getMountOn();
                if (part:getType() == "Sling") and not item:getWeaponPart("Sling") and allowedWeapons:contains(item:getFullType()) then
                    local listEntry = context:addOption(getText("IGUI_ContextMenu_AddSling"), item,
                        ISInventoryPaneContextMenu.onUpgradeWeapon, part, player);
                    local tooltip = ISInventoryPaneContextMenu.addToolTip();
                    tooltip.description = getText("IGUI_ContextMenu_AddSlingDescription")
                    tooltip:setName(part:getDisplayName())
                    tooltip.texture = part:getTex()
                    listEntry.toolTip = tooltip;
                    break
                end
            end
        end
    end
end

function VFEContext:UpgradeSling2(item, player, context)
    local hasScrewdriver = player:getInventory():containsTagEvalRecurse("Screwdriver", predicateNotBroken)
    if item and instanceof(item, "HandWeapon") and item:isRanged() and hasScrewdriver then
        -- add parts
        local weaponParts = player:getInventory():getItemsFromCategory("WeaponPart");
        if weaponParts and not weaponParts:isEmpty() then
            for i = 0, weaponParts:size() - 1 do
                local part = weaponParts:get(i);
                local allowedWeapons = part:getMountOn();
                if (part:getType() == "Sling2") and not item:getWeaponPart("Sling") and allowedWeapons:contains(item:getFullType()) then
                    -- To do: Localization
                    local listEntry = context:addOption(getText("IGUI_ContextMenu_AddSling2"), item,
                        ISInventoryPaneContextMenu.onUpgradeWeapon, part, player);
                    local tooltip = ISInventoryPaneContextMenu.addToolTip();
                    tooltip.description = getText("IGUI_ContextMenu_AddSlingDescription")
                    tooltip:setName(part:getDisplayName())
                    tooltip.texture = part:getTex()
                    listEntry.toolTip = tooltip;
                    break
                end
            end
        end
    end
end

function VFEContext:UpgradeCoupleMags(item, player, context)
    local hasScrewdriver = player:getInventory():containsTagEvalRecurse("Screwdriver", predicateNotBroken)
    if item and instanceof(item, "HandWeapon") and item:isRanged() and hasScrewdriver then
        -- add parts
        local weaponParts = player:getInventory():getItemsFromCategory("WeaponPart");
        if weaponParts and not weaponParts:isEmpty() then
            for i = 0, weaponParts:size() - 1 do
                local part = weaponParts:get(i);
                local allowedWeapons = part:getMountOn();
                if (part:getType() == "Coupled762") or (part:getType() == "Coupled556") and not item:getWeaponPart("JungleMag") and allowedWeapons:contains(item:getFullType()) then
                    -- To do: Localization
                    local listEntry = context:addOption(getText("IGUI_ContextMenu_JungleMags"), item,
                        ISInventoryPaneContextMenu.onUpgradeWeapon, part, player);
                    local tooltip = ISInventoryPaneContextMenu.addToolTip();
                    tooltip.description = getText("IGUI_ContextMenu_JungleMagsDescription")
                    tooltip:setName(part:getDisplayName())
                    tooltip.texture = part:getTex()
                    listEntry.toolTip = tooltip;
                    break
                end
            end
        end
    end
end

function VFEContext:Bayonet(item, index, player, context, enabled)
    local bayonetFound
    local bayonet = nil
    local bayonetScript = nil
    local parts = item:getAllWeaponParts()
    local bayonetBlocked = nil
    for i = 1, parts:size() do
        if parts:get(i - 1):hasTag("BlockBayonet") then
            bayonetBlocked = parts:get(i - 1)
            break
        end
    end
    if index % 3 == 1 then
        if VFEBayonetSet[index + 2] ~= "NULL" then
            bayonetScript = getScriptManager():getItem(VFEBayonetSet[index + 2])
            local playerItems = player:getInventory():getItems()
            for i = 1, playerItems:size() do
                bayonet = playerItems:get(i - 1)
                if bayonet:getFullType() == VFEBayonetSet[index + 2] and not bayonet:isBroken() then
                    bayonetFound = true
                    break
                end
            end
        else
            bayonetFound = true
        end
    else
        if VFEBayonetSet[index + 1] ~= "NULL" then
            bayonetScript = getScriptManager():getItem(VFEBayonetSet[index + 1])
        end
        bayonetFound = true
    end

    local actionString = ""
    if item:getSubCategory() == "Firearm" then
        actionString = getText("IGUI_FirearmRadial_UseBayonet")
    else
        actionString = getText("IGUI_FirearmRadial_UseRifle")
    end

    local listEntry = context:addOption(actionString, item, VFEBayonetContext.callAction, index, player, bayonet)

    local tooltip = ISInventoryPaneContextMenu.addToolTip();
    tooltip.description = ""
    if bayonetBlocked == nil then
        tooltip:setName(actionString)
        if bayonetScript then
            tooltip.texture = getTexture("media/textures/Item_" .. bayonetScript:getIcon() .. ".png")
        else
            tooltip.texture = item:getTex()
        end
    else
        blockedScript = getScriptManager():getItem(bayonetBlocked:getFullType())
        tooltip:setName(getText("IGUI_ContextMenu_BayonetBlocked"))
        tooltip.texture = getTexture("media/textures/Item_" .. blockedScript:getIcon() .. ".png")
    end

    if enabled then
        if bayonetFound then
            if bayonetBlocked == nil then
                if item:getSubCategory() == "Firearm" then
                    tooltip.description = tooltip.description .. getText("IGUI_ContextMenu_AttackBayonet")
                else
                    tooltip.description = tooltip.description .. getText("IGUI_ContextMenu_AttackRifle")
                end
            else
                listEntry.notAvailable = true
                tooltip.description = tooltip.description ..
                    getText("IGUI_ContextMenu_BayonetBlockedArg", bayonetBlocked:getDisplayName())
            end
        else
            listEntry.notAvailable = true
            tooltip.description = tooltip.description ..
                getText("IGUI_ContextMenu_RequiresBayonet", bayonetScript:getDisplayName())
        end
    else
        listEntry.notAvailable = true
        if bayonetBlocked == nil then
            tooltip.description = tooltip.description .. getText("IGUI_ContextMenu_MoveToInv")
        else
            tooltip.description = tooltip.description ..
                getText("IGUI_ContextMenu_BayonetBlockedArg", bayonetBlocked:getDisplayName())
        end
    end

    listEntry.toolTip = tooltip;
end

function VFEContext:AltOperation(item, target, player, context, altOperation, enabled)
    local actionString = ""
    actionString = getText(altOperation.OperationText[target])

    local listEntry = context:addOption(actionString, item, VFEAltOperationContext.callAction, altOperation, target,
        player)

    local tooltip = ISInventoryPaneContextMenu.addToolTip();
    actionString = getText(altOperation.OperationText[target] .. "Arg", item:getDisplayName())
    tooltip:setName(tostring(actionString .. "\n"))
    tooltip.texture = getTexture("media/textures/item_" ..
        ScriptManager.instance:getItem(altOperation.Name[target]):getIcon() .. ".png")
    if not enabled then
        listEntry.notAvailable = true
        tooltip.description = tooltip.description .. getText("IGUI_ContextMenu_MoveToInv")
    else
        tooltip.description = tooltip.description .. getText(altOperation.OperationText[target] .. "Tooltip")
    end

    listEntry.toolTip = tooltip;
end

Events.OnPreFillInventoryObjectContextMenu.Add(VFEContext.inventoryMenu)
