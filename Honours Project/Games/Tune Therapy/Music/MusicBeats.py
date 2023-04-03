import librosa
import csv

with open(".\MusicUploads.txt","r") as f:
    songs = f.read().splitlines()
    songs = [song.rstrip() for song in songs]

for n in songs:
    y, sr = librosa.load(n)
    tempo, beat_frames = librosa.beat.beat_track(y=y, sr=sr)
    print('Estimated tempo: {:.2f} beats per minute'.format(tempo))
    beat_times = librosa.frames_to_time(beat_frames, sr=sr)
    CreateFile = open("{}.csv".format(n),"x",newline='\n')
    for i in beat_times:
        beats = open("{}.csv".format(n),"a")
        writer = csv.writer(beats, delimiter='\n')
        value = [str(i)]
        writer.writerow(value)
    upload = open ("..\MusicList.txt", "a")
    upload.write(n+"\n")
    
done = open("MusicUploads.txt","w")
done.write("")