extends Node

var grid: GridMap
var tile_graph: TileGraph


func init(g: GridMap) -> void:
	grid = g
	tile_graph = TileGraph.new() 
	for cell in grid.get_used_cells():
		# TileGraph automatically makes the tiles based off a cell
		tile_graph.add_vertex(cell)
		
		# Add edges to adjacent tiles
		for neighbor in get_adjacent_cells(cell):
			if tile_graph.graph.has(neighbor):
				tile_graph.add_edge(cell, neighbor)
		#tile_graph.print()
				
# Helper function to get adjacent cells in the grid
func get_adjacent_cells(cell: Vector3i) -> Array:
	var directions = [
		Vector3i(1, 0, 0), Vector3i(-1, 0, 0), # Left and Right
		Vector3i(0, 0, 1), Vector3i(0, 0, -1)  # Forward and Backward
	]
	var neighbors = []
	for dir in directions:
		var neighbor = cell + dir
		if has_cell(neighbor): # Check if the neighbor exists in the grid
			neighbors.append(neighbor)
	return neighbors


func map_to_world(pos: Vector3i) -> Vector3:
	if not tile_graph.graph.has(pos):
		push_warning("no tile exists to map to world coordinates ".to_upper() + str(pos).to_upper())
		
	return grid.to_global(grid.map_to_local(pos))


func world_to_map(pos: Vector3) -> Vector3i:
	var grid_coord: Vector3i = grid.local_to_map(grid.to_local(pos))		
	return grid_coord


## Call to check if there is a cell in the gridmap.
func has_cell(cell: Vector3i) -> bool:
	if grid.get_used_cells().find(cell) != -1:
		return true
	
	return false


func has_tile(pos: Vector3i) -> bool:
	return tile_graph.has_vertex(pos)


func get_tile(pos: Vector3i) -> Tile:
	return tile_graph.get_tile(pos)
