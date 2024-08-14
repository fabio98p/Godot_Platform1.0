extends Node


@onready var player: CharacterBody2D = %Player

var current_interact_object: Node


func _ready() -> void:	
	#connect to the player signal
	for node in Utils.get_all_nodes():
		if node is Player:
			print("connecting to player in level_controller")
			node.connect("player_is_dead", Callable(self, "_on_player_is_dead"))

func player_take_amage(damage: int):
	player.get_damage(damage)
	
func _on_player_is_dead():
	print("onplayerisdead")
	restart_game()

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
