//
//  DogViewModel.swift
//  Artwork-SwiftUI
//
//  Created by Emre Dogan on 02/07/2023.
//

import Foundation
import Combine
import UIKit

class DogViewModel: ObservableObject {
	/// Private so our views can not change it.
	@Published private(set) var  dogImagesUrls = [String]()
	private var cancellables = Set<AnyCancellable>()
	private let jsonDecoder = JSONDecoder()
	
	func fetchDogBreedsImagesWithCombine(breedName: String) {
		guard let url = URL(string: "https://dog.ceo/api/breed/\(breedName)/images/random/6") else { return }
		
		/// A key decoding strategy that converts snake-case keys to camel-case keys.
		jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
		
		URLSession.shared.dataTaskPublisher(for: url)
			.map(\.data)
			.decode(type: DogImagesListResponse.self, decoder: jsonDecoder)
			.receive(on: DispatchQueue.main)
			.sink { completion in
				switch completion {
					case .failure(let error):
						print("Error is \(error)")
					case .finished:
						print("Finished")
				}
			} receiveValue: { [weak self] response in
				self?.dogImagesUrls = response.message
			}
			.store(in: &cancellables)
	}
}
