# Godot 4.5 beta3
## GDScript References
### Built in functions nodes can override.
```gdscript
# Called every time the node enters the scene tree.
func _enter_tree():
	pass

# Called when the node is about to leave the scene tree, after all its
# children received the _exit_tree() callback.
func _exit_tree():
	pass

# Called when both the node and its children have entered the scene tree.
func _ready():
	pass

# Called every frame.
func _process(delta):
	pass

# Called every physics frame.
func _physics_process(delta):
	pass

# Called once for every event.
func _unhandled_input(event):
	pass

# Called once for every event before _unhandled_input(), allowing you to
# consume some events.
func _input(event):
	pass		
```

### Creating a custom itterable object.
```gdscript
class MyRange:
	var _from
	var _to

	func _init(from, to):
		assert(from <= to)
		_from = from
		_to = to

	func _iter_init(iter):
		iter[0] = _from
		return iter[0] < _to

	func _iter_next(iter):
		iter[0] += 1
		return iter[0] < _to

	func _iter_get(iter):
		return iter

func _ready():
	var my_range = MyRange.new(2, 5)
	for x in my_range:
		print(x) # Prints 2, 3, 4.
```

### Abstract Classes.
```gdscript
@abstract class_name Graph
## A graph is a dictionary of objects
##
## The Dictionary is {Vertex : Array[Edges]}

var graph: Dictionary = {} 
var rev_edge_map: Dictionary = {}

@abstract func add_vertex(data: Variant, key: int) -> void
@abstract func remove_vertex(vertex: Vertex) -> void
@abstract func add_edge(vertex_a: Vertex, vertex_b: Vertex, weight: int = 0) -> void
@abstract func remove_edge(edge: Edge) -> void
@abstract func is_adjacent(vertex_a: Vertex, vertex_b: Vertex) -> bool
@abstract func get_neighbors(vertex: Vertex) -> Dictionary;
```

### veradic Arguments
```gdscript
func my_func(a, b = 0, ...args):
    prints(a, b, args)

func _ready():
    my_func(1)             # 1 0 []
	my_func(1, 2)          # 1 2 []
	my_func(1, 2, 3)       # 1 2 [3]
	my_func(1, 2, 3, 4)    # 1 2 [3, 4]
	my_func(1, 2, 3, 4, 5) # 1 2 [3, 4, 5]
```

# GUT Testing Framework
all testing should be done in the gut component style framework. Focus on modified condition and decision coverage also known as mc/dc testing. Always preform 2 way boundary value analysis. used parameterized testing where needed. if there are signals make sure they are connected emitted and disconnected as needed.

## override functions handy for testing
```gdscript
func before_all():
    gut.p("before_all called"

func before_each():
    gut.p("before_each called")

func after_each():
    gut.p("after_each called")

func after_all():
    gut.p("after_all called")
```

