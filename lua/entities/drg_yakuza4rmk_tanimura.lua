if not DrGBase then return end
ENT.Base = "drgbase_nextbot"

-- Printing --
ENT.PrintName = "Masayoshi Tanimura"
ENT.Category = "Yakuza 4 Remastered"
ENT.Models = {"models/drgyakuza4remastered/tanimura.mdl"}
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
ENT.IdleAnimation = "[TANIMURA]_Battle_Stance"
ENT.WalkAnimation = "[TANIMURA]_Shift"
ENT.RunAnimation = "[TANIMURA]_Battle_Run"
ENT.DefaultRelationship = D_HT
ENT.ClimbLedges = false
ENT.ClimbProps = false
ENT.ClimbLadders = false
ENT.RagdollOnDeath = false

ENT.PossessionEnabled = true
ENT.PossessionCrosshair = false
ENT.PossessionMovement = POSSESSION_MOVE_CUSTOM
ENT.PossessionViews = {{offset = Vector(0, 0, 32),distance = 111,eyepos=false},{offset = Vector(7.5, 0, 0),distance = 0,eyepos = true}}
ENT.PossessionBinds = {

	[IN_ATTACK] = {{coroutine = false,onkeydown = function(self)
	if self.Cmb01 and self.Combat and not self.Heavy and not self.Downed and not self.Hurting and not self.Dodging then
	self.Cmb01 = false
	self:CICO(function()
	self.Attacking = true
	self.Damage = 14
	self.DamageType = DMG_GENERIC
	self.Range = 17
	self:PlaySequenceAndMove("[Tanimura]_Combo_1",1,function(self,cycle)if cycle < 0.5 then self:PossessionFaceForward() end end)
	self.Cmb01 = true
	self.Cmb02 = false
	self.Attacking = false
	end)
	end
	if self.Cmb02 then
	self.Cmb02 = false
	self:CICO(function()
	self.Attacking = true
	self.Damage = 16
	self.DamageType = DMG_GENERIC
	self.Range = 15
	self:PlaySequenceAndMove("[Tanimura]_Combo_2",1,function(self,cycle)if cycle < 0.5 then self:PossessionFaceForward() end end)
	self.Cmb01 = true
	self.Cmb03 = false
	self.Attacking = false
	end)
	end
	if self.Cmb03 then
	self.Cmb03 = false
	self:CICO(function()
	self.Attacking = true
	self.Damage = 17
	self.DamageType = DMG_GENERIC
	self.Range = 17
	self:PlaySequenceAndMove("[Tanimura]_Combo_3",1,function(self,cycle)if cycle < 0.5 then self:PossessionFaceForward() end end)
	self.Cmb01 = true
	self.Cmb04 = false
	self.Attacking = false
	end)
	end
	if self.Cmb04 then
	self.Cmb04 = false
	self:CICO(function()
	self.Attacking = true
	self.Damage = 18
	self.DamageType = DMG_GENERIC
	self.Range = 19
	self:PlaySequenceAndMove("[Tanimura]_Combo_4",1,function(self,cycle)if cycle < 0.5 then self:PossessionFaceForward() end end)
	self.Cmb01 = true
	self.Cmb05 = false
	self.Attacking = false
	end)
	end
end}},

	[IN_ATTACK2] = {{coroutine = false,onkeydown = function(self)
	if self.Taunting and self.Attacking then return end
	if self.Combat and not self.Attacking and self:GetCooldown("HeavyCooldown")<=0 and not self.Downed and not self.Hurting and not self.Dodging and self:PossessionGetLockedOn().Downed then
		self:CICO(function()
		self.Heavy = true
		self:SetCooldown("HeavyCooldown",(0.8))
		self.Damage = 10
		self.DamageType = DMG_VEHICLE
		self.Range = 35
		self:PlaySequenceAndMove("[Tanimura]_Down_Attack",1.25)
		self.Heavy = false
		end)
	elseif self.Combat and not self.Attacking and self:GetCooldown("HeavyCooldown")<=0 and not self.Downed and not self.Hurting and not self.Dodging then
		self:CICO(function()
		self.Heavy = true
		self:SetCooldown("HeavyCooldown",(0.875))
		self.Damage = 10
		self.DamageType = DMG_CRUSH
		self.Range = 17
		self:PlaySequenceAndMove("[TANIMURA]_Heavy_Attack",1)
		self.Heavy = false
		end)
	end
	end}},

	[IN_RELOAD] = {{coroutine = false,onkeydown = function(self)
	if self.Attacking then return end
	if not self.Combat and not self.Attacking and self:GetCooldown("StartCooldown")<=0 then
		self.Combat = true
		end
	end}}

}

