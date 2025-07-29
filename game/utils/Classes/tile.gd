class_name Tile
## Represents a tile on the map.
## 
## Holds info related to how a tile should behave.
## Can be stored in a Graph and easily be traversed
## with well known algorithms like Prim's and Dijkstra's.

# Position info 
var position: Vector3i ## Position in the grid
var global_position: Vector3 ## Position in the World
var height: int ## Height in the grid

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


func _init(p: Vector3i, gp: Vector3, t):
	position = p
	global_position = gp
	height = position.y
	type = t
