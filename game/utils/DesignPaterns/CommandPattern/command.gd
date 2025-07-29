@abstract class_name Command extends Node
## An Abstract calls of what needs to be implemented in each command script.
##
## The Signal should be executed when a command is finished.
## The Command Manager Uses a MinHeap so think of priority more as tickets.
## all commands with priority 1 go first 2 second so on and so forth.
## this is fine however if some command is set to high it might never go if
## other nodes keep getting added with lower priority.

signal command_completed(s: String, n: Node3D)

var command_name: String = "command": # What is the name of the command
	set(x): name = x.to_lower()
var target: Node3D # Node Being controlled
var priority: int = 3 # when should the command go in the queue

@abstract func execuate() -> bool
@abstract func undo() -> bool
