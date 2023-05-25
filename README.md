# Honors_Project


## Introduction

Welcome to the repository for my Honors project. This project encompasses the research, development, and implementation of a serious game for dementia care that incorporates preferred music and music therapy. The main objective of the project is to create an interactive game environment where dementia patients can upload their own songs and actively engage with the music using a custom-built controller developed using Raspberry Pi. The game itself is built using the Godot game engine, while the signal processing and analysis of preferred music files are performed using Python and the Librosa library.

## Project Description

The Honors project aims to explore the potential benefits of using preferred music and music therapy in dementia care. The project is divided into the following components:

1. Research and Literature Review: A comprehensive review of existing studies and literature on the impact of music on dementia patients, including the effects of preferred music and music therapy.

2. Design and Development: The design and development phase involves creating the game environment using the Godot game engine. The game will allow patients to upload their own music, interact with the music through the custom controller, and engage in various activities designed to stimulate memory, cognition, and emotional well-being.

3. Custom Controller: A key aspect of the project is the development of a custom controller using Raspberry Pi. This controller will enable patients to clap along with the beat of the music, providing a tangible and interactive experience.

4. Signal Processing: Preferred music files uploaded by patients will undergo signal processing using Python and the Librosa library. This process will dissect the audio files, extract relevant features, and interpret the signals to provide real-time feedback and adapt the game environment to the patient's preferences.

## Repository Structure

The repository is organized as follows:

- `documentation/`: Contains documentation related to the project, including research papers, articles, and project proposal.
- `games/`: Contains the Godot project files for the game development as well as training.
- `games/Tune Theraphy`: The main game for the project, also containing all python scripts for music disection.
- `raspberry-pi/`: Holds the code and resources for the custom Raspberry Pi controller.
- `resources/`: Contains any additional resources, as well as preperation used for the project.
- `README.md`: The main README file providing an overview of the project.

## Installation and Setup

To set up and run the Honors project locally, follow the instructions below:

### Prerequisites

- Godot game engine (version X.X.X)
- Python (version X.X.X)
- Raspberry Pi with necessary peripherals

### Clone the Repository

```
git clone https://github.com/LoftieFourie/Honors_Project.git
cd Honors_Project
```

### Game Development (Godot)

1. Open the Godot game engine.
2. Import the project by selecting the `godot/` folder.
3. Configure any necessary settings, such as display resolution or input controls.
4. Build and run the game within the Godot editor or export it to the desired platform.

### Signal Processing (Python)

1. Install the required Python dependencies:

```
pip install librosa
```

2. Use the Python scripts within the `python-scripts/` folder to process and analyze preferred music files. Refer to the documentation for specific instructions on using the scripts.

### Custom Controller (Raspberry Pi)

1. Set up your Raspberry Pi with the necessary peripherals, such as a display, speakers, and the custom-built controller.
2. Copy the code and resources from the `raspberry-pi/` folder to your Raspberry Pi.
3. Configure any required settings in the code, such as GPIO pin assignments or audio output.
4. Run

 the controller program on your Raspberry Pi.

## Usage

- Game Environment: Launch the game and follow the instructions to upload preferred music files and interact with the game activities using the custom controller.
- Signal Processing: Use the provided Python scripts to process and analyze preferred music files, ensuring they are compatible with the game environment.
- Custom Controller: Connect the custom-built Raspberry Pi controller and follow the instructions to synchronize it with the game for a truly interactive experience.

## Contributing

This project is a personal Honors project, and contributions are not currently open to the public. However, feedback and suggestions are always welcome.

## License

The Honors project is licensed under the [MIT License](LICENSE).

## Acknowledgements

I would like to express my gratitude to the following:

- [Godot game engine](https://godotengine.org/)
- [Python](https://www.python.org/)
- [Raspberry Pi Foundation](https://www.raspberrypi.org/)
- [Librosa library](https://librosa.org/)

## Contact

For any inquiries or support, please contact the project creator:

- Creator: Loftie Fourie
- Email: Loftiefourie01@gmail.com

Feel free to reach out for any questions or discussions related to the project.

---

Thank you for your interest in my Honors project! I hope that this project contributes to the field of dementia care and brings joy and therapeutic benefits to the patients.
