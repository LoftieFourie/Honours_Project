import RPi.GPIO as GPIO
import time
import socket
import threading

channel = 17
GPIO.setmode(GPIO.BCM)
GPIO.setup(channel, GPIO.IN)

def callback(chan):
    if GPIO.input(chan):
        print("Sound detected")
        keystroke = " "
        for client_socket in client_sockets:
            client_socket.send(keystroke.encode())
    else:
        print("Sound detected")
        keystroke = " "
        for client in client_sockets:
            client.send(keystroke.encode())
            
def handle_client(client_socket):
    print("Connected to:", client_socket.getpeername())
    try:
        while True:
            data = client_socket.recv(1024)
            if not data:
                break
            received_data = data.decode()
            for client in client_sockets:# Decode the received data
                client.send(received_data.encode())
                print("received data:" + received_data)
            # Handle incoming data from the client if needed
    except Exception as e:
        print(f"Error: {str(e)}")
    finally:
        client_socket.close()
        client_sockets.remove(client_socket)

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind(("0.0.0.0", 8885))  # Use any available port
server_socket.listen(5)  # Listen for up to 5 client connections

client_sockets = []

print("Waiting for connections...")

GPIO.add_event_detect(channel, GPIO.BOTH, bouncetime=300)
GPIO.add_event_callback(channel, callback)

try:
    while True:
        time.sleep(0.1)
        client_socket, client_address = server_socket.accept()
        client_sockets.append(client_socket)
        client_thread = threading.Thread(target=handle_client, args=(client_socket,))
        client_thread.start()
except KeyboardInterrupt:
    print("Exiting...")

for client_socket in client_sockets:
    client_socket.close()

server_socket.close()

