--[[ **THIEVENFALL RANDOM BUILD GENERATOR**
  Generates random builds for my Thievenfall overhaul for PAYDAY 2.
  Created because I was bored and thought it'd be funny to try playing
  with completely randomised builds. Some logic was added to prevent
  builds from generating in ways that make no sense, and enforce
  specific deployables/consumables if needed.
]]

local SkillPoints = 21 -- Set this based on current level/infamy.

----------------------

local Skills = {}
 
Skills.Tier4 = { -- Setup available skills
  { tree = "Mastermind/Medic", skill = "Uppers", levels = 1, req = "First Aid Kit" }, { tree = "Mastermind/Medic", skill = "Inspire", levels = 2 }, { tree = "Mastermind/Medic", skill = "Amphetamine", levels = 2, req = "First Aid Kit" },
  { tree = "Mastermind/Marksman", skill = "Helmet Popping", levels = 1 }, { tree = "Mastermind/Marksman", skill = "Coup de Grace", levels = 1 }, { tree = "Mastermind/Marksman", skill = "Graze", levels = 2 },
  { tree = "Mastermind/Controller", skill = "Kevlar", levels = 2, req = "Joker" }, { tree = "Mastermind/Controller", skill = "Partners in Crime", levels = 2, req = "Joker" }, { tree = "Mastermind/Controller", skill = "Punisher", levels = 2, req = "Joker" },
  { tree = "Enforcer/Ammo Specialist", skill = "Fully Loaded", levels = 2 }, { tree = "Enforcer/Ammo Specialist", skill = "Mag Throw", levels = 1 }, { tree = "Enforcer/Ammo Specialist", skill = "Scrounger", levels = 2 },
  { tree = "Enforcer/Mercenary", skill = "Body Expertise", levels = 2 }, { tree = "Enforcer/Mercenary", skill = "OVERKILL", levels = 1 },
  { tree = "Enforcer/Muscle", skill = "Herd Mentality", levels = 1 }, { tree = "Enforcer/Muscle", skill = "Insanity", levels = 3 },
  { tree = "Technician/Engineer", skill = "Jack of all Trades", levels = 1 }, { tree = "Technician/Engineer", skill = "Plating", levels = 1, req = "Sentry Gun" },
  { tree = "Technician/Gunsmith", skill = "Illegal Parts", levels = 2 }, { tree = "Technician/Gunsmith", skill = "Mag Plus", levels = 2 },
  { tree = "Technician/Breacher", skill = "Repair System", levels = 2 }, { tree = "Technician/Breacher", skill = "Sensor Mines", levels = 1, req = "Trip Mine" },
  { tree = "Ghost/Infiltrator", skill = "Cyber Warfare", levels = 2, req = "Feedback" },
  { tree = "Ghost/Hitman", skill = "Hypocritical", levels = 2 }, { tree = "Ghost/Hitman", skill = "Chamber Vent", levels = 2 },
  { tree = "Ghost/Agent", skill = "Rise Above", levels = 3 }, { tree = "Ghost/Agent", skill = "Sprint Loaded", levels = 1 },
  { tree = "Convict/Substance Abuser", skill = "Calm", levels = 1, req = "Virtue" }, { tree = "Convict/Substance Abuser", skill = "Synergy", levels = 1, req = "Gas Dispenser" }, { tree = "Convict/Substance Abuser", skill = "Play Rough", levels = 2, req = "Injector" }, { tree = "Convict/Substance Abuser", skill = "Momentum", levels = 1, req = "Leech" },
  { tree = "Convict/Brawler", skill = "Bloodthirst", levels = 1 }, { tree = "Convict/Brawler", skill = "Frenzy", levels = 2 }, { tree = "Convict/Brawler", skill = "Gunserker", levels = 1 },
  { tree = "Convict/Revenant", skill = "Vengeful Swan", levels = 1, req = "Swan Song" }, { tree = "Convict/Revenant", skill = "Feign Death", levels = 2 }
}

