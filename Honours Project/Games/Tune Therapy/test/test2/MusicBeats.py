import librosa
import csv


with open("..\..\Music\MusicUploads.txt","r") as f:
    songs = f.read().splitlines()
    songs = [song.rstrip() for song in songs]

for n in songs:
    m = "..\..\Music\{}".format(n)
    y, sr = librosa.load(m)
    tempo, beat_frames = librosa.beat.beat_track(y=y, sr=sr)
    print('Estimated tempo: {:.2f} beats per minute'.format(tempo))
    beat_times = librosa.frames_to_time(beat_frames, sr=sr)
    CreateFile = open("..\..\Music\{}.csv".format(n),"x",newline='\n')
    for i in beat_times:
        beats = open("..\..\Music\{}.csv".format(n),"a")
        writer = csv.writer(beats, delimiter='\n')
        value = [str(i)]
        writer.writerow(value)
    upload = open ("..\..\MusicList.txt", "a")
    upload.write(n+"\n")
    
done = open("..\..\Music\MusicUploads.txt","w")
done.write("")