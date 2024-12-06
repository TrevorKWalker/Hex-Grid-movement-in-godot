extends Sprite2D

class_name ranger

@export var speed: float = 100.0
@export var team: Array
var target_position: Vector2
@export var moving: bool
var current_hex: HexCell
var path: Array
@export var Hexgrid : HexGrid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_position = position
	

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.distance_to(target_position) > 1.0:
		moving = true
		var direction = (target_position - position).normalized()
		position += direction * speed * delta
	else:
		moving = false
		position = target_position
		if(current_hex.position != self.position):
			current_hex = Hexgrid.find_hex_from_coords(self.position)
		
	if((path != []) and moving == false):
		target_position = path.pop_front()
		
	
		
		



func _input(event):
	pass
