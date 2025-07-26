@abstract class_name Heap
## All heap implementations should inherit from heap.
##
## Holds the heap array, and the required functions to implement.[br]
## push, how to add [Atom]s to the heap.[br]
## pop, how should [Atom]s be removed from the heap.[br]
## the following functions are already implemented for use with any Heap.[br]
## peak, returns the data at the root of the heap, returns [Variant][br]
## is_empty, checks to see if the heap is empty, returns [bool][br]
## has, sees if there is a matching Atom with the same data and key, returns [bool][br]
## and the following helper functions to balance the heap structure[br]
## _percolate_up, moves a node from the last position up the heap balancing it.[br]
## _percolate_down, Moves a node from the root down the heap balancing it.

var heap: Array = []

@abstract func push(data: Variant, key: int) -> void;
@abstract func pop() -> Variant;

## Grabs the data at the root or returns null after pushing a warning.
## Runs in O(1), Good if you dont want to change the structure of the heap.
func peek() -> Variant:
	if is_empty():
		push_warning("Heap Structure is trying to peak an empty heap, returning null.")
		return null
	return heap[0].data

## Checks if the heap is empty
## Runs in O(1) great for checks against returning null.
func is_empty() -> bool:
	return heap.is_empty()


## Looks for an atom with the matching data and key.
## Runs in O(N), use sparingly as it is inefficient on large sets. 
func has(data: Variant, key: int) -> bool:
	for a in heap:
		if a.data == data and a.key == key:
			return true
	return false


func _percolate_up() -> void:
	pass


func _percolate_down() -> void:
	pass
