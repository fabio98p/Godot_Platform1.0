#extends State
#
#class_name IdleState
#@export var jump_velocity : float = -250.0
#@export var air_state: State
#
#func state_input(event: InputEvent):
	#if(event.is_action_pressed('jump')):
		#jump()
#
#func jump():
	#character.velocity.y = jump_velocity
	#next_state = air_state
	#playback.travel('jump_start')
