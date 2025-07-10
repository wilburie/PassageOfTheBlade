extends Node2D

var _partition : Dictionary[Vector2,Array] = {}

var _is_partition_generated : bool = false

var PARTITION_MAX_SIZE = 128


func _draw() -> void:
	
	if not _is_partition_generated:
		for x in get_viewport_rect().size.x / PARTITION_MAX_SIZE:
			for y in get_viewport_rect().size.x / PARTITION_MAX_SIZE:
				_partition.get_or_add(Vector2(x,y) * PARTITION_MAX_SIZE,[])
		_is_partition_generated = true
	
	for _position in _partition.keys():
		var rect := Rect2(_position + Vector2.ONE, Vector2.ONE * PARTITION_MAX_SIZE - Vector2.ONE)
		
		if (_partition.get(_position) as Array).is_empty():
			draw_rect(rect,Color.RED,false,1)
		else:
			draw_rect(rect,Color.GREEN,false,1)

func _ready() -> void:
	
	
	
	await recursive_partition(get_tree().root)
	
	queue_redraw()

func recursive_partition(from_node:Node):
	if from_node is Node2D:
		(_partition.get_or_add(from_node.position.snappedf(PARTITION_MAX_SIZE),[]) as Array).append(from_node)
	
	for child in from_node.get_children():
		recursive_partition(child)
