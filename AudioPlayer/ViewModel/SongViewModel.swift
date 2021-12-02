//
//  SongViewModel.swift
//  AudioPlayer
//
//  Created by Luka Zlatarić on 02.12.2021..
//

import Foundation
import AVFoundation
import Combine

public class SongViewModel: ObservableObject{
    
    @Published var currentSong: Song = songs[1]
    @Published var allSongs: [Song] = songs
    @Published var favouriteSongs: [Song] = []
    @Published var playing = false
    @Published var start = true
    var cancellable: AnyCancellable? = nil
    var player: AVPlayer?
    
    init(){
        cancellable = $currentSong
            .removeDuplicates()
            .sink(receiveValue: {song in
                if self.playing == true{
                    let playerItem = AVPlayerItem(url: song.url)
                    self.playSong(playerItem: playerItem)
                    self.playing = true
                }
                if self.start == true{
                    let playerItem = AVPlayerItem(url: song.url)
                    self.playSong(playerItem: playerItem)
                    self.playing = true
                    self.stopSong()
                }
            })
    }
    
    
    func playSong(playerItem: AVPlayerItem){
        do {
            try AVAudioSession.sharedInstance().setCategory(.soloAmbient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = AVPlayer(playerItem: playerItem)
            
            guard let player = player else { return }
            player.play()
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopSong(){
        if playing == true{
            player?.pause()
        }else{
            player?.play()
        }
        playing.toggle()
    }
    
    func nextSong(){
        let index = allSongs.firstIndex(of: currentSong)!
        
        if(index == allSongs.count-1){
            let nextIndex = 0
            currentSong = allSongs[nextIndex]
        }
        else{
            let nextIndex = index+1
            currentSong = allSongs[nextIndex]
        }
    }
    
    func previousSong(){
        let index = allSongs.firstIndex(of: currentSong)!
        
        if(index == 0){
            let nextIndex = allSongs.count-1
            currentSong = allSongs[nextIndex]
        }
        else{
            let nextIndex = index-1
            currentSong = allSongs[nextIndex]
        }
    }
    
    func toggleFavourites(song: Song) {
        
        if let index = favouriteSongs.firstIndex(of: song) {
            favouriteSongs.remove(at: index)
        } else {
            favouriteSongs.append(song)
        }
    }
    
    func isFavourite(song: Song) -> Bool {
        if favouriteSongs.contains(song){
            return true
        }else {
            return false
        }
    }
    
}



let songs = [
    Song(name: "Song 1", author: "Lady Gaga", url: URL(string: "https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_5MG.mp3")!),
    Song(name: "Song 2", author: "Macklemore", url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3")!),
    Song(name: "Song 3", author: "Eminem", url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-16.mp3")!),
    Song(name: "Song 4", author: "50 Cent", url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3")!),
    Song(name: "Song 5", author: "Rihanna", url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3")!),
    Song(name: "Song 6", author: "Pink", url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3")!),
    Song(name: "Song 7", author: "Katty Perry", url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3")!),
    Song(name: "Song 8", author: "Skrillex", url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3")!),
]
