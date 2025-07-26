@abstract class_name Heap


var heap: Array[Atom] = []


@abstract func push(data: Variant, key: int) -> void;
@abstract func pop() -> Variant;
@abstract func peek() -> Variant;

func is_empty() -> bool:
	return heap.is_empty()


func has(data: Variant, key: int) -> bool:
	for a in heap:
		if a.data == data and a.key == key:
			return true
	return false
