//
//  Artwork.swift
//  Artwork-SwiftUI
//
//  Created by Emre Dogan on 01/07/2023.
//

import Foundation

let previewArtwork = Artwork(id: 16487, title: "The Bay of Marseille", imageId: "d4ca6321-8656-3d3f-a362-2ee297b2b813")

struct ArtworkDataResponse: Decodable {
	let data: [Artwork]
}

struct Artwork: Decodable, Identifiable {
	// We decode the JSON object that we get back
	let id: Int
	let title: String
	let imageId: String?
}


