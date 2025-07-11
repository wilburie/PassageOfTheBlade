extends TextEdit

func _ready() -> void:
	NetworkInterface.connection_established.connect(_on_connection_established)

func _on_connection_established():
	text = "Connection Established!"
