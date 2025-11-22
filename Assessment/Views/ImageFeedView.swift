//
//  PicsumFeedView.swift
//  Assessment
//
//  Created by Arvind Rawat on 22/11/25.
//

import SwiftUI
import Kingfisher

struct ImageFeedView: View {
    @ObservedObject var imageViewModel: ImageFeedViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            Group {
                if let error = imageViewModel.error {
                    VStack {
                        Text("Error: \(error)")
                        Button("Retry") {
                            Task { await imageViewModel.initialFetch() }
                        }
                    }
                } else if imageViewModel.images.isEmpty && imageViewModel.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(imageViewModel.images) { img in
                                let url = imageViewModel.imageService.imageURL(for: img.id)
                                KFImage(url)
                                    .placeholder { ProgressView() }
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 180)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .onAppear {
                                        if img == imageViewModel.images.last {
                                            Task { await imageViewModel.loadMoreImages() }
                                        }
                                    }
                            }
                        }
                        
                        // Pagination Loader
                        if imageViewModel.isPaginating {
                            ProgressView()
                                .padding(.top, 16)
                        }
                    }
                }
            }
            .navigationTitle("Picsum Images")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            Task { await imageViewModel.initialFetch() }
        }
    }
}

#Preview {
    ImageFeedView(imageViewModel: ImageFeedViewModel())
}