ENT.SetupType = bit.bor(DMG_GENERIC)
function ENT:HandleAnimEvent(a,b,c,d,e)
	if e == "fall_sound" then
		self:EmitSound("DrgYakuza4Remastered/common/down"..math.random(4)..".wav")
	end
	if e == "sway_sound" then
		self:EmitSound("DrgYakuza4Remastered/common/sway"..math.random(3)..".wav")
	end
	if e == "hit" then
		self:Attack({
			damage = self.Damage,
			type = self.DamageType,
			range = self.Range,
			viewpunch = Angle(20, math.random(-25, 25), 0),
		}, 
		function(self, hit)
			if #hit > 0 then 
				self:EmitSound("yakuza0/weapons/fists/hit"..math.random(4)..".wav")
			else
				self:EmitSound("yakuzakiwami/weapons/fists/swing"..math.random(4)..".wav")
			end
		end)
	end
		if e == "Cmb1Trans" then
		if self:IsPossessed() then
		self.Cmb02 = true
		end
	end
	if e == "Cmb2Trans" then
		if self:IsPossessed() then
		self.Cmb03 = true
		end
	end
	if e == "Cmb3Trans" then
		if self:IsPossessed() then
		self.Cmb04 = true
		end
	end
end


function ENT:OnOtherKilled()
	self:CICO(function()
		self:GetPossessor():ScreenFade( SCREENFADE.IN, Color( 5, 105, 255, 5 ), 0.25, 0.25, SCREENFADE.OUT, Color( 5, 105, 255, 5 ), 0.125, 0.125 )
		self:EmitSound("DrgYakuza4Remastered/common/battle_end.wav",0.5)
	end)
end

function ENT:OnTakeDamage(dmg)
	if self:IsDead() and self.Downed then return end
	if not dmg:IsDamageType(DMG_SHOCK) and not dmg:IsDamageType(DMG_BLAST) and not self.Dodging then
		local fwd = self:GetPos()+self:GetForward()*1
			local bck = self:GetPos()-self:GetForward()*1
			local lft = self:GetPos()-self:GetRight()*1
			local rit = self:GetPos()+self:GetRight()*1
			local pos = dmg:GetDamagePosition()
			local dmer = dmg:GetInflictor()
		if fwd:DistToSqr(pos) < bck:DistToSqr(pos) 
		and fwd:DistToSqr(pos) < lft:DistToSqr(pos) 
		and fwd:DistToSqr(pos) < rit:DistToSqr(pos) then
			self:CICO(function(self)
				self.Hurting = true
				self:PlaySequenceAndMove("[DMG]_light_F",1)
				self.Hurting = false
			end)
		elseif bck:DistToSqr(pos) < fwd:DistToSqr(pos) 
		and bck:DistToSqr(pos) < lft:DistToSqr(pos) 
		and bck:DistToSqr(pos) < rit:DistToSqr(pos) then
			self:CICO(function(self)
				self.Hurting = true
				self:PlaySequenceAndMove("[DMG]_light_b",1)
				self.Hurting = false
			end)
		end
	end
	if self:IsDead() then return end
	if dmg:IsDamageType(DMG_SHOCK) then
		self:CICO(function()
		self.Hurting = true
		self:PlaySequenceAndMove("[DMG]_Electricity",1)
		self:PlaySequenceAndMove("[DMG]_standup_b_st",1)
		self:PlaySequenceAndMove("[DMG]_standup_end",1)
		self.Hurting = false
		end)
	end
	if self:IsDead() then return end
	if dmg:IsDamageType(DMG_BLAST) and not self.Downed and not self.Dodging then
		local fwd = self:GetPos()+self:GetForward()*1
			local bck = self:GetPos()-self:GetForward()*1
			local lft = self:GetPos()-self:GetRight()*1
			local rit = self:GetPos()+self:GetRight()*1
			local pos = dmg:GetDamagePosition()
			local dmer = dmg:GetInflictor()
		if fwd:DistToSqr(pos) < bck:DistToSqr(pos) 
		and fwd:DistToSqr(pos) < lft:DistToSqr(pos) 
		and fwd:DistToSqr(pos) < rit:DistToSqr(pos) then
			self:CICO(function(self)
				self.Downed = true
				self:PlaySequenceAndMove("[DMG]_Heavy_F_st",1)
				self:PlaySequenceAndMove("[DMG]_Heavy_f_en",1)
				self:PlaySequenceAndMove("[DMG]_standup_f_st",1)
				self:PlaySequenceAndMove("[DMG]_standup_end",1)
				self.Downed = false
			end)
		elseif bck:DistToSqr(pos) < fwd:DistToSqr(pos) 
		and bck:DistToSqr(pos) < lft:DistToSqr(pos) 
		and bck:DistToSqr(pos) < rit:DistToSqr(pos) then
			self:CICO(function(self)
				self.Downed = true
				self:PlaySequenceAndMove("[DMG]_Heavy_B_st",1)
				self:PlaySequenceAndMove("[DMG]_Heavy_B_en",1)
				self:PlaySequenceAndMove("[DMG]_standup_b_st",1)
				self:PlaySequenceAndMove("[DMG]_standup_end",1)
				self.Downed = false
			end)
		elseif lft:DistToSqr(pos) < rit:DistToSqr(pos) 
		and lft:DistToSqr(pos) < fwd:DistToSqr(pos) 
		and lft:DistToSqr(pos) < bck:DistToSqr(pos) then
			self:CICO(function(self)
				self.Downed = true
				self:PlaySequenceAndMove("[DMG]_Heavy_l_st",1)
				self:PlaySequenceAndMove("[DMG]_Heavy_l_en",1)
				self:PlaySequenceAndMove("[DMG]_standup_b_st",1)
				self:PlaySequenceAndMove("[DMG]_standup_end",1)
				self.Downed = false
			end)
		elseif rit:DistToSqr(pos) < lft:DistToSqr(pos) 
		and rit:DistToSqr(pos) < bck:DistToSqr(pos) 
		and rit:DistToSqr(pos) < fwd:DistToSqr(pos) then
			self:CICO(function(self)
				self.Downed = true
				self:PlaySequenceAndMove("[DMG]_Heavy_r_st",1)
				self:PlaySequenceAndMove("[DMG]_Heavy_r_en",1)
				self:PlaySequenceAndMove("[DMG]_standup_f_st",1)
				self:PlaySequenceAndMove("[DMG]_standup_end",1)
				self.Downed = false
			end)
		end
