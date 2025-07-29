class_name UndirectedGraph extends Graph
## A Graph with undirected edges.
##
## Can also be thought of as a bidirectional graph.


func add_edge(vertex_a: Variant, vertex_b: Variant,  weight: int = 0) -> void:
	if not _vertices_exist(vertex_a, vertex_b):
		return
	if graph[vertex_a].has(vertex_b) and graph[vertex_b].has(vertex_a):
		push_warning("The edge already exists.")
		return
	
	graph[vertex_a][vertex_b] = weight
	graph[vertex_b][vertex_a] = weight


func remove_edge(vertex_a: Variant, vertex_b: Variant) -> void:
	if not _vertices_exist(vertex_a, vertex_b): # do both vertices exist
		return
	if graph.has(vertex_a) and not graph[vertex_a].has(vertex_b):
		push_warning("Edge from a -> b does not exist")
	if graph.has(vertex_b) and not graph[vertex_b].has(vertex_a):
		push_warning("Edge from b -> a does not exist")		

	graph[vertex_a].erase(vertex_b)
	graph[vertex_b].erase(vertex_a)


func remove_vertex(vertex: Variant) -> void:
	if not graph.has(vertex):
		push_warning("The Graph does not contain the given vertex")
		return
	
	for k in graph[vertex].keys():
		remove_edge(vertex, k)
	graph.erase(vertex)


func get_neighbors(vertex: Variant) -> Dictionary:
	if not graph.has(vertex):
		push_warning("Vertex does not exist")
		return {}
	
	return graph[vertex]
