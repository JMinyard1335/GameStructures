class_name Mage extends Character

@export var animations: AnimationPlayer
@export var camera: Camera3D # Assign the camera node to this variable in the editor.

func _ready() -> void:
	animations.play("Idle")

	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT :
				print("Left mouse button at position: %s" % event.position)
				
				# Create a PhysicsRayQueryParameters3D object
				var ray_query = PhysicsRayQueryParameters3D.new()
				
				# Set the ray's origin and direction
				ray_query.from = camera.project_ray_origin(event.position)
				ray_query.to = ray_query.from + camera.project_ray_normal(event.position) * 1000
				
				# Optional: Set collision mask, exclude objects, etc.
				ray_query.set_collision_mask(1)
				ray_query.exclude = [] # Exclude specific objects if necessary
				
				print("Ray origin (from): %s" % ray_query.from)
				print("Ray direction (to): %s" % ray_query.to)

				# Perform the raycast
				var space_state = get_world_3d().direct_space_state
				var result = space_state.intersect_ray(ray_query)
				print(result)
				if result:
					var collision_point = result.position
					var target_tile: Vector3i = TileManager.world_to_map(collision_point)

					var mc = MoveTo.new()
					mc.target = self
					mc.target_tile = TileManager.tile_graph.get_tile(target_tile)
					add_command(mc)
					
					
			MOUSE_BUTTON_RIGHT:
				pass
			MOUSE_BUTTON_RIGHT:
				print("right mouse button at position: %s"%event.position)
			MOUSE_BUTTON_WHEEL_UP :
				print("Scroll wheel up")
			MOUSE_BUTTON_WHEEL_DOWN:
				print("Scroll wheel down")
	pass
