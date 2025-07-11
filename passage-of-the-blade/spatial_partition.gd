extends Node2D

var _partition : Dictionary[Vector2,Array] = {
	Vector2(0,0) : [
		{
			"type" : "client player",
			"position" : Vector2(0,0),
			"velocity" : Vector2(0,0)
		}
	]
}

#var _is_partition_generated : bool = false

var PARTITION_SCALE = 64

func _draw() -> void:
	
	#if not _is_partition_generated:
		#for x in get_viewport_rect().size.x / PARTITION_MAX_SIZE:
			#for y in get_viewport_rect().size.y / PARTITION_MAX_SIZE:
				#_partition.get_or_add(Vector2(x,y) * PARTITION_MAX_SIZE,[])
		#_is_partition_generated = true
	
	for _position in _partition.keys():
		var rect := Rect2(_position + Vector2.ONE, Vector2.ONE * PARTITION_SCALE - Vector2.ONE)
		
		if (_partition.get(_position) as Array).is_empty():
			draw_rect(rect,Color.RED,false,1)
		else:
			draw_rect(rect,Color.GREEN,false,1)

func _ready() -> void:
	
	
	
	
	get_data_at(Vector2.ZERO,PARTITION_SCALE*2)
	
	queue_redraw()

func get_data_at(_position:Vector2,_radius:float):
	
	var data := []
	
	var rect2 := Rect2(_position-Vector2.ONE*_radius,Vector2.ONE*_radius*2)
	
	for x in rect2.size.x / PARTITION_SCALE:
		for y in rect2.size.y / PARTITION_SCALE:
			var index_position = Vector2(x,y) + (rect2.position / PARTITION_SCALE).round()
			
			data += _partition.get(index_position * PARTITION_SCALE,[])
	
	print(data)
	
	return data
