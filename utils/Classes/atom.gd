class_name Atom

var data: Variant # the important info
var key: int # can be used for indexing and sorting
var type: Variant.Type: # Type hint for the item (Might not be needed)
	set(x): type = x as Variant.Type
var time: int # Used as a backup way to sort (milliseconds since engine started.)


func _init(d, k) -> void:
	data = d
	key = k
	type = typeof(d) as Variant.Type
	time = Time.get_ticks_msec()


func print() -> void:
	print("-".repeat(60))
	print("Data: %s"%data)
	print("Key: %s"%key)
	print("Type: %s"%type)
	print("Time: %s"%time)
	
