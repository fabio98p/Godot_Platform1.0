extends Node

func get_all_nodes(in_node = get_tree().get_root(), array := []):
	array.push_back(in_node)
	for child in in_node.get_children():
		array = get_all_nodes(child, array)
	return array

enum States {
	idle,
	walk,
	run,
	jump,
	fall,
	attack,
	dash,
	roll,
	take_damage,
	die
}
