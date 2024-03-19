extends Node

func apply_camera_shake(index: int, percentage: float):
    var cameras = get_tree().get_nodes_in_group("camera")
    if index < cameras.size():
        var camera = cameras[index]
        camera.apply_shake(percentage)