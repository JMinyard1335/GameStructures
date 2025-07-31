class_name Mage extends Character

@export var camera: Camera3D # Assign the camera node to this variable in the editor.

func _ready() -> void:
	animations.play("Idle")
	SignalHub.camera_ray_collided.connect(_handle_movement)


## Takes in a [Vector3] from the cameras raycast.
## Turns this position into a tile and creates a new move command.
func _handle_movement(pos: Vector3):
	pos = TileManager.world_to_map(pos) # reassign world as map coordinates
	var c = MoveToTile.new(self, pos)
	add_command(c)
