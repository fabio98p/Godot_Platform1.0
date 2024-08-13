class_name Killzone
extends Area2D

#@onready var level_controller: Node = %LevelController

signal player_entered_killzone


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	player_entered_killzone.emit()
	#level_controller.player_died()
	print("you died")
