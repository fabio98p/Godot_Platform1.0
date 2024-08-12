extends Node

@onready var player: CharacterBody2D = %Player

var current_interact_object: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_is_dead():
		restart_game()

func player_take_amage(damage: int):
	player.get_damage(damage)

func player_died():
	player.die()
	
func player_is_dead():
	if player.current_health > 0:
		return false
	return true

func restart_game():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")

func enable_interactive_area(is_interactive, element):
	
	if is_interactive:
		current_interact_object = element
		print("isInteractive")
		Interact()
	else:
		print("no more interactive")

func Interact():
	current_interact_object.start_interaction()
