@abstract class_name Graph
## A graph is a dictionary of objects
##
## The Dictionary is { start Variant : { destination Variant : cost int }}

#region Variables --------------------------------------------------------------
var graph: Dictionary = {} 
var rev_edge_map: Dictionary = {}
#endregion ---------------------------------------------------------------------

#region Abstract Functions -----------------------------------------------------
@abstract func remove_vertex(vertex: Variant) -> void
@abstract func add_edge(vertex_a: Variant, vertex_b: Variant,  weight: int = 0) -> void
@abstract func remove_edge(vertex_a: Variant, vertex_b: Variant) -> void
#endregion ---------------------------------------------------------------------


#region Base Functions ---------------------------------------------------------
## Adds a new vertex to the graph if it one does not already exist.
## [param vertex]: [Variant] the data to be stored as a key
func add_vertex(vertex: Variant) -> void:
	if graph.has(vertex):
		push_warning("Trying to add an existing vertex")
		return
	
	graph[vertex] = {}


## Check if there is an edge between vertex_a and vertex_b. [br]
## [param vertex_a]: [Variant] start of the path[br]
## [param vertex_b]: [Variant] destination to check[br]
func is_adjacent(vertex_a: Variant, vertex_b: Variant) -> bool:
	if not _vertices_exist(vertex_a, vertex_b):
		return false
	
	return graph[vertex_a].has(vertex_b)


##
func get_neighbors(vertex: Variant) -> Dictionary:
	if not graph.has(vertex):
		push_warning("Vertex does not exist")
		return {}
	
	return graph[vertex]


## Returns the path cost from the graph, -1 if no path cost exists
## [param vertex_a] : [Variant] the starting vertex
## [param vertex_b] : [Variant] the ending vertex
func get_cost(vertex_a: Variant, vertex_b: Variant) -> int:
	if not _vertices_exist(vertex_a, vertex_b):
		return -1
	if not graph[vertex_a].has(vertex_b):
		push_warning("Vertex A does not have an edge to Vertex B")
		return -1
	
	return graph[vertex_a][vertex_b]


func has_vertex(vertex: Variant) -> bool:
	return graph.has(vertex)


# Check if the two vertices exist and prints which or both.
func _vertices_exist(vertex_a: Variant, vertex_b: Variant) -> bool:
	if not graph.has(vertex_a) or not graph.has(vertex_b): # Check if the vertices are in the graph.
		var m: String = ""
		if not graph.has(vertex_a):
			m = m + "vertex_a is not in the graph\n"
		if not graph.has(vertex_b):
			m = m + "vertex_b is not in the graph\n"
		push_warning(m)
		return false
	return true

#endregion ---------------------------------------------------------------------
