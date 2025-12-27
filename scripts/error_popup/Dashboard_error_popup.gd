extends Popup

onready var animplayer = $AnimationPlayer
onready var yesbutton = $MainBackground/MarginContainer/YesButton

func play_anim(anim):
	animplayer.play(anim)


func _on_YesButton_pressed():
	DemoDashBoardGlobalVariables.dashboard_disabled = false
	self.hide()

func open_popup():
	animplayer.play("fade_in")
	self.popup_centered()
	yesbutton.grab_focus()
