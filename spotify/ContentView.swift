//
//  ContentView.swift
//  spotify
//
//  Created by 1100690 on 2022/11/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
        //always dark mode
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
