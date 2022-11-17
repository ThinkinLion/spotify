//
//  HomeView.swift
//  spotify
//
//  Created by 1100690 on 2022/11/17.
//

import SwiftUI

struct HomeView: View {
    @State var currentType: String = "Popular"
    
    //smooth sliding effect
    @Namespace var animation
    
    @State var albumModels: [AlbumModel] = albums
    @State var headerOffset: (CGFloat, CGFloat) = (0, 0)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                headerView()
                
                //MARK: pinned header
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        songList()
                    } header: {
                        pinnedHeaderView()
                            .background(.black)
                            .offset(y: headerOffset.1 > 0 ? 0 : -headerOffset.1 / 8)
                            .modifier(OffsetModifier(offset: $headerOffset.0, returnFromStart: false))
                            .modifier(OffsetModifier(offset: $headerOffset.1))
                    }
                }
            }
        }
        .overlay(content: {
            Rectangle()
                .fill(.black)
                .frame(height: 50)
                .frame(maxHeight: .infinity, alignment: .top)
                .opacity(headerOffset.0 < 5 ? 1 : 0)
        })
        .coordinateSpace(name: "SCROLL")
        .ignoresSafeArea(.container, edges: .vertical)
//        Color(.systemIndigo)
//            .ignoresSafeArea(.all, edges: .top)
    }
    
    func getIndex(album: AlbumModel) -> Int {
        return albumModels.firstIndex { currentAlbum in
            album.id == currentAlbum.id
        } ?? 0
    }
    
    @ViewBuilder
    func songList() -> some View {
        VStack(spacing: 10) {
            ForEach($albumModels) { $album in
                HStack(spacing: 12) {
                    Text("#\(getIndex(album: album) + 1)")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    Image(album.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 55, height: 55)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(album.name)
                            .fontWeight(.semibold)
                        
                        Label {
                            Text("65,587,909")
                        } icon: {
                            Image(systemName: "beats.headphones")
                                .foregroundColor(.white)
                        }
                        .foregroundColor(.gray)
                        .font(.caption)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        album.isLike.toggle()
                    } label: {
                        Image(systemName: album.isLike ? "suit.heart.fill" : "suit.heart")
                            .font(.title3)
                            .foregroundColor(album.isLike ? .green : .white)
                    }
                    
                    Button {
                        album.isLike.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding()
        .padding(.top, 10)
        .padding(.bottom, 160)
    }
    
    @ViewBuilder
    func pinnedHeaderView() -> some View {
        let types: [String] = ["Popular", "Albums", "Songs", "Fans also like", "About"]
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 25) {
                ForEach(types, id: \.self) { type in
                    VStack(spacing: 12) {
                        Text(type)
                            .fontWeight(.semibold)
                            .foregroundColor(currentType == type ? .white : .gray)
                        
                        ZStack {
                            if currentType == type {
                                RoundedRectangle(cornerRadius: 4, style: .continuous)
                                    .fill(.white)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            } else {
                                RoundedRectangle(cornerRadius: 4, style: .continuous)
                                    .fill(.clear)
                            }
                        }
                        .padding(.horizontal, 8)
                        .frame(height: 4)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            currentType = type
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 25)
            .padding(.bottom, 10)
        }
    }
    
    @ViewBuilder
    func headerView() -> some View {
        GeometryReader { proxy in
//            Color(.systemMint)
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let size = proxy.size
            let height = size.height + minY
            
            Image("album6")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: height > 0 ? height : 0, alignment: .top)
                .overlay(content: {
                    ZStack(alignment: .bottom) {
                        LinearGradient(colors: [.clear, .black.opacity(0.8)],
                                       startPoint: .top, endPoint: .bottom)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("ARTIST")
                                .font(.callout)
                                .foregroundColor(.gray)
                            
                            HStack(alignment: .bottom, spacing: 12) {
                                Text("Red Hot Chili Peppers")
                                    .font(.title.bold())
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.blue)
                                    .background(
                                        Circle()
                                            .fill(.white)
                                            .padding(3)
                                    )
                            }
                            
                            Label {
                                Text("Monthly Listeners")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white.opacity(0.8))
                            } icon: {
                                Text("25,836,700")
                                    .fontWeight(.semibold)
                            }
                            .font(.caption)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                })
                .cornerRadius(15)
                .offset(y:-minY)
        }
        .frame(height: 250)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
