class "MMPlayers"

function MMPlayers:Write(mmResources)

	if (mmResources:IsLoaded('chat')) then
		mmResources:SetLoaded('chat', false)
		local chat = UIMessageCompData(mmResources:GetInstance('chat'))
		chat:MakeWritable()
		MessageInfo(chat.chatMessageInfo).messageQueueSize = 20
	end


	if (mmResources:IsLoaded('playerphys')) then
		mmResources:SetLoaded('playerphys', false)

		local playerPhys = CharacterPhysicsData(mmResources:GetInstance('playerphys'))
		playerPhys:MakeWritable()
		playerPhys.jumpPenaltyTime = 0
		playerPhys.jumpPenaltyFactor = 0
		dprint('Changed Player Physics...')
	end

	if (mmResources:IsLoaded('yump')) then
		mmResources:SetLoaded('yump', false)

		local playerYump = JumpStateData(mmResources:GetInstance('yump'))
		playerYump:MakeWritable()
		playerYump.jumpHeight = 6
		playerYump.jumpEffectSize = 5
		dprint('Changed Player Jump...')
	end

	if (mmResources:IsLoaded('pose_stand') and mmResources:IsLoaded('pose_standair') and
		mmResources:IsLoaded('pose_swimming') and mmResources:IsLoaded('pose_climbing') and
		mmResources:IsLoaded('pose_chute')) then

		mmResources:SetLoaded('pose_stand', false)
		mmResources:SetLoaded('pose_standair', false)
		mmResources:SetLoaded('pose_swimming', false)
		mmResources:SetLoaded('pose_climbing', false)
		mmResources:SetLoaded('pose_chute', false)

		local poseStand = CharacterStatePoseInfo(mmResources:GetInstance('pose_stand'))
		poseStand:MakeWritable()
		poseStand.velocity = 4
		poseStand.sprintMultiplier = 3
		dprint('Changed Player Stand Pose...')

		local poseStandAir = CharacterStatePoseInfo(mmResources:GetInstance('pose_standair'))
		poseStandAir:MakeWritable()
		poseStandAir.velocity = 5
		poseStandAir.sprintMultiplier = 3.5
		dprint('Changed Player Stand Air Pose...')

		local poseSwim = CharacterStatePoseInfo(mmResources:GetInstance('pose_swimming'))
		poseSwim:MakeWritable()
		poseSwim.velocity = 8
		dprint('Changed Player Swim Pose...')

		local poseClimb = CharacterStatePoseInfo(mmResources:GetInstance('pose_climbing'))
		poseClimb:MakeWritable()
		poseClimb.velocity = 15
		poseClimb.sprintMultiplier = 2
		dprint('Changed Player Climb Pose...')

		local poseClimb = CharacterStatePoseInfo(mmResources:GetInstance('pose_chute'))
		poseClimb:MakeWritable()
		poseClimb.velocity = 40
		dprint('Changed Player Parachute Pose...')
	end
end

return MMPlayers()