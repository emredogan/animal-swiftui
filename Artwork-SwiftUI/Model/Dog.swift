//
//  Dog.swift
//  Artwork-SwiftUI
//
//  Created by Emre Dogan on 02/07/2023.
//

import Foundation

public struct DogAPIResult: Codable {
	public let message: [String: [String]]
	public let status: String
}

public struct DogBreed: Hashable {
	public let name: String
}

public struct DogSubBreed: Hashable {
	public let name: String
}

public struct DogImagesListResponse: Decodable {
		let message: [String]
		let status: String
}
