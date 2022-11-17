//
//  AlbumModel.swift
//  spotify
//
//  Created by 1100690 on 2022/11/17.
//

import SwiftUI

struct AlbumModel: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let image: String
    var isLike: Bool = false
}

var albums: [AlbumModel] = [
    AlbumModel(name: "Californication", image: "album1", isLike: true),
    AlbumModel(name: "By The Way", image: "album2", isLike: false),
    AlbumModel(name: "Stadium Arcadium", image: "album3", isLike: true),
    AlbumModel(name: "Blood Shgar Sex Magik", image: "album4", isLike: true),
    AlbumModel(name: "Unlimited Love", image: "album5", isLike: false),
    AlbumModel(name: "The Gateway", image: "album6", isLike: false),
    AlbumModel(name: "Return of the Dream Canteen", image: "album7", isLike: false),
    
    AlbumModel(name: "Stadium Arcadium", image: "album3", isLike: true),
    AlbumModel(name: "Blood Shgar Sex Magik", image: "album4", isLike: true),
    AlbumModel(name: "Unlimited Love", image: "album5", isLike: false),
    AlbumModel(name: "The Gateway", image: "album6", isLike: false),
]
