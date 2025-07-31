class_name Character extends CommandConsumer

@export var animations: AnimationPlayer
var current_tile: Tile = null
var is_walking: bool = false
var is_jumping: bool = false
var is_attacking: bool = false


func _ready() -> void:
	if animations:
		animations.animation_finished.connect(_on_animation_finished)


#region Animations
func _on_animation_finished(anim_name: StringName):
	match anim_name:
		"Walking_A":
			pass
		"Jump_Full_Short":
			stop_jumping_anim()

			
func start_walking_anim():
	if not is_walking and animations:
		is_walking = true
		animations.play("Walking_A")

		
func stop_walking_anim():
	if is_walking and animations:
		is_walking = false
		animations.play("Idle")

		
func start_jumping_anim():
	if not is_jumping and animations:
		is_jumping = true
		animations.play("Jump_Full_Short")

		
func stop_jumping_anim():
	is_jumping = false
	if not is_walking:
		animations.play("Idle")


#endregion



