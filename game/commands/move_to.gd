class_name MoveToTile extends Command
## Moves a Character from one tile in a grid to another

var target_tile: Vector3i 
var path: Array = []
var pathfinder: Pathfinder
var height_offset: Vector3 = Vector3(0, 1, 0)
var current_path_index: int = 0
var tween: Tween
var character: Character

## Overwrites the .new() call. to take parameters
## you do not have to do this as they default to null so they can be added later.
func _init(parent: Node3D = null, tile: Vector3i = Vector3i.ZERO) -> void:
	command_name = "Move To Tile"
	pathfinder = Pathfinder.new()
	pathfinder.initialize_astar()
	target_tile = tile
	target = parent
	if target is Character:
		print("Target is character")
		character = target


## Main approach - executes movement step by step
func execuate() -> bool:
	# Error checking in development
	assert(target_tile != null, "Target_Tile is null.")
	assert(target != null, "Target is null.")

	path = pathfinder.find_path(TileManager.world_to_map(target.position), target_tile)
	assert(path != null, "Path not found")

	print("Path found with ", path.size(), " steps")
	if character:
		character.start_walking_anim()
	current_path_index = 0
	_move_to_next_tile()

	return true


## Moves to the next tile in the path
func _move_to_next_tile() -> void:
	if current_path_index >= path.size():
		# Reached the end of the path
		_on_movement_completed()
		return
	
	var tile = path[current_path_index]
	var target_position = TileManager.map_to_world(tile) + height_offset
	
	# Calculate direction and rotate the character incrementally
	var direction = (target_position - target.global_position).normalized()
	var target_rotation_y = atan2(direction.x, direction.z)
	var target_rotation = Vector3(
		target.rotation.x,
		target_rotation_y,
		target.rotation.z
		)
	
	if character:
		character.start_walking_anim()
		tween = create_tween()
		tween.tween_property(target, "rotation", target_rotation, 0.2)  # Smooth rotation
	# Create a new tween for each movement
	tween = create_tween()
	tween.tween_property(target, "global_position", target_position, 0.5)
	tween.tween_callback(_on_tile_reached)


## Called when a single tile movement is completed
func _on_tile_reached() -> void:
	current_path_index += 1
	_move_to_next_tile()


## Called when the entire movement is completed
func _on_movement_completed() -> void:
	print("Movement completed!")
	command_completed.emit(command_name, target)
	if character:
		character.stop_walking_anim()


func undo() -> bool:
	return true
