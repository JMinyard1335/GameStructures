class_name YawComponent extends Node3D
## Handles the rotation about the y-axis
## Will Rotate to one of the given POSITIONS

#region Constants ------------------------------------------
const POS_ANGLE_DEG: Array[float] = [
	0.0,  # NORTH
	45.0,  # NEAST
	90.0,  # EAST
	135.0,  # SEAST
	180.0,  # SOUTH
	225.0,  # SWEST
	270.0,  # WEST
	315.0,  # NWEST
]
#endregion -------------------------------------------------

#region Enums ----------------------------------------------
enum POSITIONS { NORTH, NEAST, EAST, SEAST, SOUTH, SWEST, WEST, NWEST }
#endregion -------------------------------------------------

#region Exports --------------------------------------------
@export_group("Rotation Settings")
@export_range(1, 30) var rotation_speed: float = 3
@export var starting_pos: POSITIONS = POSITIONS.NORTH
#endregion -------------------------------------------------

#region Variables ------------------------------------------
var _target_pos: POSITIONS
var _closest_pos: POSITIONS
var _POS_SIZE: int = POS_ANGLE_DEG.size()
var _dir: int = 0
var _is_rotating: bool = false

var rotation_log: String = "Current Rotation.X: %s\n"
var pos_as_rads: String = "POSITION %s in rads: %s\n"
var direction_log: String = "Current _dir: %s\n"
#endregion -------------------------------------------------


#region Built-ins ------------------------------------------
func _ready() -> void:
	_target_pos = starting_pos
	_closest_pos = _target_pos
	rotation.x = _map_angle(_target_pos)
	set_process(false)


func _process(delta: float) -> void:
	if not _is_rotating:
		return

	var current = rotation.y
	var target = _map_angle(_target_pos)
	var step = rotation_speed * delta

	if _dir == 1:
		var dist = fmod(target - current + TAU, TAU)
		if dist <= step:
			rotation.y = target
			_finish_rotation()
		else:
			rotation.y += step
	elif _dir == -1:
		var dist = fmod(current - target + TAU, TAU)
		if dist <= step:
			rotation.y = target
			_finish_rotation()
		else:
			rotation.y -= step


#endregion -------------------------------------------------


#region Rotate Functions -----------------------------------
## Front facing function that starts the rotation process. [br]
## Rotates in a clockwise direction.
func rotate_left() -> void:
	if _target_pos > _POS_SIZE - 1:
		print("target_pos out of bounds setting to %s" % [_POS_SIZE - 1] )
		_target_pos = POSITIONS.values()[_POS_SIZE - 1]
	if _target_pos <= -1:
		print("target_pos out of bounds setting to 0")
		_target_pos = POSITIONS.values()[0]
		
	var idx = wrapi(int(_target_pos) - 1, 0, _POS_SIZE)
	_target_pos = POSITIONS.values()[idx]
	_dir = -1
	_is_rotating = true
	set_process(true)


## Front facing function that starts the rotation process. [br]
## Rotates in a counter-clockwise direction.
func rotate_right() -> void:
	if _target_pos > _POS_SIZE - 1:
		print("target_pos out of bounds setting to %s" % [_POS_SIZE - 1] )
		_target_pos = POSITIONS.values()[_POS_SIZE - 1]
	if _target_pos <= -1:
		print("target_pos out of bounds setting to 0")
		_target_pos = POSITIONS.values()[0]
		
	var idx = wrapi(int(_target_pos) + 1, 0, _POS_SIZE)
	_target_pos = POSITIONS.values()[idx]
	_dir = 1
	_is_rotating = true
	set_process(true)


#endregion -------------------------------------------------


#region Helpers --------------------------------------------
## Returns the POSITIONS as a angle in radians. [br]
## Used to assign the rotation.y to a desired POSITIONS
func _map_angle(p: POSITIONS) -> float:
	return deg_to_rad(POS_ANGLE_DEG[int(p)])


func _finish_rotation() -> void:
	_is_rotating = false
	_dir = 0
	set_process(false)


#endregion -------------------------------------------------
