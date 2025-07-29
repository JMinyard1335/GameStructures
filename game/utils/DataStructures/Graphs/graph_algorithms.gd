class_name GraphAlgos
## Collection of graph algorithms for easy use.

static func dijkstra(graph: Graph, start_tile: Tile, target_tile: Tile) -> Array[Tile]:
	# Initialize distances and priority queue
	var distances: Dictionary = {}
	var previous: Dictionary = {}
	var unvisited: Array = []
	
	# Set initial distances to infinity and previous nodes to null
	for tile in graph.graph.keys():
		distances[tile] = INF
		previous[tile] = null
		unvisited.append(tile)
	
	# Distance to the start tile is 0
	distances[start_tile] = 0
	
	while unvisited.size() > 0:
		# Find the tile with the smallest distance
		var current_tile: Tile = null
		var smallest_distance = INF
		for tile in unvisited:
			if distances[tile] < smallest_distance:
				smallest_distance = distances[tile]
				current_tile = tile
		
		# If the smallest distance is infinity, we are done
		if smallest_distance == INF:
			break
		
		# Remove the current tile from the unvisited set
		unvisited.erase(current_tile)
		
		# Update distances for neighbors
		for neighbor in graph.get_neighbors(current_tile).keys():
			var edge_cost = graph.get_cost(current_tile, neighbor)
			var alternative_path = distances[current_tile] + edge_cost
			if alternative_path < distances[neighbor]:
				distances[neighbor] = alternative_path
				previous[neighbor] = current_tile
		
		# Stop if we reached the target tile
		if current_tile == target_tile:
			break
	
	# Reconstruct the shortest path
	var path: Array[Tile] = []
	var step = target_tile
	while step != null:
		path.insert(0, step) # Insert at the beginning to reverse the path
		step = previous[step]
	
	return path


# func prims(graph: Graph) -> Graph:
# 	pass


# func a_star(graph: Graph) -> Graph:
# 	pass
	
