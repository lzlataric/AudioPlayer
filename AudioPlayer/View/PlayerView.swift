//
//  PlayerView.swift
//  AudioPlayer
//
//  Created by Luka Zlatarić on 02.12.2021..
//

import SwiftUI

struct PlayerView: View {
    
    @ObservedObject var viewModel: SongViewModel
    
    var body: some View {
        VStack{
            VStack{
                ScrollView{
                    ForEach(viewModel.allSongs, id: \.self) { song in
                        HStack{
                            if viewModel.currentSong == song{
                                Image(systemName: "play.fill")
                                    .font(.system(size: 15))
                                    .padding(.leading, 20)
                            }else{
                                Image(systemName: "play.fill")
                                    .font(.system(size: 15))
                                    .padding(.leading, 20)
                                    .foregroundColor(Color.white)
                            }
                            Text(song.name)
                                .frame(width: 90)
                            Text(song.author)
                                .frame(width: 160, alignment: .leading)
                            
                            if viewModel.isFavourite(song: song) == true{
                                Image(systemName: "heart.fill")
                                    .foregroundColor(Color.red)
                            }else{
                                Image(systemName: "heart")
                            }
                            
                            
                            
                        }
                        .frame(width: 350, height: 50, alignment: .leading)
                        .border(Color.black)
                        .onTapGesture{
                            viewModel.playing = true
                            viewModel.currentSong = song
                        }
                        .onLongPressGesture{
                            //TODO: Favourites
                            viewModel.toggleFavourites(song: song)
                        }
                    }
                }
                .frame(height: 500)
            }
            .padding(.top, 50)
            Spacer()
            HStack(spacing: 20){
                Image(systemName: "backward.fill")
                    .font(.system(size: 30))
                    .onTapGesture{
                        viewModel.previousSong()
                    }
                
                if viewModel.playing == true{
                    Image(systemName: "pause.fill")
                        .font(.system(size: 30))
                        .onTapGesture{
                            viewModel.stopSong()
                        }
                }
                else{
                    Image(systemName: "play.fill")
                        .font(.system(size: 30))
                        .onTapGesture{
                            viewModel.stopSong()
                        }
                }
                
                Image(systemName: "forward.fill")
                    .font(.system(size: 30))
                    .onTapGesture{
                        viewModel.nextSong()
                    }
            }
            .padding(.bottom, 50)
        }
        .onAppear{
            viewModel.currentSong = viewModel.allSongs[0]
            viewModel.start = false
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(viewModel: SongViewModel())
    }
}
