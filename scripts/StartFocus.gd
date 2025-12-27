extends TabContainer

onready var tab1_startbutton = $home/LeftContainer/GreenButton


func _ready():
	tab1_startbutton.grab_focus()

func _on_TabContainer_tab_selected(tab):
	if tab == 0:
		tab1_startbutton.grab_focus()
	else:
		tab1_startbutton.release_focus()
