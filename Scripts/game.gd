extends Node2D

@export var object_click: PackedScene

@onready var label_points = $CanvasLayer/Points

var points:int = 3

func _process(delta: float) -> void:
	label_points.text = str(points)

'''
func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			
			var space_state = get_world_2d().direct_space_state
			
			var query = PhysicsPointQueryParameters2D.new()
			query.position = get_global_mouse_position()
			query.collide_with_areas = true
			query.collide_with_bodies = true
			
			var result = space_state.intersect_point(query)
			
			if result.is_empty():
				var object = object_click.instantiate()
				object.global_position = get_global_mouse_position()
				add_child(object)
'''
