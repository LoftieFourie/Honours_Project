import os

# Get the directory of the script
script_dir = os.path.dirname(os.path.abspath(__file__))

# Create a file named "see.txt" and write "test" to it
with open(os.path.join(script_dir, "see.txt"), "w") as see:
    see.write("test")

print("File 'see.txt' created successfully.")
