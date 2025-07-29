class_name PivotComponent extends Node3D
## The point to rotate around. Handles zoom.
##
## This node acts as a pivot point for things to rotate about.
## The zoom is clamped between a min and a max value.
## This keeps from being able to zoom through the map
## or so far out that you can no longer see the map.
## Zoom is handled by adjusting the scale of the node.

#region Exports --------------------------------------------
@export_group("Pivot Settings")
@export var pivot_point: Vector3 = Vector3.ZERO

@export_group("Zoom Settings")
@export_range(0.1, 1) var min_zoom: float = 0.3
@export_range(1, 2) var max_zoom: float = 1
@export_range(1, 20) var zoom_amount: float = 0.5
@export_range(0, 10) var zoom_smoothing: float = 1
#endregion -------------------------------------------------

var _target: float = 1
var _zoom: float = 1
var _is_zooming: bool = false


#region Built-ins ------------------------------------------
func _process(delta: float) -> void:
	if _is_zooming:
		_zoom = lerp(_zoom, _target, delta * zoom_smoothing)

		var new_scale = max(_zoom, 0.01)
		scale = new_scale * Vector3.ONE
	position = pivot_point

#endregion -------------------------------------------------


#region Zoom Functions -------------------------------------
func zoom_in() -> void:
	_target -= zoom_amount
	_target = clamp(_target, min_zoom, max_zoom)
	_is_zooming = true


func zoom_out() -> void:
	_target += zoom_amount
	_target = clamp(_target, min_zoom, max_zoom)
	_is_zooming = true


#endregion -------------------------------------------------


## Front facing function used to change the point the camera pivots around. [br]
## [param p] - [Vector3] the point in the world the camera operates about.
func set_pivot(p: Vector3) -> void:
	pivot_point = p
