class_name Mage extends Character

@export var animations: AnimationPlayer
@export var camera: Camera3D # Assign the camera node to this variable in the editor.

func _ready() -> void:
	animations.play("Idle")
	SignalHub.camera_ray_collided.connect(_handle_movement)

	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				pass
			MOUSE_BUTTON_RIGHT:
				pass
			MOUSE_BUTTON_RIGHT:
				print("right mouse button at position: %s"%event.position)
			MOUSE_BUTTON_WHEEL_UP :
				print("Scroll wheel up")
			MOUSE_BUTTON_WHEEL_DOWN:
				print("Scroll wheel down")
	pass


## Takes in a [Vector3] from the cameras raycast.
## Turns this position into a tile and creates a new move command.
func _handle_movement(pos: Vector3):
	pos = TileManager.world_to_map(pos) # reassign world as map coordinates
	var c = MoveToTile.new(self, TileManager.get_tile(pos))
	add_command(c)
