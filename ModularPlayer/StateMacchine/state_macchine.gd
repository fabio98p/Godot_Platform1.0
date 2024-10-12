extends Node

@export var initial_state: State
@onready var current_state_label: Label = $"../CurrentStateLabel"

var states: Dictionary = {}
var current_state: State 

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	
	if initial_state:
		current_state_label.text = initial_state.name.to_lower()
		
		initial_state.enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)
	
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)
	

func on_child_transition(state, new_state_name):
	if state != current_state:
		pass
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return 
	
	if current_state:
		current_state.exit()

	new_state.enter()
	current_state_label.text = new_state_name
	current_state = new_state
