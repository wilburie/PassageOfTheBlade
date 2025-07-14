extends Node2D

signal partition_updated(partition_position:Vector2,partition_data:Array)

var _partition : Dictionary[Vector2,Array] = {
	#Vector2(0,0) : [
		#{
			#"type" : "player",
			#"id" : 0,
			#"position" : Vector2(0,0),
			#"velocity" : Vector2(0,0)
		#}
	#]
}


#var _is_partition_generated : bool = false


var PARTITION_SCALE = 64

func _draw() -> void:
	
	for _position in _partition.keys():
		var rect := Rect2(_position + Vector2.ONE, Vector2.ONE * PARTITION_SCALE - Vector2.ONE)
		
		if (_partition.get(_position) as Array).is_empty():
			_partition.erase(_position)
			draw_rect(rect,Color.RED,false,1)
		else:
			draw_rect(rect,Color.GREEN,false,1)

func _ready() -> void:
	
	partition_updated.connect(_on_partition_updated)
	
	add_data_at(Vector2.ZERO,{
		"type" : "null"
	})
	
	remove_data_at(Vector2.ZERO,{
		"type" : "null"
	})
	
	printerr(get_data_at(Vector2.ZERO))
	
	
	
	queue_redraw()


func _on_partition_updated(partition_position:Vector2,partition_data:Array):
	printerr("Redraw")
	queue_redraw()

func get_data_at(_position:Vector2):
	var data := []
	
	#var rect2 := Rect2(_position-Vector2.ONE*_radius,Vector2.ONE*_radius*2)
	#
	#for x in rect2.size.x / PARTITION_SCALE:
		#for y in rect2.size.y / PARTITION_SCALE:
			#var index_position = Vector2(x,y) + (rect2.position / PARTITION_SCALE).round()
			#
			#data += _partition.get(index_position * PARTITION_SCALE,[])
	#
	#print(data)
	#
	
	var index_position = (_position / PARTITION_SCALE).round()
	
	data = _partition.get(index_position * PARTITION_SCALE,[])
	
	return data

func add_data_at(_position:Vector2,data:Dictionary):
	var index_position = (_position / PARTITION_SCALE).round()
	
	_partition.get(index_position * PARTITION_SCALE,[]).append(data)
	
	partition_updated.emit(index_position * PARTITION_SCALE,_partition.get(index_position * PARTITION_SCALE,[]))

#func update_data_at(_position:Vector2,data:Dictionary):
	#
	#if old_data == new_data: return
	#
	#var index_position = (_position / PARTITION_SCALE).round()
	#
	#
	#if (new_data.get("position",_position) / PARTITION_SCALE).round() != index_position:
		#_partition.get_or_add(index_position * PARTITION_SCALE,[]).erase(old_data)
		#
		#partition_updated.emit(index_position * PARTITION_SCALE,_partition.get(index_position * PARTITION_SCALE,[]))
		#
		#index_position = (new_data.get("position",_position) / PARTITION_SCALE).round()
		#
		#_partition.get_or_add(index_position * PARTITION_SCALE,[]).append(new_data)
	#
	#partition_updated.emit(index_position * PARTITION_SCALE,_partition.get(index_position * PARTITION_SCALE,[]))

func remove_data_at(_position:Vector2,data:Dictionary):
	var index_position = (_position / PARTITION_SCALE).round()
	
	_partition.get(index_position * PARTITION_SCALE,[]).erase(data)
	
	partition_updated.emit(index_position * PARTITION_SCALE,_partition.get(index_position * PARTITION_SCALE,[]))

func move_data_at(_old_position:Vector2,_new_position:Vector2,data:Dictionary):
	var index_position = (_old_position / PARTITION_SCALE).round()
	_partition.get(index_position * PARTITION_SCALE,[]).erase(data)
	partition_updated.emit(index_position * PARTITION_SCALE,_partition.get(index_position * PARTITION_SCALE,[]))
	
	index_position = (_new_position / PARTITION_SCALE).round()
	_partition.get_or_add(index_position * PARTITION_SCALE,[]).append(data)
	partition_updated.emit(index_position * PARTITION_SCALE,_partition.get(index_position * PARTITION_SCALE,[]))
