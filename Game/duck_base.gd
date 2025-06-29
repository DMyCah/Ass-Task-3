extends CharacterBody2D

#Changes the texture on each individual part based on the path for the png given and which part to change
func change_accessory(type, new_accessory_path):
	if type == "Headwear/":
		if new_accessory_path == "clear":
			$Headwear.texture = null
		else:
			$Headwear.texture = load(new_accessory_path)
	elif type == 'Eyewear/':
		if new_accessory_path == "clear":
			$Eyewear.texture = null
		else:
			$Eyewear.texture = load(new_accessory_path)
	elif type == 'Neckwear/':
		if new_accessory_path == "clear":
			$Neckwear.texture = null
		else:
			$Neckwear.texture = load(new_accessory_path)
	elif type == 'Footwear/':
		if new_accessory_path == "clear":
			$Footwear.texture = null
		else:
			$Footwear.texture = load(new_accessory_path)
	elif type == 'Wingwear/':
		if new_accessory_path == "clear":
			$Wingwear.texture = null
		else:
			$Wingwear.texture = load(new_accessory_path)
	elif type == 'FullBodywear/':
		if new_accessory_path == "clear":
			$FullBodywear.texture = null
		else:
			$FullBodywear.texture = load(new_accessory_path)

#change so type takes in the name and then do $type.texture = load(new_accessory_path)
