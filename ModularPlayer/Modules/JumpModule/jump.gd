extends Node

const JUMP_VELOCITY = -400.0

func module_ready(main):
	pass

func module_physics_process(main: CharacterBody2D):
	if Input.is_action_just_pressed("jump") and main.is_on_floor():
		main.current_state = Utils.States.jump
		main.velocity.y = JUMP_VELOCITY
	
	if (main.current_state == Utils.States.jump and main.velocity.y >= 0):
		main.current_state = Utils.States.fall
	
#func _ready() -> void:
	#pass # Replace with function body.
#
#
#func _process(delta: float) -> void:
	#pass
