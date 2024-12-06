extends Node2D

@export var Monster: PackedScene = preload("res://Monster.tscn")
@export var HexGrid: PackedScene = preload("res://Hexgrid.tscn")
@export var Camera  = preload("res://Camera.gd")
var player: Node2D
var hex_grid: HexGrid
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hex_grid = HexGrid.instantiate()
	add_child(hex_grid)
	hex_grid.create_hex_grid(self,  "res://./Maps/test_map.json")
	var camera = get_viewport().get_camera_2d()
	camera.position = Vector2(0,0)
	player = Monster.instantiate()
	add_child(player)
	
	# Set the player's starting position (optional)
	var position = Vector2(hex_grid.hexes[0].cube_to_pixel(hex_grid.hexes[0].cube_coords))
	player.position = position
	player.target_position = position
	player.current_hex = hex_grid.hexes[0]
	player.Hexgrid = hex_grid


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _input(event):
	if ((event is InputEventMouseButton)):
		var camera = get_viewport().get_camera_2d()

		for hex in hex_grid.hexes:
			if((hex.position.distance_to(Vector2i(camera.position) + Vector2i(event.position) -( get_viewport().size / 2)) < (hex.size *(sqrt(3)/2))) and player.moving == false):
				var path = hex_grid.find_path(player.current_hex, hex)
				if(path != []):
					player.path= path
