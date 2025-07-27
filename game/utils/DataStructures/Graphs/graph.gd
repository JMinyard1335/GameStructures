@abstract class_name Graph
## A graph is a dictionary of objects
##
## The Dictionary is {Vertex : Array[Edges]}

var graph: Dictionary = {}
var edge_map: Dictionary = {}

@abstract func add_vertex(data: Variant, key: int) -> void
@abstract func remove_vertex(vertex: Vertex) -> void
@abstract func add_edge(vertex_a: Vertex, vertex_b: Vertex, weight: int = 0) -> void
@abstract func remove_edge(edge: Edge) -> void
@abstract func is_adjacent(vertex_a: Vertex, vertex_b: Vertex) -> bool
@abstract func get_neighbors(vertex: Vertex) -> Dictionary;

class Vertex:
	var data: Variant
	var key: int
	
	func _init(d: Variant, k: int) -> void:
		data = d
		key = k
		
	func _hash() -> int:
		return key
	
	func _equals(other: Vertex) -> bool:
		return self.key == other.key
		
	
class Edge:
	var start: Vertex
	var end: Vertex
	var weight: int
	
	func _init(s: Vertex, e: Vertex, w: int) -> void:
		start = s
		end = e
		weight = w

	func _equals(other: Edge) -> bool:
		return start == other.start and end == other.end and weight == other.weight
		

