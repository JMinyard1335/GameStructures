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
				ray_query.to = ray_query.from + camera.project_ray_normal(event.position) * 1000 # Extend the ray far enough
				
				# Optional: Set collision mask, exclude objects, etc.
				ray_query.collision_mask = 0xFFFFFFFF # Adjust collision layers if needed
				ray_query.exclude = [] # Exclude specific objects if necessary
				
				print("Ray origin (from): %s" % ray_query.from)
				print("Ray direction (to): %s" % ray_query.to)
				# Perform the raycast
				var space_state = get_world_3d().direct_space_state
				var result = space_state.intersect_ray(ray_query)
				print(result)
				if not result:
					print('Something is not right')
				if result:
					var collision_point = result.position
					print("Collision point in 3D: %s" % collision_point)
					var target_tile = TileManager.world_to_map(collision_point)
					print("Target tile: %s" % target_tile)
					
					# Create and add a MoveTo command
					var mc = MoveTo.new()
					mc.target_tile = target_tile
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


func _debug_draw_ray(from: Vector3, to: Vector3) -> void:
	var world_debug_draw = get_world_3d().debug_draw
	world_debug_draw.draw_line_3d(from, to, Color(1, 0, 0)) # Draw a red line for the ray
