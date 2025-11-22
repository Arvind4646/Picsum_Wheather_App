//
//  RootView.swift
//  Assessment
//
//  Created by Arvind Rawat on 22/11/25.
//

import SwiftUI

struct RootView: View {
    @StateObject var imageViewModel = ImageFeedViewModel()
    var body: some View {
        TabView {
            ImageFeedView(imageViewModel: imageViewModel)
                .tabItem {
                    Label("Images", systemImage: "photo.on.rectangle")
                }
            MapScreenView(imageViewModel: imageViewModel)
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
    }
}

#Preview {
    RootView()
}
