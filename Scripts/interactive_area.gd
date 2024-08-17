class_name InteractiveArea
extends Area2D

signal is_inside_area

@onready var parent : Node = get_parent()

func _ready() -> void:
	# connect with nedeed signals
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body: Node2D) -> void:
	if(body is Player):
		is_inside_area.emit(true, parent)

func _on_body_exited(body: Node2D) -> void:
	if(body is Player):
		is_inside_area.emit(false, parent)
	
