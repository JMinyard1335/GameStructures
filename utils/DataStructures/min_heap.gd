class_name MinHeap extends Heap
## Implementation of a min heap.
##
## Always returns the [Atom] with the smallest key.
## if Two [Atom]s have the same key there times are them compared.
## and the one created first gets priority

# Take the node move it up the tree if its key is < its parent.
func _percolate_up(index: int) -> void:
	pass

# move it down the tree if its key is > either of its children
func _percolate_down(index: int) -> void:
	pass
