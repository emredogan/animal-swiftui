//
//  Unsplash.swift
//  Artwork-SwiftUI
//
//  Created by Emre Dogan on 02/07/2023.
//

import Foundation

// MARK: - UnsplashDataResponse
struct UnsplashDataResponse: Decodable {
	let results: [Unsplash]
}

// MARK: - Result
struct Unsplash: Decodable, Identifiable {
	let id: String
	let width, height: Int
	let likes: Int
	let description: String?
	let user: User
	let urls: Urls
}

// MARK: - Urls
struct Urls: Decodable {
	let raw, full, regular, small: String
	let thumb: String
}

// MARK: - User
struct User: Decodable {
	let name: String
}
