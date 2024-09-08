extends CharacterBody2D



@export var modules: Array[String] = [
	"res://ModularPlayer/Modules/JumpModule/jump.gd",
	"res://ModularPlayer/Modules/MoveModule/move.gd"
]
var scripts = []

func _ready() -> void:
	for module in modules:
		var script = load(module)
		var script_instance = script.new()
		scripts.append(script_instance)
		script_instance.module_ready(self)
	
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Use Modules
	for script in scripts:
		script.module_physics_process(self)

	move_and_slide()
