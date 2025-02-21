
	local api = uevr.api
	
	--local params = uevr.params
	local callbacks = uevr.params.sdk.callbacks
	local pawn = api:get_local_pawn(0)
	local hmd_Pos =UEVR_Vector3f.new()
	local hmd_Rot =UEVR_Quaternionf.new()
	local PosZOld=0
	local PosYOld=0
	local PosXOld=0
	local tickskip=0
	local PosDiff = 0
function isButtonPressed(state, button)
	return state.Gamepad.wButtons & button ~= 0
end
function isButtonNotPressed(state, button)
	return state.Gamepad.wButtons & button == 0
end
function pressButton(state, button)
	state.Gamepad.wButtons = state.Gamepad.wButtons | button
end
function unpressButton(state, button)
	state.Gamepad.wButtons = state.Gamepad.wButtons & ~(button)
end
uevr.sdk.callbacks.on_pre_engine_tick(
function(engine, delta)
if tickskip==0 then
	tickskip=tickskip+1
elseif tickskip ==1 then
	
	pawn = api:get_local_pawn(0)

	--local rHandIndex = uevr.params.vr.get_right_controller_index()
	uevr.params.vr.get_pose(2, hmd_Pos, hmd_Rot)
	local PosXNew=hmd_Pos.x
	local PosYNew=hmd_Pos.y
	local PosZNew=hmd_Pos.z
	
	PosDiff = math.sqrt((PosXNew-PosXOld)^2+(PosYNew-PosYOld)^3+(PosZNew-PosZOld)^2)*10000
	PosZOld=PosZNew
	PosYOld=PosYNew
	PosXOld=PosXNew
	--print(PosDiff)


	tickskip=0
end
end)

local Prep=false

uevr.sdk.callbacks.on_xinput_get_state(
function(retval, user_index, state)

local TriggerR = state.Gamepad.bRightTrigger
if PosDiff >= 1000 and Prep == false then
	Prep=true
elseif PosDiff <=10 and Prep ==true then
	pawn:Melee()
	Prep=false
end
	

--Read Gamepad stick input for rotation compensation
	
	
 
	--testrotato.Y= CurrentPressAngle


		--RotationOffset
	--ConvertedAngle= kismet_math_library:Quat_MakeFromEuler(testrotato)
	--print("x: " .. ConvertedAngle.X .. "     y: ".. ConvertedAngle.Y .."     z: ".. ConvertedAngle.Z .. "     w: ".. ConvertedAngle.W)





end)