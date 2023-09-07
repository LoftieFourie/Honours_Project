import librosa
import csv


with open("..\..\Music\MusicUploads.txt","r") as f:
    songs = f.read().splitlines()
    songs = [song.rstrip() for song in songs]

for n in songs:
    m = "..\..\Music\{}".format(n)
    y, sr = librosa.load(m)
    tempo, beat_frames = librosa.beat.beat_track(y=y, sr=sr) 
    #audio_segments = librosa.effects.split(y, beat_frames)
    #onset_envs = [librosa.onset.onset_strength(y=y, sr=sr) for y in audio_segments]
    #onsets = [librosa.onset.onset_detect(onset_envelope=o, sr=sr) for o in onset_envs]
    #audio_frames = [librosa.util.frame(y=y, frame_length=2048, hop_length=512) for y in audio_segments]
    #spectral_contrasts = [librosa.feature.spectral_contrast(S=librosa.stft(y), sr=sr) for y in audio_frames] 
    
    print('Estimated tempo: {:.2f} beats per minute'.format(tempo))
    beat_times = librosa.frames_to_time(beat_frames, sr=sr)
    CreateFile = open("..\..\Music\{}.txt".format(n),"x",newline='\n')
    for i in beat_times:
        beats = open("..\..\Music\{}.txt".format(n),"a")
        writer = csv.writer(beats, delimiter='\n')
        value = [str(i)]
        writer.writerow(value)
    upload = open ("..\..\MusicList.txt", "a")
    upload.write(n+"\n")
    
done = open("..\..\Music\MusicUploads.txt","w")
done.write("")