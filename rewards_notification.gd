extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func display_rewards_earned(currency, food):
	self.visible = true
	$Currency.text = "+ " + str(currency)
	$Food.text = "+ " + str(food)
	await get_tree().create_timer(3).timeout
	self.visible = false
