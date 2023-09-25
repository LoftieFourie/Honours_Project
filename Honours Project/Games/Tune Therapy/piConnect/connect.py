import socket
import keyboard

raspberry_pi_ip = "192.168.0.27"  # Replace with your Raspberry Pi's IP address
port = 8885

client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client_socket.connect((raspberry_pi_ip, port))

while True:
    response = client_socket.recv(1024).decode()
    if not response:
        break
    print("Raspberry Pi sent:", response)
    keyboard.press_and_release(response)

client_socket.close()