extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$transition_fx.interpolate_property($overlay, "progress", 1.0,0.0,2.0, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
	$transition_fx.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
