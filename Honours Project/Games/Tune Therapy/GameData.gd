extends Node

var players = []
var scene
const port = 8880
var ip = "192.168.4.1"
var connection 

func _ready():
	connection = StreamPeerTCP.new()
	connection.connect_to_host( ip,port )
