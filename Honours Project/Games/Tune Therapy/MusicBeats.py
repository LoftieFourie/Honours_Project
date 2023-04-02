# Beat tracking example
import librosa

# 1. Get the file path to an included audio example
names = open("MusicUploads.txt","r")
for n in names:
    y, sr = librosa.load(n)
    tempo, beat_frames = librosa.beat.beat_track(y=y, sr=sr)
    print('Estimated tempo: {:.2f} beats per minute'.format(tempo))
# 4. Convert the frame indices of beat events into timestamps
    beat_times = librosa.frames_to_time(beat_frames, sr=sr)
    print(beat_times)