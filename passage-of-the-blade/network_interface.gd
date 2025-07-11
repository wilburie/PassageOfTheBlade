extends Node

signal connection_established

func host():
	PackRTC.host()

func join(code = "TEST"):
	PackRTC.join(code)
