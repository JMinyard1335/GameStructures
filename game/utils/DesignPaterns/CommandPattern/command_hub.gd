@abstract class_name CommandConsumer extends Node3D


var command_queue: MinHeap = MinHeap.new()
var undo_queue: Array[Command] = []
var awaiting_execution: bool = false

func add_command(c : Command) -> void:
	command_queue.push(c, c.priority)
	add_child(c)
	c.target = self
	execuate_next()

	
func execuate_next() -> void:
	var c: Command = command_queue.pop()
	undo_queue.append(c)
	awaiting_execution = true
	await c.execuate()
	awaiting_execution = false

	
func undo_last() -> void:
	pass
