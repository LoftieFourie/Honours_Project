import sys
from cx_Freeze import setup, Executable

# Replace 'your_script.py' with the name of your Python script
script_name = 'MusicBeats.py'

base = None
if sys.platform == 'win32':
    base = 'Win32GUI'  

# Include any additional packages/modules your script requires
includes = ['numpy', 'librosa', 'scipy', 'logging', 'audioread', 'soundfile']
excludes = []
packages = []

executables = [
    Executable(script_name, base=base)
]

setup(
    name='MusicBeats',  # Replace with your script's name
    version='1.0',
    description='gets timestamps of mp3 files',
    executables=executables,
    options={
        'build_exe': {
            'includes': includes,
            'excludes': excludes,
            'packages': packages,
        }
    }
)
