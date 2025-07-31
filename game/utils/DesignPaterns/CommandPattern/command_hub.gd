@abstract class_name CommandConsumer extends Node3D


var command_queue: MinHeap = MinHeap.new()
var undo_queue: Array = []
var awaiting_execution: bool = false

func add_command(c : Command) -> void:
	command_queue.push(c, c.priority)
	add_child(c)
	c.target = self
	c.print()
	self.execuate_next()

	
func execuate_next() -> void:
	if awaiting_execution or command_queue.size() == 0:
		return
	
	awaiting_execution = true
	var c: Command = command_queue.peek() as Command
	c.print()
	@warning_ignore("redundant_await")
	await c.execuate()
	print("execution Complete")
	awaiting_execution = false
	undo_queue.append( command_queue.pop())


	
func undo_last() -> void:
	pass
