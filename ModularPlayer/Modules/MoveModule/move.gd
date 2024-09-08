extends Node

const SPEED = 300.0

func module_ready(main):
	pass

func module_physics_process(main: CharacterBody2D):
	var direction := Input.get_axis("left", "right")
	if direction:
		main.velocity.x = direction * SPEED
	else:
		main.velocity.x = move_toward(main.velocity.x, 0, SPEED)



## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
