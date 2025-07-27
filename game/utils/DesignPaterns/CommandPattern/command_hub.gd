extends Node

signal command_changed

var command_queue: MinHeap = MinHeap.new()
var undo_queue: Array[Command] = []
var awaiting_execution: bool = false


func add_command(c : Command) -> void:
	pass


func execuate_next() -> void:
	pass


func undo_last() -> void:
	pass
