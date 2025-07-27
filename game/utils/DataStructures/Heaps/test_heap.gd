extends GutTest


class TestMinHeap:
	extends GutTest
	var min_heap: MinHeap = MinHeap.new()
	var percolate_down_params = (
		ParameterFactory
		. named_parameters(
			["heap", "index", "expected"],
			[
				# Test Case 1: Node has no children
				[[Atom.new("root", 10)], 0, [Atom.new("root", 10)]],
				# Test Case 2: Node has one child, and the child is smaller
				[
					[Atom.new("root", 10), Atom.new("left", 5)],
					0,
					[Atom.new("left", 5), Atom.new("root", 10)]
				],
				# Test Case 3: Node has two children, and the left child is smaller
				[
					[Atom.new("root", 10), Atom.new("left", 5), Atom.new("right", 15)],
					0,
					[Atom.new("left", 5), Atom.new("root", 10), Atom.new("right", 15)]
				],
				# Test Case 4: Node has two children, and the right child is smaller
				[
					[Atom.new("root", 10), Atom.new("left", 15), Atom.new("right", 5)],
					0,
					[Atom.new("right", 5), Atom.new("left", 15), Atom.new("root", 10)]
				],
				# Test Case 5: Node satisfies the heap property
				[
					[Atom.new("root", 5), Atom.new("left", 10), Atom.new("right", 15)],
					0,
					[Atom.new("root", 5), Atom.new("left", 10), Atom.new("right", 15)]
				]
			]
		)
	)
	var percolate_up_params = (
		ParameterFactory
		. named_parameters(
			["heap", "index", "expected"],
			[
				# Test Case 1: Node is already in the correct position (no swap needed)
				[
					[Atom.new("root", 5), Atom.new("child", 10)],
					1,
					[Atom.new("root", 5), Atom.new("child", 10)]
				],
				# Test Case 2: Node needs to swap with its parent
				[
					[Atom.new("root", 10), Atom.new("child", 5)],
					1,
					[Atom.new("child", 5), Atom.new("root", 10)]
				],
				# Test Case 3: Node needs to swap multiple times to reach the correct position
				[
					[Atom.new("root", 15), Atom.new("child", 10), Atom.new("grandchild", 5)],
					2,
					[Atom.new("grandchild", 5), Atom.new("child", 10), Atom.new("root", 15)]
				]
			]
		)
	)

	func before_each():
		min_heap.clear()

	func after_all():
		min_heap = null

	func test_percolate_up(p = use_parameters(percolate_up_params)):
		min_heap.heap = p.heap
		min_heap.percolate_up(p.index)
		for i in range(p.expected.size()):
			assert_eq(
				min_heap.heap[i].key, p.expected[i].key, "Heap structure mismatch at index %d" % i
			)

	func test_percolate_down(p = use_parameters(percolate_down_params)):
		min_heap.heap = p.heap
		min_heap.percolate_down(p.index)
		for i in range(p.expected.size()):
			assert_eq(
				min_heap.heap[i].key, p.expected[i].key, "Heap structure mismatch at index %d" % i
			)

	func test_push():
		var data = ["A", "B", "C"]
		var keys = [10, 5, 15]

		for i in range(data.size()):
			min_heap.push(data[i], keys[i])

		assert_eq(min_heap.heap.size(), 3, "Heap size mismatch after push.")
		assert_eq(min_heap.peek(), "B", "Root of the heap should be the smallest key.")

	func test_pop():
		min_heap.push("A", 10)
		min_heap.push("B", 5)
		min_heap.push("C", 15)

		var popped = min_heap.pop()

		assert_eq(popped.data, "B", "Popped element should be the smallest key.")
		assert_eq(min_heap.heap.size(), 2, "Heap size mismatch after pop.")
		assert_eq(min_heap.peek(), "A", "New root of the heap should be the next smallest key.")


