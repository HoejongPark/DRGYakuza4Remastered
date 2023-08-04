if not DrGBase then return end
ENT.Base = "drgbase_nextbot"

-- Printing --
ENT.PrintName = "Kazuma Kiryu"
ENT.Category = "Yakuza 4 Remastered"
ENT.Models = {"models/kamaroyakuza3/nextbots/kiryu.mdl"}
ENT.CollisionBounds = Vector(13, 13, 74)
ENT.ModelScale = 1

-- Stats --
ENT.SpawnHealth = 500
ENT.ShoveResistance = true
ENT.MeleeAttackRange = 32
ENT.RangeAttackRange = 56
ENT.ReachEnemyRange = 96
ENT.StrafeMin = 14
ENT.StrafeMax = 72
ENT.Factions = {FACTION_REBELS}
ENT.BloodColor = BLOOD_COLOR_RED
ENT.Omniscient = false
ENT.SpotDuration = 60
ENT.SightFOV = 90
ENT.UseWalkframes = true
ENT.IdleAnimation = "[CASUAL]_idle"
ENT.WalkAnimation = "[CASUAL]_walk"
ENT.RunAnimation = "[BATTLE]_run"
ENT.DefaultRelationship = D_LK
ENT.ClimbLedges = false
ENT.ClimbProps = false
ENT.ClimbLadders = false
ENT.RagdollOnDeath = false

-- DO NOT TOUCH --
AddCSLuaFile()
DrGBase.AddNextbot(ENT)