if self:IsDead() then return end
	if dmg:IsDamageType(DMG_VEHICLE) and not self.Downed and not self.Dodging then
		local fwd = self:GetPos()+self:GetForward()*1
			local bck = self:GetPos()-self:GetForward()*1
			local lft = self:GetPos()-self:GetRight()*1
			local rit = self:GetPos()+self:GetRight()*1
			local pos = dmg:GetDamagePosition()
			local dmer = dmg:GetInflictor()
		if fwd:DistToSqr(pos) < bck:DistToSqr(pos) 
		and fwd:DistToSqr(pos) < lft:DistToSqr(pos) 
		and fwd:DistToSqr(pos) < rit:DistToSqr(pos) then
			self:CICO(function(self)
				self.Downed = true
				self:PlaySequenceAndMove("[DMG]_Heavy_F_st",1)
				self:PlaySequenceAndMove("[DMG]_Heavy_f_en",1)
				self:PlaySequenceAndMove("[DMG]_standup_f_st",1)
				self:PlaySequenceAndMove("[DMG]_standup_end",1)
				self.Downed = false
			end)
		elseif bck:DistToSqr(pos) < fwd:DistToSqr(pos) 
		and bck:DistToSqr(pos) < lft:DistToSqr(pos) 
		and bck:DistToSqr(pos) < rit:DistToSqr(pos) then
			self:CICO(function(self)
				self.Downed = true
				self:PlaySequenceAndMove("[DMG]_Heavy_B_st",1)
				self:PlaySequenceAndMove("[DMG]_Heavy_B_en",1)
				self:PlaySequenceAndMove("[DMG]_standup_b_st",1)
				self:PlaySequenceAndMove("[DMG]_standup_end",1)
				self.Downed = false
			end)
		elseif lft:DistToSqr(pos) < rit:DistToSqr(pos) 
		and lft:DistToSqr(pos) < fwd:DistToSqr(pos) 
		and lft:DistToSqr(pos) < bck:DistToSqr(pos) then
			self:CICO(function(self)
				self.Downed = true
				self:PlaySequenceAndMove("[DMG]_Heavy_l_st",1)
				self:PlaySequenceAndMove("[DMG]_Heavy_l_en",1)
				self:PlaySequenceAndMove("[DMG]_standup_b_st",1)
				self:PlaySequenceAndMove("[DMG]_standup_end",1)
				self.Downed = false
			end)
		elseif rit:DistToSqr(pos) < lft:DistToSqr(pos) 
		and rit:DistToSqr(pos) < bck:DistToSqr(pos) 
		and rit:DistToSqr(pos) < fwd:DistToSqr(pos) then
			self:CICO(function(self)
				self.Downed = true
				self:PlaySequenceAndMove("[DMG]_Heavy_r_st",1)
				self:PlaySequenceAndMove("[DMG]_Heavy_r_en",1)
				self:PlaySequenceAndMove("[DMG]_standup_f_st",1)
				self:PlaySequenceAndMove("[DMG]_standup_end",1)
				self.Downed = false
			end)
		end
	if self:IsDead() then return end
	if dmg:IsDamageType(DMG_BLAST) and not self.Downed and not self.Dodging then
		local fwd = self:GetPos()+self:GetForward()*1
			local bck = self:GetPos()-self:GetForward()*1
			local lft = self:GetPos()-self:GetRight()*1
			local rit = self:GetPos()+self:GetRight()*1
			local pos = dmg:GetDamagePosition()
			local dmer = dmg:GetInflictor()
		if fwd:DistToSqr(pos) < bck:DistToSqr(pos) 
		and fwd:DistToSqr(pos) < lft:DistToSqr(pos) 
		and fwd:DistToSqr(pos) < rit:DistToSqr(pos) then
			self:CICO(function(self)
				self.Downed = true
				self:PlaySequenceAndMove("[DMG]_Heavy_F_st",1)
				self:PlaySequenceAndMove("[DMG]_Heavy_f_en",1)
				self:PlaySequenceAndMove("[DMG]_standup_f_st",1)
				self:PlaySequenceAndMove("[DMG]_standup_end",1)
				self.Downed = false
			end)
		elseif bck:DistToSqr(pos) < fwd:DistToSqr(pos) 
		and bck:DistToSqr(pos) < lft:DistToSqr(pos) 
		and bck:DistToSqr(pos) < rit:DistToSqr(pos) then
			self:CICO(function(self)
				self.Downed = true
				self:PlaySequenceAndMove("[DMG]_Heavy_B_st",1)
				self:PlaySequenceAndMove("[DMG]_Heavy_B_en",1)
				self:PlaySequenceAndMove("[DMG]_standup_b_st",1)
				self:PlaySequenceAndMove("[DMG]_standup_end",1)
				self.Downed = false
			end)
		elseif lft:DistToSqr(pos) < rit:DistToSqr(pos) 
		and lft:DistToSqr(pos) < fwd:DistToSqr(pos) 
		and lft:DistToSqr(pos) < bck:DistToSqr(pos) then
			self:CICO(function(self)
				self.Downed = true
				self:PlaySequenceAndMove("[DMG]_Heavy_l_st",1)
				self:PlaySequenceAndMove("[DMG]_Heavy_l_en",1)
				self:PlaySequenceAndMove("[DMG]_standup_b_st",1)
				self:PlaySequenceAndMove("[DMG]_standup_end",1)
				self.Downed = false
			end)
		elseif rit:DistToSqr(pos) < lft:DistToSqr(pos) 
		and rit:DistToSqr(pos) < bck:DistToSqr(pos) 
		and rit:DistToSqr(pos) < fwd:DistToSqr(pos) then
			self:CICO(function(self)
				self.Downed = true
				self:PlaySequenceAndMove("[DMG]_Heavy_r_st",1)
				self:PlaySequenceAndMove("[DMG]_Heavy_r_en",1)
				self:PlaySequenceAndMove("[DMG]_standup_f_st",1)
				self:PlaySequenceAndMove("[DMG]_standup_end",1)
				self.Downed = false
			end)
		end
