extends Node

class_name Pathfinder

var astar: AStar3D
var offset: Vector3i = Vector3i(0,1,0)


## Initializes the AStar3D graph using the TileManager
func initialize_astar():
	astar = AStar3D.new()

	# Add tiles as points in the AStar3D graph
	for cell in TileManager.grid.get_used_cells():
		if is_top_tile(cell):
			var id = cell_to_id_hash(cell)
			# Use world position for AStar3D, not cell coordinates
			var world_pos = TileManager.map_to_world(cell)
			astar.add_point(id, world_pos)


	# Connect adjacent tiles
	for cell in TileManager.grid.get_used_cells():
		if is_top_tile(cell):
			var id = cell_to_id_hash(cell)
			for neighbor in TileManager.get_adjacent_cells(cell):
				if is_top_tile(neighbor):
					var neighbor_id = cell_to_id_hash(neighbor)
					if astar.has_point(id) and astar.has_point(neighbor_id):
						var cost = movement_cost(cell, neighbor)
						astar.connect_points(id, neighbor_id, cost)


## Finds a path from the start tile to the end tile
func find_path(start: Vector3i, end: Vector3i) -> Array[Vector3i]:
	print("\n=== PATHFINDING ===")
	print("Finding path from: ", start - offset, " to: ", end - offset)
	
	var start_id = cell_to_id_hash(start - offset)
	var end_id = cell_to_id_hash(end - offset)
	
	print("Start ID: ", start_id, " End ID: ", end_id)
	print("Start point exists: ", astar.has_point(start_id))
	print("End point exists: ", astar.has_point(end_id))
	
	# Check if both points are top tiles
	print("Start is top tile: ", is_top_tile(start))
	print("End is top tile: ", is_top_tile(end))

	if astar.has_point(start_id) and astar.has_point(end_id):
		var world_path = astar.get_point_path(start_id, end_id)
		print("World path found with ", world_path.size(), " points")
		
		# Convert world positions back to cell coordinates
		var cell_path: Array[Vector3i] = []
		for world_pos in world_path:
			var cell = TileManager.world_to_map(world_pos)
			cell_path.append(cell)
			print("Path point: ", world_pos, " -> cell: ", cell)
		
		print("=== PATHFINDING COMPLETE ===\n")
		return cell_path
	else:
		print("Cannot find path - one or both points don't exist in AStar graph")
		print("=== PATHFINDING FAILED ===\n")
		return []


## Hash-based ID generation with better collision avoidance
func cell_to_id_hash(cell: Vector3i) -> int:
	# Larger offset to handle bigger coordinate ranges
	var offset_x = cell.x + 50000
	var offset_y = cell.y + 50000  
	var offset_z = cell.z + 50000
	
	# Much larger multipliers to avoid collisions
	var id = offset_x * 1000000000 + offset_y * 100000 + offset_z
	
	# Ensure positive ID
	if id < 0:
		print("WARNING: Negative ID generated for cell ", cell, ": ", id)
		# Fallback: use absolute value with additional offset
		id = abs(id) + 1000000000
	
	return id


## Checks if a tile is the top tile (no other tiles above it)
func is_top_tile(tile: Vector3i) -> bool:
	var above_tile = tile + Vector3i(0, 1, 0)
	var result = not TileManager.has_cell(above_tile)
	# Uncomment for detailed debugging:
	# print("Checking if ", tile, " is top tile: ", result, " (above: ", above_tile, ")")
	return result


## Calculates the movement cost between two tiles
## Moving up in the Y-axis is more expensive
func movement_cost(current: Vector3i, neighbor: Vector3i) -> float:
	var cost = 1.0  # Base cost for X and Z movement
	if neighbor.y > current.y:
		cost += 2.0  # Additional cost for moving up
	return cost


## Debug function to print all points in the AStar graph
func debug_print_all_points():
	print("\n=== ALL ASTAR POINTS ===")
	for i in astar.get_point_count():
		var point_id = astar.get_point_ids()[i]
		var position = astar.get_point_position(point_id)
		print("ID: ", point_id, " Position: ", position)
	print("=== END POINTS LIST ===\n")


## Debug function to check if two points are connected
func debug_check_connection(cell1: Vector3i, cell2: Vector3i):
	var id1 = cell_to_id_hash(cell1)
	var id2 = cell_to_id_hash(cell2)
	
	if astar.has_point(id1) and astar.has_point(id2):
		var connected = astar.are_points_connected(id1, id2)
		print("Connection between ", cell1, " and ", cell2, ": ", connected)
	else:
		print("Cannot check connection - one or both points don't exist")
