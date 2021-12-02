//
//  ContentView.swift
//  AudioPlayer
//
//  Created by Luka Zlatarić on 02.12.2021..
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = SongViewModel()
    var body: some View {
        TabView{
            NavigationView{
                PlayerView(viewModel: viewModel)
                    .navigationBarTitle("Playlist")
            }.tabItem({
                Image(systemName: "playpause.fill")
                Text("Playlist")
            })
            NavigationView{
                FavouritesView(viewModel: viewModel)
                    .navigationBarTitle("Favourites")
            }.tabItem({
                Image(systemName: "heart.fill")
                Text("Favourites")
            })
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