if self:IsDead() then return end
	if dmg:IsDamageType(DMG_BLAST) and not self.Downed and not self.Dodging then
		local fwd = self:GetPos()+self:GetForward()*1
			local bck = self:GetPos()-self:GetForward()*1
			local lft = self:GetPos()-self:GetRight()*1
			local rit = self:GetPos()+self:GetRight()*1
			local pos = dmg:GetDamagePosition()
			local dmer = dmg:GetInflictor()
		if fwd:DistToSqr(pos) < bck:DistToSqr(pos) 
		and fwd:DistToSqr(pos) < lft:DistToSqr(pos) 
		and fwd:DistToSqr(pos) < rit:DistToSqr(pos) then
			self:CICO(function(self)
				self.Downed = true
				self:PlaySequenceAndMove("[DMG]_Heavy_F_st",1)
				self:PlaySequenceAndMove("[DMG]_Heavy_f_en",1)
				self:PlaySequenceAndMove("[DMG]_standup_f_st",1)
				self:PlaySequenceAndMove("[DMG]_standup_end",1)
				self.Downed = false
			end)
		elseif bck:DistToSqr(pos) < fwd:DistToSqr(pos) 
		and bck:DistToSqr(pos) < lft:DistToSqr(pos) 
		and bck:DistToSqr(pos) < rit:DistToSqr(pos) then
			self:CICO(function(self)
				self.Downed = true
				self:PlaySequenceAndMove("[DMG]_Heavy_B_st",1)
				self:PlaySequenceAndMove("[DMG]_Heavy_B_en",1)
				self:PlaySequenceAndMove("[DMG]_standup_b_st",1)
				self:PlaySequenceAndMove("[DMG]_standup_end",1)
				self.Downed = false
			end)
		elseif lft:DistToSqr(pos) < rit:DistToSqr(pos) 
		and lft:DistToSqr(pos) < fwd:DistToSqr(pos) 
		and lft:DistToSqr(pos) < bck:DistToSqr(pos) then
			self:CICO(function(self)
				self.Downed = true
				self:PlaySequenceAndMove("[DMG]_Heavy_l_st",1)
				self:PlaySequenceAndMove("[DMG]_Heavy_l_en",1)
				self:PlaySequenceAndMove("[DMG]_standup_b_st",1)
				self:PlaySequenceAndMove("[DMG]_standup_end",1)
				self.Downed = false
			end)
		elseif rit:DistToSqr(pos) < lft:DistToSqr(pos) 
		and rit:DistToSqr(pos) < bck:DistToSqr(pos) 
		and rit:DistToSqr(pos) < fwd:DistToSqr(pos) then
			self:CICO(function(self)
				self.Downed = true
				self:PlaySequenceAndMove("[DMG]_Heavy_r_st",1)
				self:PlaySequenceAndMove("[DMG]_Heavy_r_en",1)
				self:PlaySequenceAndMove("[DMG]_standup_f_st",1)
				self:PlaySequenceAndMove("[DMG]_standup_end",1)
				self.Downed = false
			end)
		end
		end
		end
		end
	end
