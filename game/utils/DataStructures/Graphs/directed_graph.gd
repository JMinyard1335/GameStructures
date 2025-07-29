class_name DirectedGraph extends Graph
## A Directed Graph implementation in Godot4.5
##
## In a Directed Graph an edge has a direction. Meaning
## an edge from A -> B is not the same as the edge from
## B -> A. 

	
## Removes the vertex and all edges connecting it to other nodes.
## [param vertex]: [Variant] the vertex to find and remove.
## Should use remove_edge for edge removal
func remove_vertex(vertex: Variant) -> void:
	for neighbor in get_neighbors(vertex): # pushes a warning if vertex is not found
		remove_edge(vertex, neighbor)
	graph.erase(vertex)

	
## Adds an edge between vertex_a and vertex_b if they exist.
## [param vertex_a]: [Variant] the starting vertex
## [param vertex_b]: [Variant] the destination vertex
## [param weight]: [int] the cost to take this path, defaults to 0 for unweighted graphs
func add_edge(vertex_a: Variant, vertex_b: Variant,  weight: int = 0) -> void:
	if not _vertices_exist(vertex_a, vertex_b):
		return
	if graph[vertex_a].has(vertex_b) and graph[vertex_a][vertex_b] == weight:
		push_warning("Edge already exists, Returning from function")
		return
	
	graph[vertex_a][vertex_b] = weight
		

	
func remove_edge(vertex_a: Variant, vertex_b: Variant) -> void:
	if not _vertices_exist(vertex_a, vertex_b):
		return
	if not graph[vertex_a].has(vertex_b):
		push_warning("Edge does not exist")
		return
	
	graph[vertex_a].erase(vertex_b)


func is_adjacent(vertex_a: Variant, vertex_b: Variant) -> bool:
	if not _vertices_exist(vertex_a, vertex_b):
		return false
	
	return graph[vertex_a].has(vertex_b)


## Returns the adjacency list of the vertex if it exist otherwise {}.
## [param vertex]: The graph vertex to check for and return its neighbors
func get_neighbors(vertex: Variant) -> Dictionary:
	if not graph.has(vertex):
		push_warning("The Graph does not contain vertex: %s"%vertex)
		return {}
	
	return graph[vertex]
