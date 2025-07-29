class_name Mage extends CommandConsumer

@export var animations: AnimationPlayer

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT :
				print("Left mouse button at position: %s"%event.position)
			MOUSE_BUTTON_RIGHT:
				print("right mouse button at position: %s"%event.position)
			MOUSE_BUTTON_WHEEL_UP :
				print("Scroll wheel up")
			MOUSE_BUTTON_WHEEL_DOWN:
				print("Scroll wheel down")


func add_command(c : Command) -> void:
	pass

func execuate_next() -> void:
	pass

func undo_last() -> void:
	pass
