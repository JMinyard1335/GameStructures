class_name Pathfinder

var _start: Vector3i # Starting Grid Position of the node looking for a path.
var _came_from: Dictionary = {} # List of visited nodes
var _g_score: Dictionary = {} # the 
var _f_score: Dictionary = {} # the g_score + heuristic
var _closed: Dictionary = {}
var _neighbors: Array = []
var _heap: MinHeap

# Offsets used to calculate the neighbors of a node.
var _offsets: Array[Vector3i] = [
	Vector3i(1, 0, 0), Vector3i(1, 1, 0), Vector3i(1, -1, 0),
	Vector3i(-1, 0, 0), Vector3i(-1, 1, 0), Vector3i(-1, -1, 0),
	Vector3i(0, 0, 1), Vector3i(0, 1, 1), Vector3i(0, -1, 1),
	Vector3i(0, 0, -1), Vector3i(0, 1, -1), Vector3i(0, -1, -1),
]

## Finds a path from a given node to a goal position in a 3D tilemap. [br]
## [u][b]Parameters[/b][/u]: [br]
## [param node]: [Node3D] - The starting node for the pathfinding. [br]
## [param goal]: [Vector3i] - The target position to reach. [br]
## [br]
## [u][b]Returns[/b][/u]: [br]
## [code]Result[/code] - A result object containing the path as an array of positions or an error code if the pathfinding fails. [br]
## [br]
## [u][b]Errors[/b][/u]: [br]
## [constant Types.Error.INVALID_INPUT]: Returned if the start or goal positions are invalid. [br]
## [constant Types.Error.OBJECT_NOT_FOUND]: Returned if no path is found. [br]
## [br]
## [u][b]Important Notes[/b][/u]: [br]
## + The function clears previous pathfinding data before starting a new search. [br]
## + It checks if the start and goal positions are valid cells in the tilemap. [br]
## + The algorithm uses a priority queue (_heap) to explore nodes based on their heuristic scores. [br]
## + Nodes that are occupied or not walkable are skipped during the search. [br]
## + If the goal is found, the function reconstructs the path using the _came_from dictionary. [br]
## + If no path is found, the function returns an empty array with an error code. [br]
## + Ensure that the tilemap and its properties (e.g., is_occupied, is_walkable, move_cost) are correctly configured. [br]
func find_path(node: Node3D, goal: Vector3i) -> Array[Vector3i]:
	_clear_data()
	_init_search(node, goal)
	print(_start)
	print(goal)
	if not TileManager.has_cell(_start) or not TileManager.has_cell(goal):
		push_warning("Invalid _Start or Goal position")
		return []

	while not _heap.is_empty():
		var current: Vector3i = _heap.pop().data
		if current in _closed: # We have already visited this node.
			continue
		_closed[current] = true
		
		if current == goal:  # Goal is found return a path
			return _reconstruct_path(current)

		for n in _get_neighbors(current):
			var tile = TileManager.get_tile(n)
			if tile == null:
				printerr("find_path(): Unable to get a Tile from the neighbors list")
			if tile == null or tile.is_occupied or not tile.is_walkable:
				continue

			var tentative_g = _g_score.get(current, INF) + tile.cost
			if tentative_g < _g_score.get(n, INF):
				_came_from[n] = current
				_g_score[n] = tentative_g
				_f_score[n] = tentative_g + _heuristic(n, goal)

				if not _heap.has(n, _f_score[n]):
					_heap.push(n, _f_score[n])

	push_warning("Path not found, Returning an empty array")
	return []


# Manhattan Distance used as a heuristic.
func _heuristic(a: Vector3i, b: Vector3i):
	return abs(a.x - b.x) + abs(a.y - b.y) + abs(a.z - b.z)


func _reconstruct_path(current: Vector3i) -> Array[Vector3i]:
	var path: Array[Vector3i] = [current]
	while _came_from.has(current):
		current = _came_from[current]
		path.insert(0, current)
	return path


func _get_neighbors(pos: Vector3i):
	_neighbors.clear()
	for offset in _offsets:
		var n = pos + offset
		if TileManager.has_cell(n):
			_neighbors.append(n) 
	return _neighbors


## Converts a path from local tilemap coordinates to global coordinates. [br]
## [u][b]Parameters[/b][/u]: [br]
## [param path]: [Array] - An array of positions in local tilemap coordinates. [br]
## [br]
## [u][b]Returns[/b][/u]: [br]
## [code]Array[/code] - An array of positions in global coordinates. [br]
## [br]
## [u][b]Important Notes[/b][/u]: [br]
## + The function iterates through each position in the input path. [br]
## + Each position is converted to global coordinates using [method Tilemap.map_to_global]. [br]
## + Ensure that the input path contains valid tilemap positions to avoid unexpected behavior. [br]
## + The returned array (_global_path) contains the converted global positions. [br]
func path_to_global(path: Array) -> Array[Vector3]:
	var _global_path: Array[Vector3] = []
	for p in path:
		_global_path.append(TileManager.map_to_world(p))
	return _global_path


# Makes sure all data has been cleared from the structures
func _clear_data():
	_g_score.clear()
	_f_score.clear()
	_came_from.clear()
	_closed.clear()
	_start = Vector3i.ZERO


# Sets up all the initial info needed for the search.
func _init_search(node, goal):
	if not _heap: # If there is no _heap create one 
		_heap = MinHeap.new()
		
	_heap.clear() # If the _heap exists clear it.
	_start = TileManager.world_to_map(node.position) - Vector3i(0,1,0)
	_heap.push(_start, 0)
	_g_score[_start] = 0
	_f_score[_start] = _heuristic(_start, goal)
