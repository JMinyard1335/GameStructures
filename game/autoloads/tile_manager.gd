extends Node
## Used to manager the [GridMap] and the [TileGraph]
##
## The [GridMap] holds info about the actual grid such as
## info regarding the mesh library. The [TileGraph] is a graph of
## [Tile]s used to store additional info about each cell in the [GridMap].

var grid: GridMap
var tile_graph: TileGraph
var dir_offset = [
	Vector3i(1, 0, 0), Vector3i(-1, 0, 0), # Left and Right
	Vector3i(0, 0, 1), Vector3i(0, 0, -1)  # Forward and Backward
]


## In charge of taking a [GridMap] and creating a [TileGraph]
## from it.
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

		
## Checks the left, right, forward, and back. cells to see if there are
## any that exist adjacent to the given cell.
func get_adjacent_cells(cell: Vector3i) -> Array:
	var neighbors = []
	for dir in dir_offset:
		var neighbor = cell + dir
		if has_cell(neighbor): # Check if the neighbor exists in the grid
			neighbors.append(neighbor)
	return neighbors


## Takes a grid coordinate ie. (0,0,1) and converts it to its
## global position which is a [Vector3]. if there is no tile at
## the given position push a warning and convert the value anyways
func map_to_world(pos: Vector3i) -> Vector3:
	if not tile_graph.graph.has(pos):
		push_warning("no tile exists to map to world coordinates ".to_camel_case() + str(pos).to_upper())
		
	return grid.to_global(grid.map_to_local(pos))


func world_to_map(pos: Vector3) -> Vector3i:
	var grid_coord: Vector3i = grid.local_to_map(grid.to_local(pos))		
	return grid_coord


## Call to check if there is a cell in the gridmap.
func has_cell(cell: Vector3i) -> bool:
	if grid.get_used_cells().find(cell) != -1:
		return true
	
	return false


## Checks to see if there is a tile in the [TileGraph].
func has_tile(pos: Vector3i) -> bool:
	return tile_graph.has_vertex(pos)


## Returns a tile from the [TileGraph]
func get_tile(pos: Vector3i) -> Tile:
	return tile_graph.get_tile(pos)