end

function ENT:OnDeath()
	self:PlaySequenceAndMove("[DMG]_Death_b",1)
	self:PlaySequenceAndMove("[DMG]_gameover_b",0.5)
		if self.ThemeSongLoop then 
		self.ThemeSongLoop:Stop()
	end
end

function ENT:OnRemove()
		if self.ThemeSongLoop then 
		self.ThemeSongLoop:Stop()
	end
end

-- DO NOT TOUCH --

function ENT:CustomInitialize()
    self.Attacking = false
	self.Combat = false
	self.Cmb01 = true
	self.Heavy = false
	self.Dodging = false
end

function ENT:CICO(callback)
	local oldThread = self.BehaveThread
	self.BehaveThread = coroutine.create(function()
		callback(self)
		self.BehaveThread = oldThread
	end)
end

--	Handle this sexy little fellas UI here, if you have gripes with mine and wanna change it.

function ENT:OnUpdateAnimation()
	if self:IsDead() then return end
	if not self:IsOnGround() then return self.JumpAnimation, self.JumpAnimRate
	elseif self:IsRunning() then return self.RunAnimation, self.RunAnimRate
	elseif self:IsMoving() then return self.WalkAnimation, self.WalkAnimRate
	else return self.IdleAnimation, self.IdleAnimRate 
	end
end





if SERVER then
function ENT:PossessionControls(f,b,r,l)
	if not self:IsRunning() and self.Combat then
		if self:IsMoving() then self:PossessionFaceForward() end
		local dir = self._DrGBasePossLast4DIR or ""
        local dir = self._DrGBasePossLast4DIR or ""
        if f then self:PossessionMoveForward()
        elseif b then self:PossessionMoveBackward() end
        if r then self:PossessionMoveRight()
        elseif l then self:PossessionMoveLeft() end
	else
		local direction = self:GetPos()
		if f then direction = direction + self:PossessorForward()
		elseif b then direction = direction - self:PossessorForward() end
		if r then direction = direction + self:PossessorRight()
		elseif l then direction = direction - self:PossessorRight() end
		if direction ~= self:GetPos() then self:MoveTowards(direction)
		else self:PossessionFaceForward() end
	end
end
end

AddCSLuaFile()
DrGBase.AddNextbot(ENT)