Skills.Tier3 = {
  { tree = "Mastermind/Medic", skill = "Combat Medic", levels = 2 }, { tree = "Mastermind/Medic", skill = "Code Blue", levels = 1 }, { tree = "Mastermind/Medic", skill = "Field Surgeon", levels = 2, req = "Doctor Bag" },
  { tree = "Mastermind/Marksman", skill = "Trigger Happy", levels = 2 }, { tree = "Mastermind/Marksman", skill = "Aggressive Reload", levels = 1 }, { tree = "Mastermind/Marksman", skill = "Long Shot", levels = 1 },
  { tree = "Mastermind/Controller", skill = "Stockholm Syndrome", levels = 1 }, { tree = "Mastermind/Controller", skill = "Joker", levels = 2 }, { tree = "Mastermind/Controller", skill = "Dominator", levels = 2 },
  { tree = "Enforcer/Ammo Specialist", skill = "Deep Pockets", levels = 2, req = "Ammo Bag" }, { tree = "Enforcer/Ammo Specialist", skill = "Bulletstorm", levels = 2, req = "Ammo Bag" },
  { tree = "Enforcer/Mercenary", skill = "Lock n' Load", levels = 1 }, { tree = "Enforcer/Mercenary", skill = "Far Away", levels = 1 }, { tree = "Enforcer/Mercenary", skill = "Disturbing the Peace", levels = 2 }, { tree = "Enforcer/Mercenary", skill = "Feeling Lucky", levels = 2 },
  { tree = "Enforcer/Muscle", skill = "Shock And Awe", levels = 1 }, { tree = "Enforcer/Muscle", skill = "Nerves of Steel", levels = 1 },
  { tree = "Technician/Engineer", skill = "Armor Penetration", levels = 1, req = "Sentry Gun" }, { tree = "Technician/Engineer", skill = "Tower Defense", levels = 2, req = "Sentry Gun" },
  { tree = "Technician/Gunsmith", skill = "Magazine Funnel", levels = 3 }, { tree = "Technician/Gunsmith", skill = "Black Tip", levels = 2 },
  { tree = "Technician/Breacher", skill = "Kickstarter", levels = 1 }, { tree = "Technician/Breacher", skill = "Fire Trap", levels = 2, req = "Trip Mine" }, { tree = "Technician/Breacher", skill = "McCalister", levels = 2, req = "Trip Mine" },
  { tree = "Ghost/Infiltrator", skill = "Dexterity", levels = 1 }, { tree = "Ghost/Infiltrator", skill = "Feedback", levels = 2, req = "ECM" },
  { tree = "Ghost/Hitman", skill = "Dire Need", levels = 2 }, { tree = "Ghost/Hitman", skill = "Low Blow", levels = 2 }, { tree = "Ghost/Hitman", skill = "Pocket Silencer", levels = 1 },
  { tree = "Ghost/Agent", skill = "Break", levels = 3 }, { tree = "Ghost/Agent", skill = "Optical Illusions", levels = 2 }, { tree = "Ghost/Agent", skill = "Second Wind", levels = 2 },
  { tree = "Convict/Substance Abuser", skill = "Enduring", levels = 2 }, { tree = "Convict/Substance Abuser", skill = "Balls vs Bullets", levels = 1, req = "Injector" }, { tree = "Convict/Substance Abuser", skill = "Symbiosis", levels = 1, req = "Leech" },
  { tree = "Convict/Brawler", skill = "Vicious Warrior", levels = 3 }, { tree = "Convict/Brawler", skill = "Counter Strike", levels = 1 }, { tree = "Convict/Brawler", skill = "Life Drain", levels = 2 }, { tree = "Convict/Brawler", skill = "Berserker", levels = 1 },
  { tree = "Convict/Revenant", skill = "Swan Song", levels = 2 }, { tree = "Convict/Revenant", skill = "Messiah", levels = 2 }
}

