extends StaticBody3D

func _ready() -> void:
	var surftool = SurfaceTool.new()
	surftool.begin(Mesh.PRIMITIVE_TRIANGLES)
	var indices := PackedInt32Array()
	var vertecies := PackedVector3Array()
	
	
	
	for ind in indices:
		surftool.add_index(ind)
	surftool.generate_normals()
	$MeshInstance3D.mesh = surftool.commit()

#####make custom asteriod shape and collision
