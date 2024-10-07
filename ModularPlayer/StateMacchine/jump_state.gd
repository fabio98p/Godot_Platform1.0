#extends State
#
#class_name JumpState
#
#@export var landing_state: State
#@export var ground_state: State
#@export var double_jump_velocity: float = -100
#
#var has_double_jumped = false
#
#func state_process(delta):
	#if character.is_on_floor():
		#next_state = ground_state
#
#func state_input(event: InputEvent):
	#if !has_double_jumped && event.is_action_pressed("jump"):
		#double_jump()
		#
#func double_jump():
	#character.velocity.y = double_jump_velocity
	#playback.travel('double_jump')
	##animated_sprite.play("jump_double")
	#has_double_jumped = true
#
#func on_exit():
	#if (next_state == ground_state):
		#playback.travel('jump_end')
		#has_double_jumped = false
		#
