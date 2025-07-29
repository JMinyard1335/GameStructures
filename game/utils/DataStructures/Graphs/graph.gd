@abstract class_name Graph
## A graph is a dictionary of objects
##
## The Dictionary is { start Variant : info Variant}
## The Vertices should be represented by something like a String, int, Vector...etc

#region Variables --------------------------------------------------------------
var graph: Dictionary = {}
var rev_edge_map: Dictionary = {}
var key_pos: int = 0
#endregion ---------------------------------------------------------------------

#region Abstract Functions -----------------------------------------------------
@abstract func add_vertex(data: Variant) -> void
@abstract func remove_vertex(vertex: Variant) -> void
@abstract func add_edge(vertex_a: Variant, vertex_b: Variant,  weight: int = 0) -> void
@abstract func remove_edge(vertex_a: Variant, vertex_b: Variant) -> void
@abstract func is_adjacent(vertex_a: Variant, vertex_b: Variant) -> bool
@abstract func get_neighbors(vertex: Variant) -> Dictionary
@abstract func has_vertex(data: Variant) -> bool
#endregion ---------------------------------------------------------------------
