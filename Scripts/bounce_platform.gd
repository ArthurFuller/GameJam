extends StaticBody2D

var can_destroy:bool = false

func _ready() -> void:
	await  get_tree().create_timer(0.15).timeout
	can_destroy = true

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	
	if not can_destroy:
		return
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			queue_free()
