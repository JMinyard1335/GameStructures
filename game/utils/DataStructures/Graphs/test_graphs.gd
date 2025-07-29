extends GutTest


#region Abstract Graph ---------------------------------------------------------
## Used to test the implementations that are universal to all graphs
class TestGraph:
	extends GutTest
	var graph: DirectedGraph

	func before_each():
		graph = DirectedGraph.new()

	func after_each():
		autofree(graph)

	# Test adding a vertex
	func test_add_vertex():
		graph.add_vertex("A")
		assert_true(graph.graph.has("A"), "Vertex 'A' should be added to the graph")

	func test_add_multiple():
		graph.add_vertex("A")
		graph.add_vertex("B")
		assert_true(graph.graph.has("A"), "Graph does not have the first vector added")
		assert_true(graph.graph.has("B"), "Graph does not have the second vector added")

	# Test adding an existing vertex
	func test_add_existing_vertex():
		graph.add_vertex("A")
		graph.add_vertex("A")
		assert_eq(graph.graph.size(), 1, "Graph should not add duplicate vertices")

	# Test getting cost between vertices
	func test_get_cost():
		graph.add_vertex("A")
		graph.add_vertex("B")
		assert_true(graph.graph.has("B"), "B is not in the graph")
		graph.add_edge("A", "B", 5)
		assert_eq(graph.get_cost("A", "B"), 5, "Cost between 'A' and 'B' should be 5")

	# Test getting cost for non-existent edge
	func test_get_cost_non_existent_edge():
		graph.add_vertex("A")
		graph.add_vertex("B")
		assert_eq(graph.get_cost("A", "B"), -1, "Cost for non-existent edge should be -1")

	# Test checking vertex existence
	func test_vertices_exist():
		graph.add_vertex("A")
		graph.add_vertex("B")
		assert_true(graph._vertices_exist("A", "B"), "Both vertices should exist")
		assert_false(graph._vertices_exist("A", "C"), "Vertex 'C' does not exist")


#endregion ---------------------------------------------------------------------


#region Directed Graph ---------------------------------------------------------
## Used to test the Directed Graph implementation
class TestDirectedGraph:
	extends GutTest

	# Test adding an edge
	func test_add_edge():
		var graph = DirectedGraph.new()
		graph.add_vertex("A")
		graph.add_vertex("B")
		graph.add_edge("A", "B", 10)
		assert_true(graph.is_adjacent("A", "B"), "Edge from 'A' to 'B' should exist")
		assert_eq(graph.get_cost("A", "B"), 10, "Cost of edge from 'A' to 'B' should be 10")

	# Test adding an edge that already exists
	func test_add_existing_edge():
		var graph = DirectedGraph.new()
		graph.add_vertex("A")
		graph.add_vertex("B")
		graph.add_edge("A", "B", 10)
		graph.add_edge("A", "B", 10)
		assert_eq(graph.graph["A"].size(), 1, "Duplicate edges should not be added")

	# Test removing an edge
	func test_remove_edge():
		var graph = DirectedGraph.new()
		graph.add_vertex("A")
		graph.add_vertex("B")
		graph.add_edge("A", "B", 10)
		graph.remove_edge("A", "B")
		assert_false(graph.is_adjacent("A", "B"), "Edge from 'A' to 'B' should be removed")

	# Test removing a vertex
	func test_remove_vertex():
		var graph = DirectedGraph.new()
		graph.add_vertex("A")
		graph.add_vertex("B")
		graph.add_edge("A", "B", 10)
		graph.remove_vertex("A")
		assert_false(graph.graph.has("A"), "Vertex 'A' should be removed")
		assert_false(graph.is_adjacent("A", "B"), "Edges connected to 'A' should be removed")

	# Test getting neighbors
	func test_get_neighbors():
		var graph = DirectedGraph.new()
		graph.add_vertex("A")
		graph.add_vertex("B")
		graph.add_edge("A", "B", 10)
		var neighbors = graph.get_neighbors("A")
		assert_true(neighbors.has("B"), "Vertex 'B' should be a neighbor of 'A'")
		assert_eq(neighbors["B"], 10, "Cost to neighbor 'B' should be 10")

	# Test getting neighbors for non-existent vertex
	func test_get_neighbors_non_existent_vertex():
		var graph = DirectedGraph.new()
		var neighbors = graph.get_neighbors("C")
		assert_eq(neighbors.size(), 0, "Non-existent vertex should have no neighbors")


#endregion ---------------------------------------------------------------------