Skills.Tier2 = {
  { tree = "Mastermind/Medic", skill = "Walking Pharmacy", levels = 2, req = "First Aid Kit" }, { tree = "Mastermind/Medic", skill = "Painkillers", levels = 2 }, { tree = "Mastermind/Medic", skill = "Blood Bank", levels = 2, req = "Doctor Bag" },
  { tree = "Mastermind/Marksman", skill = "Target Acquisition", levels = 2 }, { tree = "Mastermind/Marksman", skill = "Ammo Efficiency", levels = 1 },
  { tree = "Mastermind/Controller", skill = "Helsinki Syndrome", levels = 2 }, { tree = "Mastermind/Controller", skill = "Crowd Control", levels = 2 }, { tree = "Mastermind/Controller", skill = "Master Trader", levels = 1 },
  { tree = "Enforcer/Ammo Specialist", skill = "Stockpile", levels = 2, req = "Ammo Bag" }, { tree = "Enforcer/Ammo Specialist", skill = "Medical Supplies", levels = 3 }, { tree = "Enforcer/Ammo Specialist", skill = "Carbon Blade", levels = 3, req = "Portable Saw" },
  { tree = "Enforcer/Mercenary", skill = "Fast and Furious", levels = 2 }, { tree = "Enforcer/Mercenary", skill = "Fire Control", levels = 1 }, { tree = "Enforcer/Mercenary", skill = "Skeet Shooting", levels = 1 }, { tree = "Enforcer/Mercenary", skill = "Loud and Proud", levels = 2 },
  { tree = "Enforcer/Muscle", skill = "Beast of Burden", levels = 2 }, { tree = "Enforcer/Muscle", skill = "Iron Man", levels = 1 },
  { tree = "Technician/Engineer", skill = "Ammo Reserve", levels = 2, req = "Sentry Gun" }, { tree = "Technician/Engineer", skill = "Eco Sentry", levels = 1, req = "Sentry Gun" },
  { tree = "Technician/Gunsmith", skill = "Barrel Alignment", levels = 2 }, { tree = "Technician/Gunsmith", skill = "Tinkerer", levels = 3 }, 
  { tree = "Technician/Breacher", skill = "Drill Sawgeant", levels = 2 }, { tree = "Technician/Breacher", skill = "Fragmentation", levels = 2, req = "Trip Mine" }, { tree = "Technician/Breacher", skill = "Shaped Charge", levels = 3, req = "Trip Mine" },
  { tree = "Ghost/Infiltrator", skill = "Sixth Sense", levels = 2 },
  { tree = "Ghost/Hitman", skill = "Tactical Reload", levels = 2 }, { tree = "Ghost/Hitman", skill = "Ambidexterity", levels = 3 }, { tree = "Ghost/Hitman", skill = "The Professional", levels = 2 },
  { tree = "Ghost/Agent", skill = "Composure", levels = 3 }, { tree = "Ghost/Agent", skill = "Duck and Cover", levels = 2 }, { tree = "Ghost/Agent", skill = "Shockproof", levels = 3 }, { tree = "Ghost/Agent", skill = "Sneaky Bastard", levels = 2 },
  { tree = "Convict/Substance Abuser", skill = "Virtue", levels = 2 }, { tree = "Convict/Substance Abuser", skill = "Public Enemy No. 1", levels = 1, req = "Injector" }, { tree = "Convict/Substance Abuser", skill = "Indomitable", levels = 1, req = "Leech" },
  { tree = "Convict/Brawler", skill = "Adrenaline", levels = 2 }, { tree = "Convict/Brawler", skill = "Psychopath", levels = 2 }, { tree = "Convict/Brawler", skill = "Mag Steal", levels = 1 },
  { tree = "Convict/Revenant", skill = "More Blood To Bleed", levels = 3 }, { tree = "Convict/Revenant", skill = "Running From Death", levels = 1 }
}

