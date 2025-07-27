class_name UndirectedGraph extends Graph
## A Graph with undirected edges.


func add_vertex(data: Variant, key: int) -> void:
	var vertex = Vertex.new(data, key)
	if graph.has(vertex):
		push_warning("Attempted to add a Vertex that already exist, No action taken")
		return
	graph[vertex] = {}


func add_edge(vertex_a: Vertex, vertex_b: Vertex, weight: int = 0) -> void:
	if not graph.has(vertex_a) or not graph.has(vertex_b):
		push_error("One or both Vertices do not exist, No action taken")
		return
	
	var edge_a = Edge.new(vertex_a, vertex_b, weight)
	var edge_b = Edge.new(vertex_b, vertex_a, weight)

	if not graph[vertex_a].has(edge_a):
		graph[vertex_a][edge_a] = weight
		if not edge_map.has(vertex_b):
			edge_map[vertex_b] = []
		edge_map[vertex_b].append(edge_a)
	
	if not graph[vertex_b].has(edge_b):
		graph[vertex_b][edge_b] = weight
		if not edge_map.has(vertex_a):
			edge_map[vertex_a] = []
		edge_map[vertex_a].append(edge_b)
	
		
func remove_vertex(vertex: Vertex) -> void:
	if not graph.has(vertex):
		push_warning("Attempted to remove a Vertex that does not exist, No action taken")
		return

	graph.erase(vertex)
	if edge_map.has(vertex):
		for e in edge_map[vertex]:
			graph[e.start].erase(e)
		edge_map.erase(vertex)

		
func remove_edge(edge: Edge) -> void:
	if not graph.has(edge.start):
		push_warning("Attempted to remove edge from vertex that does not exist.")
		return
	if not graph[edge.start].has(edge):
		push_warning("Attempted to remove an edge that does not exist.")
		return
	
	graph[edge.start].erase(edge)
	if edge_map.has(edge.end):
		edge_map[edge.end].erase(edge)


func is_adjacent(vertex_a: Vertex, vertex_b: Vertex) -> bool:
	return false


func get_neighbors(vertex: Vertex) -> Dictionary:
	return {}
