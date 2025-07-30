class_name TileGraph extends Graph
## A Graph for storing and pulling data from [Tile]s
##
## Graph will be of the structure{ Vector3i : Tile}
## for example {(0,0,0) : Tile1, (0,0,1): Tile2...etc}

func add_vertex(data: Variant) -> void:
	if graph.has(data as Vector3i):
		push_warning("This position already exist in the graph.")
		return
	
	var t: Tile = construct_tile(data as Vector3i)
	graph[t.position] = t
	graph[t.position].global_position = TileManager.map_to_world(t.position)

	if graph[t.position] != t:
		push_error("Tiles are not being added")
	
	
func remove_vertex(vertex: Variant) -> void:
	if not has_vertex(vertex):
		return

	# Get the tile we are removing
	var v = graph[vertex] as Tile
	# Go through its adjacency list
	for e in v.adjacency_list:
		# Grab each listed in adjacency list
		var av = graph[e] as Tile
		# erase the passed in vertex's position
		av.erase_adj(v.position)
		
	# remove the vertex after all edges have been removed
	graph.erase(vertex)


## Adds an edge from vertex_a to vertex_b and the edge from vertex_b to vertex_a.
## The cost however need to be allowed to be different from each other.
## Logically this is because the cost of going from lets say a grass tile is different
## from going to a water tile. Leaving a water tile for grass might cost 1 move point.
## while going from grass to water might cost 3.
func add_edge(vertex_a: Variant, vertex_b: Variant,  _weight: int = 0) -> void:
	if not has_vertex(vertex_a) or not has_vertex(vertex_b):
		push_warning("Either or both vertices do not exist.")
		return

	var va = graph[vertex_a] as Tile
	var vb = graph[vertex_b] as Tile

	va.adjacency_list[vb.position] = vb.cost + vb.height 	# Total cost is move cost plus height
	vb.adjacency_list[va.position] = va.cost + va.height
	
	
func remove_edge(vertex_a: Variant, vertex_b: Variant) -> void:
	if not has_vertex(vertex_a) or not has_vertex(vertex_b):
		push_warning("Either or both vertices do not exist.")
		return

	var va = graph[vertex_a] as Tile
	var vb = graph[vertex_b] as Tile

	va.erase_adj(vb.position)
	vb.erase_adj(va.position)
	

func has_vertex(data: Variant) -> bool:
	if not graph.has(data):
		push_warning("The Graph does not contain %s"%data)
		return false
	
	return true


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


## Construct a tile based off a give Vector3i
func construct_tile(data: Vector3i) -> Tile:
	var pos = data
	var type = TileManager.grid.get_cell_item(pos)
	return Tile.new(pos, type)


func get_tile(pos: Vector3i) -> Tile:
	if not graph.has(pos):
		push_warning("Cant fetch a tile from that location")
		return null
	
	return graph[pos]


func print() -> void:
	for k in graph:
		print("-".repeat(80))
		print("Key: %s"%k)
		print("Stored Tile info")
		graph[k].print()
