extends Node

const JUMP_VELOCITY = -400.0

func module_ready(main):
	pass

func module_physics_process(main: CharacterBody2D):
	if Input.is_action_just_pressed("jump") and main.is_on_floor():
		main.velocity.y = JUMP_VELOCITY
	
	
#func _ready() -> void:
	#pass # Replace with function body.
#
#
#func _process(delta: float) -> void:
	#pass
