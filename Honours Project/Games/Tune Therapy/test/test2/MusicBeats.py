import librosa
import numpy as np
import csv
from scipy.signal import find_peaks

# Define a function to find the timestamps of the loudest drum beats
def find_loudest_drum_timestamps(y, sr):
    # Calculate the percussive component using Harmonic-Percussive Source Separation
    _, percussive = librosa.effects.hpss(y)
    
    # Compute the STFT (Short-Time Fourier Transform) of the percussive signal
    stft = librosa.stft(percussive, n_fft=2048, hop_length=256)
    
    # Define the frequency bins corresponding to the STFT
    freq_bins = librosa.fft_frequencies(sr=sr, n_fft=2048)

    highest_frequency = max(freq_bins)

    print(highest_frequency)
    # Define the drum frequency range here
    drum_frequency_range = [highest_frequency-6000, highest_frequency]  # Adjust as needed
    
    # Find the indices of the frequency bins within the drum frequency range
    drum_bins_idx = np.where((freq_bins >= drum_frequency_range[0]) & (freq_bins <= drum_frequency_range[1]))[0]
    
    # Calculate RMS energy for the selected drum frequency bins
    rms_energy_drum = np.sqrt(np.mean(np.abs(stft[drum_bins_idx, :]) ** 2, axis=0))
    
    # Find peaks in the RMS energy within the drum frequency range
    peaks, _ = find_peaks(rms_energy_drum, height=np.max(rms_energy_drum) * 0.2)
    
    # Convert peak indices to timestamps
    loudest_drum_timestamps = (peaks * 256) / sr
    
    return loudest_drum_timestamps

# Load the list of songs
with open("..\..\Music\MusicUploads.txt", "r") as f:
    songs = f.read().splitlines()
    songs = [song.rstrip() for song in songs]

for n in songs:
    m = "..\..\Music\{}".format(n)
    y, sr = librosa.load(m)
    
    # Find the timestamps of the loudest drum beats
    loudest_drum_timestamps = find_loudest_drum_timestamps(y, sr)
    
    # Create a text file to save the timestamps
    with open("..\..\Music\{}.txt".format(n), "w") as beats:
        for timestamp in loudest_drum_timestamps:
            beats.write("{}\n".format(timestamp))
    
    # Append the song name to MusicList.txt as before
    with open("..\..\MusicList.txt", "a") as upload:
        upload.write(n + "\n")

# Clear the contents of MusicUploads.txt as before
with open("..\..\Music\MusicUploads.txt", "w") as done:
    done.write("")
