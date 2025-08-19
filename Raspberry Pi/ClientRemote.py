#!/usr/bin/python3
import socket
import RPi.GPIO as GPIO
import time

channel = 17
GPIO.setmode(GPIO.BCM)
GPIO.setup(channel, GPIO.IN)

# Set the server's IP address and port
server_ip = "192.168.4.1"
server_port = 8880

# Create a socket object
client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

def callback(chan):
    if GPIO.input(chan):
        print("Sound detected")
        keystroke = "1" 
        client_socket.send(keystroke.encode())
    else:
        print("Sound detected")
        keystroke = "1"
        client_socket.send(keystroke.encode())

try:
    # Connect to the server
    client_socket.connect((server_ip, server_port))
    print("Connected to the server")

    # You can send more data here if needed
    GPIO.add_event_detect(channel, GPIO.BOTH, bouncetime=300)
    GPIO.add_event_callback(channel, callback)
    
except Exception as e:
    print(f"Error: {str(e)}")


    
try:
    while True:
        time.sleep(0.1)
except KeyboardInterrupt:
    print("Exiting...")

client_socket.close()