#region UnDirected Graph -------------------------------------------------------
class TestUndirectedGraph:
	extends GutTest

	var graph: UndirectedGraph

	func before_each():
		graph = UndirectedGraph.new()
		graph.add_vertex("A")
		graph.add_vertex("B")
		graph.add_vertex("C")

	func test_add_edge():
		# Test case 1: Adding an edge between two existing vertices
		graph.add_edge("A", "B", 5)
		assert_true(graph.is_adjacent("A", "B"), "Edge A-B should exist")
		assert_true(graph.is_adjacent("B", "A"), "Edge B-A should exist")
		assert_eq(graph.get_cost("A", "B"), 5, "Edge A-B should have weight 5")
		assert_eq(graph.get_cost("B", "A"), 5, "Edge B-A should have weight 5")

		# Test case 2: Adding an edge that already exists
		graph.add_edge("A", "B", 5)
		assert_true(graph.is_adjacent("A", "B"), "Edge A-B should still exist")
		assert_true(graph.is_adjacent("B", "A"), "Edge B-A should still exist")
		assert_eq(graph.get_cost("A", "B"), 5, "Edge A-B should still have weight 5")
		assert_eq(graph.get_cost("B", "A"), 5, "Edge B-A should still have weight 5")

		# Test case 3: Adding an edge where one vertex does not exist
		graph.add_edge("A", "D", 10)
		assert_false(graph.is_adjacent("A", "D"), "Edge A-D should not exist")
		assert_false(graph.is_adjacent("D", "A"), "Edge D-A should not exist")

		# Test case 4: Adding an edge with a specific weight
		graph.add_edge("A", "C", 7)
		assert_true(graph.is_adjacent("A", "C"), "Edge A-C should exist")
		assert_true(graph.is_adjacent("C", "A"), "Edge C-A should exist")
		assert_eq(graph.get_cost("A", "C"), 7, "Edge A-C should have weight 7")
		assert_eq(graph.get_cost("C", "A"), 7, "Edge C-A should have weight 7")

	func test_remove_edge():
		# Add an edge for testing
		graph.add_edge("A", "B", 5)

		# Test case 1: Removing an edge that exists
		graph.remove_edge("A", "B")
		assert_false(graph.is_adjacent("A", "B"), "Edge A-B should be removed")
		assert_false(graph.is_adjacent("B", "A"), "Edge B-A should be removed")

		# Test case 2: Removing an edge that does not exist
		graph.remove_edge("A", "C")
		assert_false(graph.is_adjacent("A", "C"), "Edge A-C should not exist")
		assert_false(graph.is_adjacent("C", "A"), "Edge C-A should not exist")

		# Test case 3: Removing an edge where one vertex does not exist
		graph.remove_edge("A", "D")
		assert_false(graph.is_adjacent("A", "D"), "Edge A-D should not exist")

	func test_remove_vertex():
		# Add edges for testing
		graph.add_edge("A", "B", 5)
		graph.add_edge("A", "C", 7)

		# Test case 1: Removing a vertex that exists
		graph.remove_vertex("A")
		assert_false(graph.graph.has("A"), "Vertex A should be removed")
		assert_false(graph.is_adjacent("A", "B"), "Edges connected to A should be removed")
		assert_false(graph.is_adjacent("A", "C"), "Edges connected to A should be removed")

		# Test case 2: Removing a vertex that does not exist
		graph.remove_vertex("D")
		assert_false(graph.graph.has("D"), "Vertex D should not exist")

		# Test case 3: Removing a vertex with multiple edges
		graph.add_edge("B", "C", 10)
		graph.remove_vertex("B")
		assert_false(graph.graph.has("B"), "Vertex B should be removed")
		assert_false(graph.is_adjacent("B", "C"), "Edges connected to B should be removed")

	func test_get_neighbors():
		# Add edges for testing
		graph.add_edge("A", "B", 5)
		graph.add_edge("A", "C", 7)

		# Test case 1: Getting neighbors of a vertex that exists
		var neighbors = graph.get_neighbors("A")
		assert_true(neighbors.has("B"), "Vertex B should be a neighbor of A")
		assert_true(neighbors.has("C"), "Vertex C should be a neighbor of A")
		assert_eq(neighbors["B"], 5, "Edge A-B should have weight 5")
		assert_eq(neighbors["C"], 7, "Edge A-C should have weight 7")

		# Test case 2: Getting neighbors of a vertex that does not exist
		neighbors = graph.get_neighbors("D")
		assert_eq(neighbors.size(), 0, "Non-existent vertex should have no neighbors")

#endregion
