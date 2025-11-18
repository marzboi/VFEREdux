require "ISBaseObject"

SpentCasingPhysics = {}
SpentCasingPhysics.activeCasings = {}

SpentCasingPhysics.GRAVITY = 0.005

function SpentCasingPhysics.addCasing(square, casingType, startX, startY, startZ, velocityX, velocityY, velocityZ)
    if not square then return end

    local casingData = {
        square = square,
        casingType = casingType,
        x = startX,
        y = startY,
        z = startZ,
        velocityX = velocityX or 0,
        velocityY = velocityY or 0,
        velocityZ = velocityZ or 0.1,
        active = true,
        currentWorldItem = nil
    }

    casingData.currentWorldItem = square:AddWorldInventoryItem(casingType, startX, startY, startZ)

    table.insert(SpentCasingPhysics.activeCasings, casingData)
end

function SpentCasingPhysics.update()
    local i = 1
    while i <= #SpentCasingPhysics.activeCasings do
        local casing = SpentCasingPhysics.activeCasings[i]

        if not casing.square or not casing.active then
            table.remove(SpentCasingPhysics.activeCasings, i)
        else
            casing.velocityZ = casing.velocityZ - SpentCasingPhysics.GRAVITY

            casing.x = casing.x + casing.velocityX
            casing.y = casing.y + casing.velocityY
            casing.z = casing.z + casing.velocityZ

            casing.x = PZMath.clamp_01(casing.x)
            casing.y = PZMath.clamp_01(casing.y)
            casing.z = math.max(0, casing.z)

            if casing.currentWorldItem then
                casing.square:removeWorldObject(casing.currentWorldItem:getWorldItem())
                casing.currentWorldItem = nil
            end

            if casing.z > 0 then
                casing.currentWorldItem = casing.square:AddWorldInventoryItem(
                    casing.casingType,
                    casing.x,
                    casing.y,
                    casing.z
                )
            else
                casing.square:AddWorldInventoryItem(
                    casing.casingType,
                    casing.x,
                    casing.y,
                    0.0
                )
                casing.active = false
                table.remove(SpentCasingPhysics.activeCasings, i)
                i = i - 1
            end
            i = i + 1
        end
    end
end

Events.OnTick.Add(SpentCasingPhysics.update)

function SpentCasingPhysics.getActiveCount()
    return #SpentCasingPhysics.activeCasings
end

function SpawnCasing(playerObj, weapon)
    if not playerObj or playerObj:isDead() then return end
    if not weapon then return end
    if not weapon:isRanged() then return end

    if weapon:getWeaponReloadType() == "revolver"
        or weapon:getWeaponReloadType() == "doublebarrelshotgun"
        or weapon:getWeaponReloadType() == "doublebarrelshotgunsawn"
        or weapon:getWeaponReloadType() == "breechloader"
    then
        return
    end

    local gun = weapon:getType()
    local gunAmmo, replaced = string.gsub(weapon:getAmmoType(), "Base.", "")

    if weapon and weapon:isRanged() then
        local random_f = newrandom()
        local square = playerObj:getCurrentSquare()
        if not square then return end

        local casingType = "Base." .. gunAmmo .. "_Casing"

        local playerWorldX = playerObj:getX()
        local playerWorldY = playerObj:getY()

        local startX = playerWorldX - square:getX()
        local startY = playerWorldY - square:getY()

        local angle = math.rad(playerObj:getDirectionAngle())
        local sideOffset = 0.30

        startX = startX + math.cos(angle + math.pi / 2) * sideOffset
        startY = startY + math.sin(angle + math.pi / 2) * sideOffset
        local startZ = 0.6

        local velX = (random_f:random(10) - 5) / 200
        local velY = (random_f:random(10) - 5) / 200
        local velZ = (random_f:random(10) + 15) / 200

        SpentCasingPhysics.addCasing(square, casingType, startX, startY, startZ, velX, velY, velZ)
    end
end

Events.OnWeaponSwing.Add(SpawnCasing)
