class_name CameraRig extends Node3D
## Manages all the nodes inside the [CameraRig]
##
## The [CameraRig] is the top level of the [Viewport] into the game.
## As such it is an abstraction to all of its child nodes functions.
## This allows functions like [method CameraUtils.shake] to be called by [method CameraRig.shake],
## since only the camera rig will be accessable in the scene tree.

## Used to play a sound effect when the camera rotates or pitches.
@onready var audio: AudioStreamPlayer = $SoundEffect
## Point the camera moves around, also handles zoom.
@onready var pivot: PivotComponent = %CameraPivot
## Used to rotate clockwise and counter clockwise.
@onready var yaw: YawComponent = %CameraYaw
## Used to pitch the camera up and down between 0 degrees and 70 degrees.
@onready var pitch: PitchComponent = %CameraPitch
@onready var camera: Camera3D = %CameraUtils


# Ray Casting
@export var ray_length: float = 1000.0
#region Built-ins ------------------------------------------
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_select"):
		cast_ray(event.position)
		
	if event.is_action_pressed("rotate_left"):
		yaw.rotate_left()
		
	if event.is_action_pressed("rotate_right"):
		yaw.rotate_right()
		
	if event.is_action_pressed("pitch_up"):
		pitch.pitch_up()
		
	if event.is_action_pressed("pitch_down"):
		pitch.pitch_down()
		
	if event.is_action_pressed("zoom_in"):
		pivot.zoom_in()
		
	if event.is_action_pressed("zoom_out"):
		pivot.zoom_out()
	

#endregion -------------------------------------------------

func set_pivot(pos: Vector3):
	pivot.set_pivot(pos)

	
## Used to determine what tile is being clicked based on a ray
## and a Vector2D screen position. if there is a collision
## emit a signal containing the position of the collision
func cast_ray(pos):
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = camera.project_ray_origin(pos)
	ray_query.to = ray_query.from + camera.project_ray_normal(pos) * ray_length
	ray_query.set_collision_mask(1)
	ray_query.exclude = []
	
	print("Camera is casting a ray from %s to %s"%[ray_query.from, ray_query.to])
	var space_state = get_world_3d().direct_space_state
	var res = space_state.intersect_ray(ray_query)
	if res:
		SignalHub.camera_ray_collided.emit(res.position)
