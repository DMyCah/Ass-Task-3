extends Control

#Display rewards earned in the bottom left corner
func display_rewards_earned(currency, food):
	self.visible = true
	$Currency.text = "+ " + str(currency)
	$Food.text = "+ " + str(food)
	await get_tree().create_timer(3).timeout
	self.visible = false
