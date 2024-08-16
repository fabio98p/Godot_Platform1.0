class_name InteractiveArea
extends Area2D

signal is_inside_area
@onready var parent : Node = get_parent()

@export var node_of_the_interactivity : Node 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if(body is Player):
		is_inside_area.emit(true, parent)

func _on_body_exited(body: Node2D) -> void:
	if(body is Player):
		is_inside_area.emit(false, parent)
	