## API
|---------|---------------------------------------------------------------------|
| Variant | add_child_autofree(node, legible_unique_name = false)               |
| Variant | add_child_autoqfree(node, legible_unique_name = false)              |
| void    | after_all()                                                         |
| void    | after_each()                                                        |
| void    | assert_accessors(obj, property, default, set_to)                    |
| void    | assert_almost_eq(got, expected, error_interval, text = “”)          |
| void    | assert_almost_ne(got, not_expected, error_interval, text = “”)      |
| void    | assert_between(got, expect_low, expect_high, text = “”)             |
| void    | assert_called(inst, method_name = null, parameters = null)          |
| void    | assert_called_count(callable: Callable, expected_count: int)        |
| void    | assert_connected(p1, p2, p3 = null, p4 = “”)                        |
| void    | assert_does_not_have(obj, element, text = “”)                       |
| void    | assert_eq(got, expected, text = “”)                                 |
| void    | assert_eq_deep(v1, v2)                                              |
| void    | assert_exports(obj, property_name, type)                            |
| void    | assert_false(got, text = “”)                                        |
| void    | assert_file_does_not_exist(file_path)                               |
| void    | assert_file_empty(file_path)                                        |
| void    | assert_file_exists(file_path)                                       |
| void    | assert_file_not_empty(file_path)                                    |
| void    | assert_freed(obj, title = “something”)                              |
| void    | assert_gt(got, expected, text = “”)                                 |
| void    | assert_gte(got, expected, text = “”)                                |
| void    | assert_has(obj, element, text = “”)                                 |
| void    | assert_has_method(obj, method, text = “”)                           |
| void    | assert_has_signal(object, signal_name, text = “”)                   |
| void    | assert_is(object, a_class, text = “”)                               |
| void    | assert_lt(got, expected, text = “”)                                 |
| void    | assert_lte(got, expected, text = “”)                                |
| void    | assert_ne(got, not_expected, text = “”)                             |
| void    | assert_ne_deep(v1, v2)                                              |
| void    | assert_no_new_orphans(text = “”)                                    |
| void    | assert_not_between(got, expect_low, expect_high, text = “”)         |
| void    | assert_not_called(inst, method_name = null, parameters = null)      |
| void    | assert_not_connected(p1, p2, p3 = null, p4 = “”)                    |
| void    | assert_not_freed(obj, title = “something”)                          |
| void    | assert_not_null(got, text = “”)                                     |
| void    | assert_not_same(v1, v2, text = “”)                                  |
| void    | assert_not_typeof(object, type, text = “”)                          |
| void    | assert_null(got, text = “”)                                         |
| void    | assert_property(obj, property_name, default_value, new_value)       |
| void    | assert_same(v1, v2, text = “”)                                      |
| void    | assert_signal_emit_count(p1, p2, p3 = 0, p4 = “”)                   |
| void    | assert_signal_emitted(p1, p2 = “”, p3 = “”)                         |
| void    | assert_signal_emitted_with_parameters(p1, p2, p3 = -1, p4 = -1)     |
| void    | assert_signal_not_emitted(p1, p2 = “”, p3 = “”)                     |
| void    | assert_string_contains(text, search, match_case = true)             |
| void    | assert_string_ends_with(text, search, match_case = true)            |
| void    | assert_string_starts_with(text, search, match_case = true)          |
| void    | assert_true(got, text = “”)                                         |
| void    | assert_typeof(object, type, text = “”)                              |
| Variant | autofree(thing)                                                     |
| Variant | autoqfree(thing)                                                    |
| void    | before_all()                                                        |
| void    | before_each()                                                       |
| Variant | compare_deep(v1, v2, max_differences = null)                        |
| Variant | did_wait_timeout()                                                  |
| Variant | double(thing, double_strat = null, not_used_anymore = null)         |
| void    | fail_test(text)                                                     |
| Variant | get_assert_count()                                                  |
| Variant | get_call_count(object, method_name = null, parameters = null)       |
| Variant | get_call_parameters(object, method_name_or_index = -1, idx = -1)    |
| Variant | get_double_strategy()                                               |
| Variant | get_fail_count()                                                    |
| Variant | get_pass_count()                                                    |
| Variant | get_pending_count()                                                 |
| Variant | get_signal_emit_count(p1, p2 = null)                                |
| Variant | get_signal_parameters(p1, p2 = null, p3 = -1)                       |
| void    | ignore_method_when_doubling(thing, method_name)                     |
| Variant | is_failing()                                                        |
| Variant | is_passing()                                                        |
| Variant | partial_double(thing, double_strat = null, not_used_anymore = null) |
| void    | pass_test(text)                                                     |
| void    | pause_before_teardown()                                             |
| void    | pending(text = “”)                                                  |
| void    | register_inner_classes(base_script)                                 |
| void    | replace_node(base_node, path_or_node, with_this)                    |
| void    | set_double_strategy(double_strategy)                                |
| Variant | should_skip_script()                                                |
| void    | simulate(obj, times, delta, check_is_processing: bool = false)      |
| Variant | skip_if_godot_version_lt(expected)                                  |
| Variant | skip_if_godot_version_ne(expected)                                  |
| Variant | stub(thing, p2 = null, p3 = null)                                   |
| Variant | use_parameters(params)                                              |
| Variant | wait_for_signal(sig: Signal, max_wait, msg = “”)                    |
| Variant | wait_idle_frames(x: int, msg = “”)                                  |
| Variant | wait_physics_frames(x: int, msg = “”)                               |
| Variant | wait_process_frames(x: int, msg = “”)                               |
| Variant | wait_seconds(time, msg = “”)                                        |
| Variant | wait_until(callable, max_wait, p3 = “”, p4 = “”)                    |
| Variant | wait_while(callable, max_wait, p3 = “”, p4 = “”)                    |
| void    | watch_signals(object)                                               |
|---------|---------------------------------------------------------------------|

## Test classes
```gdscript
extends GutTest

class TestSomeAspects extends GutTest:
	func test_assert_eq_number_not_equal():
		assert_eq(1, 2, "Should fail.  1 != 2")

	func test_assert_eq_number_equal():
		assert_eq('asdf', 'asdf', "Should pass")

class TestOtherAspects extends GutTest:
	func test_assert_true_with_true():
		assert_true(true, "Should pass, true is true")
```

## Parameterized test
### generic 
```gdscript
extends GutTest

class Foo:
  func add(p1, p2):
    return p1 + p2

# Define one array, with two arrays as the elements in the array.
# This will cause the test to be called twice.  The first
# call will get [1, 2, 3] as the value of the parameter.
# The second call will get ['a', 'b', 'c']
var foo_params = [[1, 2, 3], ['a', 'b', 'c']]

# This test will add the first two elements in params together,
# using Foo, and assert that they equal the third element in params.
func test_foo(params=use_parameters(foo_params)):
  var foo = Foo.new()
  var result = foo.add(params[0], params[1])
  assert_eq(result, params[2])
```

### named parameters
```gdscript
# With this setup, you can use `params.p1`, `params.p2`, and
# `params.result` in the test below.
var foo_params = ParameterFactory.named_parameters(
    ['p1', 'p2', 'result'], # names
    [                       # values
        [1, 2, 3],
        ['a', 'b', 'c']
    ])

func test_foo(params = use_parameters(foo_params)):
    var foo = Foo.new()
    var result = foo.add(params.p1, params.p2)
    assert_eq(result, params.result)
```


# Custom Data Structures
## Heap
### MinHeap
### MaxHeap
## Graph
### Directed
### UnDirected
## Trees
### Binary Tree
### B-Tree
### Red Black Tree