Skills.Tier1 = {
  { tree = "Mastermind/Medic", skill = "Triage", levels = 1, req = "First Aid Kit" }, { tree = "Mastermind/Medic", skill = "Transfusion", levels = 2 }, { tree = "Mastermind/Medic", skill = "Quick Fix", levels = 1, req = "Doctor Bag" },
  { tree = "Mastermind/Marksman", skill = "Stable Shot", levels = 1 },
  { tree = "Mastermind/Controller", skill = "Cable Guy", levels = 2 }, { tree = "Mastermind/Controller", skill = "Warning Shot", levels = 1 }, { tree = "Mastermind/Controller", skill = "Deep Throat", levels = 2 },
  { tree = "Enforcer/Ammo Specialist", skill = "Scavenger", levels = 1 }, { tree = "Enforcer/Ammo Specialist", skill = "Big Game Hunter", levels = 1 }, { tree = "Enforcer/Ammo Specialist", skill = "Double Dip", levels = 1 }, { tree = "Enforcer/Ammo Specialist", skill = "Portable Saw", levels = 2 },
  { tree = "Enforcer/Mercenary", skill = "Heavy Impact", levels = 2 }, { tree = "Enforcer/Mercenary", skill = "Mobile", levels = 1 }, { tree = "Enforcer/Mercenary", skill = "Oppressor", levels = 3 }, { tree = "Enforcer/Mercenary", skill = "Last Stand", levels = 2 },
  { tree = "Enforcer/Muscle", skill = "Catapult", levels = 1 }, { tree = "Enforcer/Muscle", skill = "Bulletproof", levels = 4 }, { tree = "Enforcer/Muscle", skill = "Stun Resistance", levels = 2 },
  { tree = "Technician/Engineer", skill = "Servo Grease", levels = 1, req = "Sentry Gun" }, { tree = "Technician/Engineer", skill = "Precision Engineering", levels = 1, req = "Sentry Gun" },
  { tree = "Technician/Gunsmith", skill = "Heat Shield", levels = 2 },
  { tree = "Technician/Breacher", skill = "Toolkit", levels = 1 }, { tree = "Technician/Breacher", skill = "Silent Drilling", levels = 2 }, { tree = "Technician/Breacher", skill = "Demolition Man", levels = 2, req = "Trip Mine" },
  { tree = "Ghost/Infiltrator", skill = "Lithium-Ion", levels = 2, req = "Feedback" },
  { tree = "Ghost/Hitman", skill = "Quick Draw", levels = 3 }, { tree = "Ghost/Hitman", skill = "Hidden Vest", levels = 1 }, { tree = "Ghost/Hitman", skill = "Hidden Blade", levels = 1 }, { tree = "Ghost/Hitman", skill = "High Value Target", levels = 2 },
  { tree = "Ghost/Agent", skill = "Evasive", levels = 4 }, { tree = "Ghost/Agent", skill = "Moving Target", levels = 2 }, { tree = "Ghost/Agent", skill = "Thrill Seeker", levels = 2 }, { tree = "Ghost/Agent", skill = "Endurance", levels = 3 },
  { tree = "Convict/Substance Abuser", skill = "Harmony", levels = 1, req = "Gas Dispenser" }, { tree = "Convict/Substance Abuser", skill = "Right To The Top", levels = 1, req = "Injector" }, { tree = "Convict/Substance Abuser", skill = "Stalwart", levels = 1, req = "Leech" },
  { tree = "Convict/Brawler", skill = "Pumping Iron", levels = 2 }, { tree = "Convict/Brawler", skill = "Tooth and Claw", levels = 4 }, { tree = "Convict/Brawler", skill = "Because of Training", levels = 2 },
  { tree = "Convict/Revenant", skill = "Brute Strength", levels = 4 }, { tree = "Convict/Revenant", skill = "Revive Swap Speed", levels = 2 }
}

local Consumables = { "Gas Dispenser", "Injector", "Leech" }
local Deployables = { "First Aid Kit", "Doctor Bag", "Ammo Bag", "Sentry Gun", "ECM", "Trip Mine" }

-- Generate builds
local ChosenSkills = {}
if math.random() < 0.2 then -- 20% chance for a consumable to be chosen
  local ConsumableIndex = math.random(#Consumables)
  ChosenSkills[Consumables[ConsumableIndex]] = 1
  print("Consumable: " .. Consumables[ConsumableIndex])
end

do
  local DeployableIndex = math.random(#Deployables)
  ChosenSkills[Deployables[DeployableIndex]] = 1
  if Deployables[DeployableIndex] ~= "ECM" then print("Deployable: " .. Deployables[DeployableIndex])
  else print("Deployable: Any") end

  table.remove(Deployables, DeployableIndex)
end

while SkillPoints > 0 do
  -- Choose random skill
  local RandomTier = math.min(SkillPoints, math.random(1, 4))
  local SkillTier = "Tier" .. RandomTier
  local SkillIndex = Skills[SkillTier][math.random(#Skills[SkillTier])]
  while ChosenSkills[SkillIndex.skill] or (SkillIndex.req and not ChosenSkills[SkillIndex.req]) do SkillIndex = Skills[SkillTier][math.random(#Skills[SkillTier])] end

  -- Choose skill level
  local SkillLevel = math.random(SkillIndex.levels)
  if SkillLevel * RandomTier > SkillPoints then SkillLevel = math.floor(SkillPoints / RandomTier) end

  ChosenSkills[SkillIndex.skill] = SkillLevel

  -- Finalise
  print(SkillIndex.skill .. " level " .. SkillLevel .. " (" .. SkillIndex.tree .. " tree, tier " .. RandomTier .. ")")
  if SkillIndex.skill == "Jack of all Trades" then
    local DeployableIndex = math.random(#Deployables)
    ChosenSkills[Deployables[DeployableIndex]] = 1
    if Deployables[DeployableIndex] ~= "ECM" then print("Second Deployable: " .. Deployables[DeployableIndex])
    else print("Second Deployable: Any") end
  end

  SkillPoints = SkillPoints - (SkillLevel * RandomTier)
end
