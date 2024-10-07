extends CharacterBody2D

enum Ability {
	move,
	jump,
	double_jump,
	dash,
	roll,
	terrain_mod,
	kill_collision,
	damage_collision,
}


var current_state: Utils.States = Utils.States.idle
@onready var current_state_label: Label = $CurrentStateLabel

@export var modules: Array[Ability] = [
	Ability.move,
	Ability.jump
]


var scripts = []

func _ready() -> void:
	for module in modules:
		if module == Ability.move:
			var script = preload("res://ModularPlayer/Modules/MoveModule/move.gd")
			var script_instance = script.new()
			scripts.append(script_instance)
			script_instance.module_ready(self)
		if module == Ability.jump:
			var script = preload("res://ModularPlayer/Modules/JumpModule/jump.gd")
			var script_instance = script.new()
			scripts.append(script_instance)
			script_instance.module_ready(self)
		#if module == Ability.double_jump:
			#var script = load('res://ModularPlayer/Modules/JumpModule/jump.gd')
			#var script_instance = script.new()
			#scripts.append(script_instance)
			#script_instance.module_ready(self)
		#if module == Ability.dash:
			#var script = load('res://ModularPlayer/Modules/JumpModule/jump.gd')
			#var script_instance = script.new()
			#scripts.append(script_instance)
			#script_instance.module_ready(self)
		#if module == Ability.roll:
			#var script = load('res://ModularPlayer/Modules/JumpModule/jump.gd')
			#var script_instance = script.new()
			#scripts.append(script_instance)
			#script_instance.module_ready(self)
		#if module == Ability.terrain_mod:
			#var script = load('res://ModularPlayer/Modules/JumpModule/jump.gd')
			#var script_instance = script.new()
			#scripts.append(script_instance)
			#script_instance.module_ready(self)
		#if module == Ability.kill_collision:
			#var script = load('res://ModularPlayer/Modules/JumpModule/jump.gd')
			#var script_instance = script.new()
			#scripts.append(script_instance)
			#script_instance.module_ready(self)	
		#if module == Ability.damage_collision:
			#var script = load('res://ModularPlayer/Modules/JumpModule/jump.gd')	
			#var script_instance = script.new()
			#scripts.append(script_instance)
			#script_instance.module_ready(self)

		#var script_instance = script.new()
		#scripts.append(script_instance)
		#script_instance.module_ready(self)
	
	
func _physics_process(delta: float) -> void:
	current_state_label.text = Utils.States.keys()[current_state]
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	#print(is_on_floor())
	if current_state == Utils.States.fall or current_state == Utils.States.jump and is_on_floor():
		current_state = Utils.States.idle 
		print("heeeerre")
		

	# Use Modules
	for script in scripts:
		script.module_physics_process(self)

	move_and_slide()
