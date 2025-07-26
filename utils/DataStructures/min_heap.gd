class_name MinHeap extends Heap
## Implementation of a min heap.
##
## Always returns the [Atom] with the smallest key.
## if Two [Atom]s have the same key there times are them compared.
## and the one created first gets priority

## Take the node move it up the tree if its key is < its parent.
@warning_ignore("INTEGER_DIVISION")
func percolate_up(index: int) -> void:
	while index > 0:
		var parent = floor((index - 1) / 2)
		if heap[index].key < heap[parent].key:
			pass

# move it down the tree if its key is > either of its children
func percolate_down(index: int) -> void:
	pass
