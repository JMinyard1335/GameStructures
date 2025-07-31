class_name TileGraph extends Graph
## A Graph for storing and pulling data from [Tile]s
##
## Graph will be of the structure{ Vector3i : Tile}
## for example {(0,0,0) : Tile1, (0,0,1): Tile2...etc}
## There will be a second Dictionary of Tiles that contain
## Just the surface tiles that is Tiles with no other Tiles Above them.

## Holds just the tiles on the top level.
var surface_tiles: Dictionary = {} 

#region Graph Implementation
## Adds a new tile to the draph containing [param data] if it
## does not already exist.
func add_vertex(data: Variant) -> void:
	if graph.has(data as Vector3i):
		push_warning("This position already exist in the graph.")
		return
	
	var t: Tile = construct_tile(data as Vector3i)
	graph[t.position] = t
	graph[t.position].global_position = TileManager.map_to_world(t.position)
	# Check tiles are added properly
	assert(graph[t.position] == t, "Tiles are not being added")


## Looks for and removes the vertex if found from the graph and the surface tiles
## [param data] the data used as a key
func remove_vertex(data: Variant) -> void:
	var v: Tile 
	# handle the surface tile
	if surface_tiles.has(data):
		v = surface_tiles[data]
		for e in v.adjacency_list:
			surface_tiles[e].erase_adj(v.position)
	
	# handle the tilegraph
	if graph.has(data):
		v = graph[data]
		for e in v.adjacency_list:
			graph[e].erase_adj(v.position)
	
	graph.erase(data)


## Adds an edge from vertex_a to vertex_b and the edge from vertex_b to vertex_a.
## The cost however need to be allowed to be different from each other.
## Logically this is because the cost of going from lets say a grass tile is different
## from going to a water tile. Leaving a water tile for grass might cost 1 move point.
## while going from grass to water might cost 3.
func add_edge(vertex_a: Variant, vertex_b: Variant,  _weight: int = 0) -> void:
	if has_vertex(vertex_a) and has_vertex(vertex_b):
		graph[vertex_a].add_adj(
			graph[vertex_b].position, 
			graph[vertex_b].cost + graph[vertex_b].height
		)
		graph[vertex_b].add_adj(
			graph[vertex_a].position, 
			graph[vertex_a].cost + graph[vertex_a].height
		)
	# Add edges to surface tiles to if it has the vertices
	if surface_tiles.has(vertex_a) and surface_tiles.has(vertex_b):
		surface_tiles[vertex_a].add_adj(
			surface_tiles[vertex_b].position, 
			surface_tiles[vertex_b].cost + surface_tiles[vertex_b].height
		)
		surface_tiles[vertex_b].add_adj(
			surface_tiles[vertex_a].position, 
			surface_tiles[vertex_a].cost + surface_tiles[vertex_a].height
		)


## Grab the two vertices if they exist and remove the opposites refrence from the 
## adjacency list.
func remove_edge(vertex_a: Variant, vertex_b: Variant) -> void:
	if has_vertex(vertex_a) and has_vertex(vertex_b):
		graph[vertex_a].erase_adj(graph[vertex_b].position)
		graph[vertex_b].erase_adj(graph[vertex_a].position)
	if surface_tiles.has(vertex_a) and surface_tiles.has(vertex_b):
		surface_tiles[vertex_a].erase_adj(surface_tiles[vertex_b].position)
		surface_tiles[vertex_b].erase_adj(surface_tiles[vertex_a].position)


## Does the graph contain a node with the matching data
func has_vertex(data: Variant) -> bool:
	return graph.has(data)


## Checks if vertex_a is in vertex_b adjacency list and vice versa
func is_adjacent(vertex_a: Variant, vertex_b: Variant) -> bool:
	if not has_vertex(vertex_a) and not has_vertex(vertex_b):
		return false

	# make sure both vertices have an edge to the other as it is a grid map
	return graph[vertex_a].has_adj(vertex_b) and graph[vertex_b].has_adj(vertex_a)


## Returns the adjacency list stored in the Tile which is the value found 
## in the graph at graph[vertex]
func get_neighbors(vertex: Variant) -> Dictionary:
	return graph[vertex].adjacency_list if graph.has(vertex) else {}

#endregion

#region TileGraph Helpers
## Construct a tile based off a give Vector3i.
func construct_tile(data: Vector3i) -> Tile:
	var pos = data
	var type = TileManager.grid.get_cell_item(pos)
	return Tile.new(pos, type)


## returns a tile based off a Vectori if no tile was found
## the closest tile in world coordinates is picked.
func get_tile(pos: Vector3i) -> Tile:
	if not graph.has(pos):
		push_warning("Cant fetch a tile from that location")
		pos = find_closest_tile(pos)
	
	return graph[pos]


## Convert it all to world position. check if the distance between each
## adjacent tiles global position is closer to the desired position,
## Which ever of those are closest becomes the tile we grab.
##BUG: IDK WHAT
func find_closest_tile(pos: Vector3i) -> Vector3i:
	var igp: Vector3 = TileManager.map_to_world(pos)
	var adj: Array[Vector3i] = TileManager.get_adjacent_cells(pos)
	var closest:Vector3 = Vector3(INF, INF, INF)
	for p in adj:
		var gp = TileManager.map_to_world(p) 
		if abs(gp - igp) < abs(closest - igp):
			closest = p
			
	return TileManager.world_to_map(closest)


## for every tile in the graph check if there is a tile on top of it.
## if not add it to the surface tiles.Call this function after creating the 
## [TileGraph] with the [method TileManager.init] call.
func create_surface_list() -> void:
	if not surface_tiles:
		surface_tiles = {}
	surface_tiles.clear()
	
	for k in graph:
		if not graph.has(k + Vector3i(0,1,0)):
			surface_tiles[k] = graph[k]

#endregion

#region debugging
func print() -> void:
	for k in graph:
		print("-".repeat(80))
		print("Key: %s"%k)
		print("Stored Tile info")
		graph[k].print()

#endregion
