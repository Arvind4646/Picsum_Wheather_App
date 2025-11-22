//
//  ImageFeedViewModel.swift
//  Assessment
//
//  Created by Arvind Rawat on 22/11/25.
//

import Foundation

@MainActor
class ImageFeedViewModel: ObservableObject {
    @Published private(set) var allImages: [Image] = []
    @Published private(set) var images: [Image] = []
    @Published private(set) var isLoading = false
    @Published private(set) var isPaginating = false
    @Published private(set) var error: String? = nil

    private var loadedCount = 0
    private let chunkSize = 30
    
    let imageService: ImageServiceProtocol
    
    init(imageService: ImageServiceProtocol = ImageService()) {
        self.imageService = imageService
    }
    
    func initialFetch() async {
        isLoading = true
        defer { isLoading = false }
        do {
            allImages = try await imageService.fetchImages()
            await loadMoreImages()
        } catch {
            self.error = error.localizedDescription
        }
    }
        
    func loadMoreImages() async {
        guard loadedCount < allImages.count else { return }
        isPaginating = true
        
        // Simulate network delay to feel pagination.
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        let endIndex = min(loadedCount + chunkSize, allImages.count)
        images.append(contentsOf: allImages[loadedCount..<endIndex])
        
        loadedCount = endIndex
        isPaginating = false
    }
}