class TestMaxHeap:
	extends GutTest
	var max_heap: MaxHeap = MaxHeap.new()

	var percolate_down_params = (
		ParameterFactory
		. named_parameters(
			["heap", "index", "expected"],
			[
				# Test Case 1: Node has no children
				[[Atom.new("root", 10)], 0, [Atom.new("root", 10)]],
				# Test Case 2: Node has one child, and the child is larger
				[
					[Atom.new("root", 10), Atom.new("left", 15)],
					0,
					[Atom.new("left", 15), Atom.new("root", 10)]
				],
				# Test Case 3: Node has two children, and the left child is larger
				[
					[Atom.new("root", 10), Atom.new("left", 15), Atom.new("right", 5)],
					0,
					[Atom.new("left", 15), Atom.new("root", 10), Atom.new("right", 5)]
				],
				# Test Case 4: Node has two children, and the right child is larger
				[
					[Atom.new("root", 10), Atom.new("left", 5), Atom.new("right", 15)],
					0,
					[Atom.new("right", 15), Atom.new("left", 5), Atom.new("root", 10)]
				],
				# Test Case 5: Node satisfies the heap property
				[
					[Atom.new("root", 15), Atom.new("left", 10), Atom.new("right", 5)],
					0,
					[Atom.new("root", 15), Atom.new("left", 10), Atom.new("right", 5)]
				]
			]
		)
	)

	var percolate_up_params = (
		ParameterFactory
		. named_parameters(
			["heap", "index", "expected"],
			[
				# Test Case 1: Node is already in the correct position (no swap needed)
				[
					[Atom.new("root", 15), Atom.new("child", 10)],
					1,
					[Atom.new("root", 15), Atom.new("child", 10)]
				],
				# Test Case 2: Node needs to swap with its parent
				[
					[Atom.new("root", 10), Atom.new("child", 15)],
					1,
					[Atom.new("child", 15), Atom.new("root", 10)]
				],
				# Test Case 3: Node needs to swap multiple times to reach the correct position
				[
					[Atom.new("root", 5), Atom.new("child", 10), Atom.new("grandchild", 15)],
					2,
					[Atom.new("grandchild", 15), Atom.new("child", 10), Atom.new("root", 5)]
				]
			]
		)
	)

	func before_each():
		max_heap.clear()

	func after_all():
		max_heap = null

	func test_percolate_up(p = use_parameters(percolate_up_params)):
		max_heap.heap = p.heap
		max_heap.percolate_up(p.index)
		for i in range(p.expected.size()):
			assert_eq(
				max_heap.heap[i].key, p.expected[i].key, "Heap structure mismatch at index %d" % i
			)

	func test_percolate_down(p = use_parameters(percolate_down_params)):
		max_heap.heap = p.heap
		max_heap.percolate_down(p.index)
		for i in range(p.expected.size()):
			assert_eq(
				max_heap.heap[i].key, p.expected[i].key, "Heap structure mismatch at index %d" % i
			)

	func test_push():
		var data = ["A", "B", "C"]
		var keys = [10, 15, 5]

		for i in range(data.size()):
			max_heap.push(data[i], keys[i])

		assert_eq(max_heap.heap.size(), 3, "Heap size mismatch after push.")
		assert_eq(max_heap.peek(), "B", "Root of the heap should be the largest key.")

	func test_pop():
		max_heap.push("A", 10)
		max_heap.push("B", 15)
		max_heap.push("C", 5)

		var popped = max_heap.pop()

		assert_eq(popped.data, "B", "Popped element should be the largest key.")
		assert_eq(max_heap.heap.size(), 2, "Heap size mismatch after pop.")
		assert_eq(max_heap.peek(), "A", "New root of the heap should be the next largest key.")


class TestHeapUtils:
	extends GutTest
	var min_heap: MinHeap = MinHeap.new()

	func before_each():
		min_heap.clear()

	func after_all():
		min_heap = null

	func test_peek():
		min_heap.push("A", 10)
		min_heap.push("B", 5)
		var root = min_heap.peek()
		assert_eq(root, "B", "Peek should return the smallest key without removing it.")

	func test_has():
		min_heap.push("A", 10)
		min_heap.push("B", 5)
		assert_true(
			min_heap.has("A", 10), "Heap should contain the element with data 'A' and key 10."
		)
		assert_false(
			min_heap.has("C", 15), "Heap should not contain the element with data 'C' and key 15."
		)

	func test_clear():
		min_heap.push("A", 10)
		min_heap.push("B", 5)
		min_heap.clear()
		assert_true(min_heap.is_empty(), "Heap should be empty after clearing.")

	func test_is_empty():
		assert_true(min_heap.is_empty(), "Heap should be empty initially.")
		min_heap.push("A", 10)
		assert_false(min_heap.is_empty(), "Heap should not be empty after adding an element.")
