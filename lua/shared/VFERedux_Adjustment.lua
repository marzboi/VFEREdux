local function Adjust(Name, Property, Value)
    local Item = ScriptManager.instance:getItem(Name)
    Item:DoParam(Property .. " = " .. Value)
end

-- Magazine Icons --
Adjust("Base.9mmClip", "icon", "9mmClip")
Adjust("Base.44Clip", "icon", "44Clip")
Adjust("Base.45Clip", "icon", "45Clip")
Adjust("Base.308Clip", "icon", "308Clip")
Adjust("Base.556Clip", "icon", "556Clip")
Adjust("Base.M14Clip", "icon", "M14Clip")

-- Ammo Icons --
Adjust("Base.308Box", "icon", "308AmmoBox")
Adjust("Base.556Box", "icon", "556AmmoBox")
Adjust("Base.223Box", "icon", "223AmmoBox")
Adjust("Base.ShotgunShells", "icon", "ShotgunShell")
Adjust("Base.Bullets9mm", "icon", "9Bullets")
Adjust("Base.Bullets45", "icon", "45Bullets")
Adjust("Base.Bullets44", "icon", "44Bullets")
Adjust("Base.Bullets38", "icon", "38Bullets")
Adjust("Base.308Bullets", "icon", "308Bullets")
Adjust("Base.556Bullets", "icon", "556Bullets")
Adjust("Base.223Bullets", "icon", "223Bullets")

-- Ammo Box Icons --
Adjust("Base.Bullets38Box", "icon", "38AmmoBox")
Adjust("Base.Bullets44Box", "icon", "44AmmoBox")
Adjust("Base.Bullets45Box", "icon", "45AmmoBox")
Adjust("Base.Bullets9mmBox", "icon", "9AmmoBox")
Adjust("Base.ShotgunShellsBox", "icon", "ShotgunShellsBox")
Adjust("Base.308Box", "WorldStaticModel", "308Box")
Adjust("Base.556Box", "WorldStaticModel", "556Box")
Adjust("Base.223Box", "WorldStaticModel", "223Box")

-- Ammo World Models --
Adjust("Base.ShotgunShells", "WorldStaticModel", "ShotgunShells")
Adjust("Base.Bullets9mm", "WorldStaticModel", "Bullets9mm")
Adjust("Base.Bullets45", "WorldStaticModel", "Bullets45")
Adjust("Base.Bullets44", "WorldStaticModel", "Bullets44")
Adjust("Base.Bullets38", "WorldStaticModel", "Bullets38")
Adjust("Base.308Bullets", "WorldStaticModel", "308Bullets")
Adjust("Base.556Bullets", "WorldStaticModel", "556Bullets")
Adjust("Base.223Bullets", "WorldStaticModel", "223Bullets")

-- Magazine World Models --
Adjust("Base.M14Clip", "WorldStaticModel", "Magazine_M14")
Adjust("Base.9mmClip", "WorldStaticModel", "Magazine_9mm")
Adjust("Base.45Clip", "WorldStaticModel", "Magazine_45")
Adjust("Base.44Clip", "WorldStaticModel", "Magazine_44")
Adjust("Base.308Clip", "WorldStaticModel", "Magazine_308")
Adjust("Base.556Clip", "WorldStaticModel", "Magazine_M16")

-- Ammo Weights --
Adjust("Base.Bullets45", "weight", "0.02")
Adjust("Base.Bullets44", "weight", "0.03")
Adjust("Base.308Bullets", "weight", "0.03")
Adjust("Base.556Bullets", "weight", "0.02")

-- Ammo Box Weights --
Adjust("Base.308Box", "weight", "1.0")
Adjust("Base.556Box", "weight", "1.0")
Adjust("Base.Bullets44Box", "weight", "0.6")
Adjust("Base.Bullets45Box", "weight", "0.5")

-- Magazine Weights --
Adjust("Base.9mmClip", "weight", "0.1")
Adjust("Base.45Clip", "weight", "0.1")
Adjust("Base.44Clip", "weight", "0.1")
Adjust("Base.308Clip", "weight", "0.1")
