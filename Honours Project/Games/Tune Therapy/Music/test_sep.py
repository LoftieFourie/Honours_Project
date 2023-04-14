import librosa
import librosa.display
import matplotlib.pyplot as plt
import numpy as math

audio_file = 'Sweetheart.mp3'
y, sr = librosa.load(audio_file, sr=None)

D = librosa.stft(y)
S, phase = librosa.magphase(D)

plt.figure(figsize=(10, 4))
librosa.display.specshow(librosa.amplitude_to_db(S, ref=math.max), y_axis='linear', x_axis='time')
plt.colorbar(format='%+2.0f dB')
plt.title('Spectrogram')
plt.tight_layout()
plt.show()
