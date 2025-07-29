class_name PitchComponent extends Node3D
## effects the [member Node3D.rotation].x of the node this script is attached too.
##
## NOTE: Not a free pitch component, instead it will rotate between 4 set angles.[br][br]
## Used in creating a gimble along with the [YawComponent]. Takes the current ANGLE and +/- 1
## based on the function called.


#region Constants ------------------------------------------
## The Numerical value of the pitch angles in degrees.
const pitch_angles_deg: Array[float] = [70, 40, 20, 0]
#endregion -------------------------------------------------

#region Enums ----------------------------------------------
## Way to Interact with the desired angle without having to remember the actual numbers
## Allows the angles to be changed without having to worry about changing values everywhere.
enum ANGLES { LOW, MEDIUM, HIGH, TOP }
#endregion -------------------------------------------------

#region Exports --------------------------------------------
@export_group("Pitch Settings")
@export_range(0, 10) var pitch_speed: float = 5 ## How quickly to move between the two angles
@export var starting_angle: ANGLES = ANGLES.MEDIUM ## What [enum PitchComponent.ANGLES] the camera should start at.
#endregion -------------------------------------------------

#region Variables ------------------------------------------
var _current_angle: ANGLES
var _target_angle: ANGLES
var _angles_size: int = ANGLES.size()
var _is_pitching: bool = false

var _current_log = "Current Pitch: %s, %s degrees\n"
var _target_log = "Target Pitch: %s, %s degrees\n"
var _pitch_log = "Is Pitching: %s\n"
#endregion -------------------------------------------------

#region Built-ins ------------------------------------------
func _ready() -> void:
	_current_angle = starting_angle
	_target_angle = _current_angle
	rotation.x = _map_angle(_current_angle)


func _process(delta: float) -> void:
	if _is_pitching:
		var t = _map_angle(_target_angle)
		
		rotation.x = lerp_angle(rotation.x, t, delta * pitch_speed)
		if abs(rotation.x - t) < 0.001:
			rotation.x = t
			_current_angle = _target_angle
			_is_pitching = false
			_debug_component()
	pass


#endregion -------------------------------------------------

#region Pitch Functions ------------------------------------
## When called the current angles value will be incremented by 1
## and be set as the new target value. If the current angle is outside the range of
## [enum PitchComponent.ANGLES], Take the last(ANGLES.size() - 1) value in the ANGLES.
## is_pitching should be set to true on calling this function.
func pitch_up() -> void:
	validate_current_angle()
	var indx = min(int(_current_angle) + 1, _angles_size - 1)
	_target_angle = ANGLES.values()[indx]
	_is_pitching = true
	_debug_component()


## When called the current angles value will be decremented by 1
## and be set as the new target value. If the desired angle outside valid values of
## [enum PitchComponent.ANGLES], Take the first(0) value in ANGLES.
## is_pitching should be set to true on calling this function.	
func pitch_down() -> void:
	validate_current_angle()
	var indx = max(int(_current_angle) - 1, 0)
	_target_angle = ANGLES.values()[indx]
	_is_pitching = true
	_debug_component()


#endregion -------------------------------------------------

#region Helpers
# Gets the numerical angle in radians based on the ANGLES
func _map_angle(a: ANGLES) -> float:
	return deg_to_rad(pitch_angles_deg[int(a)])


func _debug_component() -> void:
	var message = _current_log + _target_log + _pitch_log
	var ca = rad_to_deg(_map_angle(_current_angle))
	var ta = rad_to_deg(_map_angle(_target_angle))
	print(message % [_current_angle, ca, _target_angle, ta, _is_pitching])


func validate_current_angle():
	if _current_angle < 0:
		_current_angle = ANGLES.values()[0]
	elif _current_angle > _angles_size - 1:
		_current_angle = ANGLES.values()[_angles_size - 1]

#endregion
