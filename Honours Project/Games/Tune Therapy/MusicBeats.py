import librosa
import numpy as np
import csv
from scipy.signal import find_peaks
import logging
import os

# Get the directory of the script
script_dir = os.path.dirname(os.path.abspath(__file__))

# Configure the logging settings
log_file_path = os.path.join(script_dir, 'script_log.log')
logging.basicConfig(filename=log_file_path, level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')


logging.basicConfig(filename='script_log.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def find_loudest_drum_timestamps(counter, y, sr, drum_frequency_range=None):
    counter = counter + 1
    # Calculate the percussive component using Harmonic-Percussive Source Separation
    _, percussive = librosa.effects.hpss(y)

    # Compute the STFT (Short-Time Fourier Transform) of the percussive signal
    stft = librosa.stft(percussive, n_fft=2048, hop_length=256)

    # Define the frequency bins corresponding to the STFT
    freq_bins = librosa.fft_frequencies(sr=sr, n_fft=2048)


    if drum_frequency_range is None:
        drum_frequency_range = [1500, 5000]

    # Find the indices of the frequency bins within the drum frequency range
    drum_bins_idx = np.where((freq_bins >= drum_frequency_range[0]) & (freq_bins <= drum_frequency_range[1]))[0]

    # Calculate RMS energy for the selected drum frequency bins
    rms_energy_drum = np.sqrt(np.mean(np.abs(stft[drum_bins_idx, :]) ** 2, axis=0))

    # Find peaks in the RMS energy within the drum frequency range
    peaks, _ = find_peaks(rms_energy_drum, height=np.max(rms_energy_drum) * 0.2)

    # Convert peak indices to timestamps
    loudest_drum_timestamps = (peaks * 256) / sr

    # Check the number of timestamps
    num_timestamps = len(loudest_drum_timestamps)

    if counter < 7:
        if num_timestamps < 150:
            # Increase the lower frequency bound
            drum_frequency_range[1] += 500
        elif num_timestamps > 200:
            # Decrease the lower frequency bound
            drum_frequency_range[0] += 500
    else:
        return loudest_drum_timestamps

    print(num_timestamps)
    print(drum_frequency_range)
    logging.info(f"Counter: {counter}")
    logging.info(f"Number of timestamps: {num_timestamps}")
    logging.info(f"Drum frequency range: {drum_frequency_range}")
    
    # Recursively call the function with the adjusted lower bound
    if num_timestamps < 150 or num_timestamps > 250:
        return find_loudest_drum_timestamps(counter, y, sr, drum_frequency_range)
    else:
        return loudest_drum_timestamps

counter = 0

with open(os.path.join(script_dir, "..", "..", "Music", "MusicUploads.txt"), "r") as f:
    songs = f.read().splitlines()
    songs = [song.rstrip() for song in songs]

logging.info("Script started.")

for n in songs:
    m = os.path.join(script_dir, "..", "..", "Music", n)
    y, sr = librosa.load(m)
    
    # Find the timestamps of the loudest drum beats
    loudest_drum_timestamps = find_loudest_drum_timestamps(counter, y, sr)
    
    # Create a text file to save the timestamps
    output_file_path = os.path.join(script_dir, "..", "..", "Music", f"{n}.txt")
    with open(output_file_path, "w") as beats:
        for timestamp in loudest_drum_timestamps:
            beats.write(f"{timestamp}\n")
    
    # Append the song name to MusicList.txt as before
    with open(os.path.join(script_dir, "..", "..", "MusicList.txt"), "a") as upload:
        upload.write(f"{n}\n")

# Clear the contents of MusicUploads.txt as before
with open(os.path.join(script_dir, "..", "..", "Music", "MusicUploads.txt"), "w") as done:
    done.write("")

logging.info("Script finished.")

with open(os.path.join(script_dir, "see.txt"), "w") as see:
    see.write("test")
    for n in songs:
        see.write(f"{n}\n")

