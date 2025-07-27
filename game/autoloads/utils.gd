extends Node


## Takes in an array and two indices and swaps them if they are of the same type within the array.
func swap_array(array: Array, i: int, j: int):
	var t = array[i]
	array[i] = array[j]
	array[j] = t
