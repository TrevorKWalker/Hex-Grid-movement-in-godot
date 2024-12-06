extends Camera2D

var is_dragging: bool = false
var drag_start: Vector2 = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		# Right mouse button pressed
		if event.button_index == 2 and event.pressed:
			is_dragging = true
			drag_start = event.position
		# Right mouse button released
		elif event.button_index == 2 and not event.pressed:
			is_dragging = false

	elif event is InputEventMouseMotion and is_dragging:
		# Calculate the drag offset and move the camera
		var drag_offset = -event.relative
		global_position += drag_offset
