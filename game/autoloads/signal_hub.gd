extends Node

## When the mouse is clicked if the ray on the camera intersects
## with a tile emit a signal with that tiles position. Used by adventures.
signal camera_ray_collided(world_pos: Vector3)

