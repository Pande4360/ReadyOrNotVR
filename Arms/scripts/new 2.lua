	local api = uevr.api
	
	local params = uevr.params
	local callbacks = params.sdk.callbacks
	local pawn = api:get_local_pawn(0)
	local vr=uevr.params.vr
	local lossy_offset=Vector3f.new(0,math.pi/2,0)

uevr.sdk.callbacks.on_pre_engine_tick(function(engine, delta)
	 pawn = api:get_local_pawn(0)
    local CurrentPitch=pawn.Mesh1P.AnimScriptInstance.AnimGraphNode_PivotBone.Rotation.Roll
	local CurrentRoll =pawn.Mesh1P.AnimScriptInstance.AnimGraphNode_PivotBone_2.Rotation.Pitch
	lossy_offset.x=-CurrentPitch*math.pi/180
	lossy_offset.z=CurrentRoll*math.pi/180
	UEVR_UObjectHook.get_or_add_motion_controller_state(pawn.Mesh1P):set_rotation_offset(lossy_offset)
	
end)