extends Sprite2D

class_name HexCell

var size: float
var cube_coords: Vector3
var parent: Node2D
var hex_sprite: Sprite2D
var occupied: bool
var pixel_coords: Vector2
var walkable:bool
var movement_cost: int

func _init(size: float, texture: Texture2D, cube_coords: Vector3, movement_cost:int, parent: Node2D):
	hex_sprite = Sprite2D.new()
	self.size = size
	self.texture = texture
	self.cube_coords = cube_coords
	self.parent = parent
	self.occupied = false
	self.walkable = true
	self.movement_cost = movement_cost
	var pixel_coords = cube_to_pixel(cube_coords)

	self.position = pixel_coords
	parent.add_child(self)

func cube_to_pixel(cube: Vector3) -> Vector2:
	var x = self.size * 1.5 * cube.x
	var y = self.size * (sqrt(3) / 2 * cube.x + sqrt(3) * cube.y)
	return Vector2(x, y)


func pixel_to_cube(position: Vector2) -> Vector3:
	var q = (sqrt(3) / 3 * position.y - 1 / 3 * position.x) / self.size
	var r = (2 / 3 * position.x) / self.size
	var cube = Vector3(q, r, -q - r)
	return round_cube(cube)


func round_cube(cube: Vector3) -> Vector3:
	var rx = round(cube.x)
	var ry = round(cube.y)
	var rz = round(cube.z)

	var x_diff = abs(rx - cube.x)
	var y_diff = abs(ry - cube.y)
	var z_diff = abs(rz - cube.z)

	if x_diff > y_diff and x_diff > z_diff:
		rx = -ry - rz
	elif y_diff > z_diff:
		ry = -rx - rz
	else:
		rz = -rx - ry
	return Vector3(rx, ry, rz)





	
