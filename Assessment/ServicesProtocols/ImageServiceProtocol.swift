//
//  ImageServiceProtocol.swift
//  Assessment
//
//  Created by Arvind Rawat on 22/11/25.
//

import Foundation

protocol ImageServiceProtocol {
    func fetchImages() async throws -> [Image]
    func imageURL(for id: Int) -> URL?
}
