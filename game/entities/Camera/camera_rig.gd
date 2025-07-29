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


#region Built-ins ------------------------------------------
func _input(event: InputEvent) -> void:
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


#region Camera Effects -------------------------------------
func set_pivot(pos: Vector3):
	pivot.set_pivot(pos)
#endregion -------------------------------------------------
