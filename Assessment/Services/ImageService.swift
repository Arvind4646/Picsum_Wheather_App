//
//  ImageService.swift
//  Assessment
//
//  Created by Arvind Rawat on 22/11/25.
//

import Foundation

final class ImageService: ImageServiceProtocol {

    func fetchImages() async throws -> [Image] {
        guard let url = URL(string: "https://picsum.photos/list") else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Image].self, from: data)
    }

    func imageURL(for id: Int) -> URL? {
        guard let url = URL(string: "https://picsum.photos/200/300?image=\(id)") else {return nil}
        return url
    }
}
