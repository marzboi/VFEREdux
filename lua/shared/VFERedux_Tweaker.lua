-- from the crab man - hope this helps you, riku!

VFETweaks = VFETweaks or {};

-- single item mode. example:
-- VFETweaks:tweak("Base.HuntingRifle", {
--    ["MinDamage"] = 2.5,
--    ["MaxDamage"] = 2.7,
-- });

function VFETweaks:tweak(scriptId, changes)
    local script = ScriptManager.instance:getItem(scriptId);

    if script
    then
        for param, value in pairs(changes)
        do
            script:DoParam(param .. " = " .. value);
        end
    end

    return script;
end

-- batch mode. example:
-- VFETweaks:tweakMultiple({
--    ["Base.AK47"] = {
--        ["MinDamage"] = 2.1,
--    },
--    ["Base.SKS"] = {
--        ["MaxDamage"] = 2.3,
--        ["ConditionMax"] = 20,
--    },
--    ...
-- });

function VFETweaks:tweakMultiple(scriptAndChanges)
    for scriptId, changes in pairs(scriptAndChanges)
    do
        VFETweaks:tweak(scriptId, changes);
    end
end

-- add additional item(s) to mount an attachment on without redefining the whole param.
-- example for single mode:
-- VFETweaks:addToMountOn("Base.x2Scope", "Base.SCARH");
-- example for multi mode:
-- VFETweaks:addToMountOn("Base.x2Scope", {
--    "Base.SCARH", "Base.ShotgunSawnoff"
--});

function VFETweaks:addToMountOn(attachment, addValues)
    local attachmentScript = ScriptManager.instance:getItem(attachment);

    if attachmentScript then
        local attachmentItem = instanceItem(attachment);
        local mountOptions = attachmentItem:getMountOn();
        local newList = {};

        for i, addValue in ipairs(type(addValues) ~= "table"
            and {
                addValues
            }
            or addValues
        )
        do
            if not mountOptions:contains(addValue) and instanceItem(addValue)
            then
                table.insert(newList, addValue);
            end
        end

        if #newList > 0
        then
            for i = 0, mountOptions:size() - 1
            do
                local weapon = mountOptions:get(i);

                if weapon and instanceItem(weapon)
                then
                    table.insert(newList, weapon);
                end
            end

            attachmentScript:DoParam("MountOn = " .. table.concat(newList, "; "));
        end
    end

    return attachmentScript;
end
