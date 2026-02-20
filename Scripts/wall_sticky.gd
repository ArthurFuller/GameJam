extends StaticBody2D

'''
func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT and $StickyArea.is_stick == false:
			$StickyArea.activate()
		
		elif event.button_index == MOUSE_BUTTON_LEFT and $StickyArea.is_stick == true:
			$StickyArea.deactivate()
		
'''
func activate_sticky():
	$StickyArea.activate()

func deactivate_sticky():
	$StickyArea.deactivate()
