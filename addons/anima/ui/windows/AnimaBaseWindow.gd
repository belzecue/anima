tool
extends WindowDialog

var _anima: AnimaNode

func _init() -> void:
	_anima = Anima.begin(self)
	_anima.then(
		Anima.Node(self) \
			.anima_animation("zoomInUp") \
			.anima_duration(0.3)
	)
	_anima.set_visibility_strategy(Anima.VISIBILITY.TRANSPARENT_ONLY, true)

func _ready():
	if not is_connected("popup_hide", self, "_on_hide"):
		connect("popup_hide", self, "_on_hide")

func popup_centered(size := Vector2.ZERO) -> void:
	# We need to reset the scale otherwise the window position will be wrong!
	rect_scale = Vector2(1, 1)

	.popup_centered(rect_size)
	_anima.play()

	_on_popup_visible()

func _on_popup_visible() -> void:
	pass

func _on_hide() -> void:
	show()

	_anima.play_backwards_with_speed(1.5)

	yield(_anima, 'animation_completed')

	hide()
