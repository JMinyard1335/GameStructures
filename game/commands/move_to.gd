class_name MoveTo extends Command
## Moves a Character from one tile in a grid to another

var target_tile: Tile
var path: Array[Tile] = []


func execuate() -> bool:
	if not target_tile:
		push_error("Target tile is not set")
		return false

	var graph = TileManager.tile_graph
	var current_tile = TileManager.world_to_map(target.position)

	path = GraphAlgos.dijkstra(graph, current_tile, target_tile)
	if path.is_empty():
		push_error("No valid path to the target tile.")

	for tile in path:
		await get_tree().create_timer(0.5).timeout
		target.global_transform.origin = tile.global_position

	command_completed.emit(command_name, target)
	return true


func undo() -> bool:
	return true
