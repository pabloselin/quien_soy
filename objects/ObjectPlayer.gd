extends Sprite

# Assigns random sprite
var objects = []

func _ready():
	objects = list_files_in_directory("res://gfx/objects")
	randomize()
	var randomInt = randi() % objects.size()
	var randobject = objects[randomInt]
	var item = load("res://gfx/objects/" + randobject)
	print(str(objects.size()))
	get_node(".").texture = item

func list_files_in_directory(path):
    var files = []
    var dir = Directory.new()
    dir.open(path)
    dir.list_dir_begin()

    while true:
        var file = dir.get_next()
        if file == "":
            break
        elif not file.begins_with(".") and file.ends_with(".png"):
            files.append(file)

    dir.list_dir_end()

    return files