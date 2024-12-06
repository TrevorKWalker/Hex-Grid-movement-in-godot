extends Node2D
class_name HexGrid
@export var hex_size: float = 50  # Radius of each hex in pixels
@export var hex_texture: Texture2D = preload("res://hex.png")


var hexes : Array


func _init():
	self.hex_size = hex_size
	self.hex_texture = hex_texture
	self.hexes = []
	
#Function that creates a hex grid
# Params:  "parent" : this is is the Node2D object that is the scene that the hex_grid is drawn on
#			"path"  : This is a string that points to a json file that contains the map. 
#Check Maps folder to see the expected format of Maps
#
func create_hex_grid(parent: Node2D, path: String) -> void:
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var json = JSON.new()
		var data = json.parse(file.get_as_text())
		file.close()
		if data == OK:
			var json_data = json.data
			var hexes = json_data.get("hexes", [])
			for hex_data in hexes:
				var q = hex_data.get("q", 0)
				var r = hex_data.get("r", 0)
				var s = hex_data.get("s", 0)
				var movement_cost = hex_data.get("movecost", 0)
				var cube_coords = Vector3(q, r, s)
				var hex_cell = HexCell.new(self.hex_size, self.hex_texture, cube_coords,movement_cost, parent)
				self.hexes.append(hex_cell)
				parent.add_child(hex_cell)
		else:
			print("Error parsing JSON:", data.error_string)
	else:
		print("Failed to open JSON file:", path)



	
#function that returns an array of hex objects that are the lowest cost path from start to finish
func find_path(start_hex, destination_hex) -> Array:

	# Check if the starting and destination hexes are valid
	if start_hex == null or destination_hex == null:
		return []
	 # Already at the destination
	if start_hex == destination_hex:
		return [] 

	# Dijkstra's algorithm setup
	var distances = {}  # Distance from start_hex to each hex
	var previous = {}   # To reconstruct the path. Each hex points to the hex that gives it the shorest distance.
	var frontier = []  # Hexes to process. Only hexes that are touching a hex we know the distance for.

	# Set the distance to the start_hex as 0
	distances[start_hex] = 0
	previous[start_hex] = null
	#initializes the frontier with the neighbors of the starting hex
	var neighbors = get_neighbors(start_hex)
	for hex in neighbors:
		frontier.append(hex)
	#main loop. will continue until all hexes are checked
	# hexes are added to frontier as we go
	while frontier.size() > 0:
		var current_hex = frontier.pop_front()
		distances[current_hex] = INF

		# iterates through neighbors and sees if there is a shorter distance from each neighbor
		# otherwise checks if neighbor is in frontier and if not it adds them expanding the search
		for neighbor in get_neighbors(current_hex):
			if(neighbor in distances):
				if(distances[current_hex] > distances[neighbor] + current_hex.movement_cost):
					distances[current_hex] = distances[neighbor] + current_hex.movement_cost
					previous[current_hex] = neighbor
			else:
				if neighbor not in frontier:
					frontier.append(neighbor)
		#if we found the right hex then build the path and return
		if current_hex == destination_hex:
			return reconstruct_path(previous, start_hex, current_hex)
	# If we exhaust the unvisited set without finding the destination, return null
	return []




# Helper function to reconstruct the path from the `previous` map
func reconstruct_path(previous, start_hex, destination_hex) -> Array:
	var path = []
	var current_hex = destination_hex
	while current_hex != null:
		path.insert(0,current_hex.position)
		current_hex = previous[current_hex]
	
	return path

# Helper function to find neighbors of a given hex
func get_neighbors(hex) -> Array:
	var neighbors = []
	# Cube coordinate offsets for neighbors
	var offsets = [Vector3(+1, -1,  0), Vector3(+1,  0, -1), Vector3( 0, +1, -1), Vector3(-1, +1,  0), Vector3(-1,  0, +1), Vector3( 0, -1, +1)]
	# Iterate over all potential neighbors
	for offset in offsets:
		var neighbor_coords = hex.cube_coords + offset
		for hex_obj in self.hexes:
			if hex_obj.cube_coords == neighbor_coords and hex_obj.walkable:
				neighbors.append(hex_obj)
				break  # Found the neighbor, no need to check further
	return neighbors

#function used by player objects to find thier current_hex after moving
func find_hex_from_coords(coords: Vector2)->HexCell:
	for hex in self.hexes:
		if Vector2(hex.position) == Vector2(coords):
			return hex
	return null
