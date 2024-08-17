class_name LevelController
extends Node

var current_interact_object: Node

func _ready() -> void:	
	#connect to the player signal
	for node in Utils.get_all_nodes():
		if node is Player:
			print("connecting to player in level_controller")
			node.connect("player_is_dead", Callable(self, "_on_player_is_dead"))

func _on_player_is_dead():
	print("onplayerisdead")
	restart_game()

func restart_game():
	call_deferred("_actually_restart_game")

func _actually_restart_game():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
