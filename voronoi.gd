extends Node2D
onready var tf1 = get_node('TextureFrame1')

export var imgx = 400
export var imgy = 200

func voronoi():
	var image = Image(imgx, imgy, false, 3)
	var n = rand_range(50, 100) # of cells
	var nx = []
	var ny = []
	var nr = []
	var ng = []
	var nb = []
	for i in range(n):
		nx.append(rand_range(0, imgx - 1))
		ny.append(rand_range(0, imgy - 1))
		nr.append(rand_range(0, 255))
		ng.append(rand_range(0, 255))
		nb.append(rand_range(0, 255))
	
	for y in range(imgy):
		for x in range(imgx):
			var dmin = sqrt(pow(imgx - 1, 2) + pow(imgy - 1, 2))
			var j = -1
			for i in range(n):
				var d = sqrt(pow(nx[i] - x, 2) + pow(ny[i] - y, 2))
				if d < dmin:
					dmin = d 
					j = i 
				image.put_pixel(x, y, Color(nr[j], ng[j], nb[j]))

	for i in range(n):	
		image.put_pixel(nx[i], ny[i], Color(255 - nr[i], 255 - ng[i], 255 - nb[i]))

	#image.save_png('voronoi.png')
	var imagetexture = ImageTexture.new()
	imagetexture.create_from_image(image)
	return imagetexture



func _ready():
	randomize()
	tf1.set_texture(voronoi())
	
func _on_Button_pressed():
	tf1.set_texture(voronoi())