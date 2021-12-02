//
//  Song.swift
//  AudioPlayer
//
//  Created by Luka Zlatarić on 02.12.2021..
//

import Foundation

struct Song: Equatable, Hashable {
    var name: String
    var author: String
    var url: URL
}
