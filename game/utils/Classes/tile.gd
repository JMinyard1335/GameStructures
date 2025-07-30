class_name Tile
## Represents a tile on the map.
## 
## Holds info related to how a tile should behave.
## Can be stored in a Graph and easily be traversed
## with well known algorithms like Prim's and Dijkstra's.

#region Variables
# Position info 
var position: Vector3i ## Position in the grid
var global_position: Vector3 ## Position in the World
var height: int ## Height in the grid
## What tiles are next to this tile.
var adjacency_list: Dictionary = {} # {position : Tile at position}

# Tile info
var is_walkable: bool = true ## Can this tile be walked on.
var has_treasure: bool = false ## Is there a good bag on the tile.
var is_occupied: bool = false ## Is something occupying this tile.
var character: Node3D = null ## What is on the tile.

# Tile stats
var cost: int ## Cost to move across.
var type ## What type of tile is it.
var has_effect: bool = false ## Is there some type of elemental effect on the tile
var effect = null ## Is there some type of elemental effect on the tile

#endregion

#region Builtin Overloads
func _init(p: Vector3i, t: int):
	position = p
	height = position.y
	type = t

#endregion

#region Adjaceney Helpers
func add_adj(pos: Vector3i, c: int):  
	adjacency_list[pos] = c


func has_adj(pos: Vector3i) -> bool:
	return adjacency_list.has(pos)


func erase_adj(pos: Vector3i) -> void:
	if not has_adj(pos):
		push_warning("Adjacency does not have this position")
		return
	
	adjacency_list.erase(pos)


func get_adj_cost(pos) -> int:
	if not has_adj(pos):
		push_warning("There is no link between tiles.")
		return -1
	
	return adjacency_list[pos]

#endregion

#region Debugging
func print() -> void:
	print("-".repeat(60))
	print("Position: %s"%position)
	print("World Position: %s"%global_position)
	print("Height: %s"%height)
	print("Type: %s"%type)
	print("is_occupied: %s"%is_occupied)
	if character:
		print("Character: %s"%character)
	print("is_walkable %s"%is_walkable)
	print("Has treasure %s"%has_treasure)

#endregion
