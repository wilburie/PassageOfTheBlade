extends Node2D

var mouse_data = {
	"type" : "mouse",
	"position":Vector2.ZERO
}

func _ready() -> void:
	#SpatialPartition.add_data_at(Vector2.ZERO,mouse_data)
	
	$Timer.timeout.connect(physics_process)




func physics_process() -> void:
	
	var old_mouse_data = mouse_data.duplicate(false)
	
	mouse_data.position = get_global_mouse_position()
	
	#SpatialPartition.remove_data_at(old_mouse_data.position,mouse_data)
	
	
	SpatialPartition.move_data_at(old_mouse_data.position,mouse_data.position,mouse_data)
	
	
	#SpatialPartition.remove_data_at(old_mouse_data.position,old_mouse_data)
	
	#SpatialPartition.update_data_at(old_mouse_data.position,old_mouse_data,mouse_data)
	
	$"../Label".text = JSON.stringify(SpatialPartition._partition,"\t")
