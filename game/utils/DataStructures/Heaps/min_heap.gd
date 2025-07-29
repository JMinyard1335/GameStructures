class_name MinHeap extends Heap
## Implementation of a min heap.
##
## Always returns the [Atom] with the smallest key.
## if Two [Atom]s have the same key there times are them compared.
## and the one created first gets priority


## Take the node move it up the tree if its key is < its parent.
func percolate_up(index: int) -> void:
	while index > 0:
		@warning_ignore("integer_division")
		var parent = floor((index - 1) / 2)
		if heap[index].key < heap[parent].key:
			Utils.swap_array(heap, index, parent)
		else:
			break


## move it down the tree if its key is > either of its children
func percolate_down(index: int) -> void:
	var lc: int = 2 * index + 1  # left child
	var rc: int = 2 * index + 2  # right child

	while lc < heap.size():
		var s = index

		if heap[lc].key < heap[s].key:
			s = lc
		if rc < heap.size() and heap[rc].key < heap[s].key:
			s = rc
		if s != index:
			Utils.swap_array(heap, index, s)
			index = s
			lc = 2 * index + 1
			rc = 2 * index + 2
		else:
			break
