//
//  DogViewModel.swift
//  Artwork-SwiftUI
//
//  Created by Emre Dogan on 02/07/2023.
//

import Foundation
import Combine

class DogListViewModel: ObservableObject {
	/// Private so our views can not change it.
	@Published private(set) var  dogItems = [DogBreed]()
	@Published private(set) var  isRefreshing = false
	private var cancellables = Set<AnyCancellable>()
	private let jsonDecoder = JSONDecoder()
	
	func fetchDogBreedsListWithCombine() {
		guard let url = URL(string: "https://dog.ceo/api/breeds/list/all") else { return }
		
		/// A key decoding strategy that converts snake-case keys to camel-case keys.
		jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
		isRefreshing = true
		URLSession.shared.dataTaskPublisher(for: url)
			.map(\.data)
			.decode(type: DogAPIResult.self, decoder: jsonDecoder)
			.receive(on: DispatchQueue.main)
			.sink { [weak self] completion in
				switch completion {
					case .failure(let error):
						print("Error is \(error)")
					case .finished:
						print("Finished")
						self?.isRefreshing = false
				}
			} receiveValue: { [weak self] response in
				/// Take every element from the message which in this Array [String: [String]]
				/// Take the key from that dictionary element and use it while creating the DogBreed
				let dogBreeds = response.message.map { DogBreed(name: $0.key) }
				let sortedDogBreeds = dogBreeds.sorted { $0.name < $1.name }
				self?.dogItems = sortedDogBreeds
			}
			.store(in: &cancellables)
	}
	
	func fetchDogBreedsListWithUrlRequest() {
		guard let url = URL(string: "https://dog.ceo/api/breeds/list/all") else { return }
		let request = URLRequest(url: url)
		
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard let data = data else { return }
			
			do {
				let result = try JSONDecoder().decode(DogAPIResult.self, from: data)
				let dogBreeds = result.message.map { DogBreed(name: $0.key) }
				let sortedDogBreeds = dogBreeds.sorted { $0.name < $1.name }
				DispatchQueue.main.async {
					self.dogItems = sortedDogBreeds
				}
			} catch {
				print("Error: \(error)")
			}
		}
		
		task.resume()
	}
	
	func fetchDogBreedsListWithAsyncAwait() async {
		guard let url = URL(string: "https://dog.ceo/api/breeds/list/all") else { return }
		do {
			let (data, response) = try await URLSession.shared.data(from: url)
			let result = try JSONDecoder().decode(DogAPIResult.self, from: data)
			let dogBreeds = result.message.map { DogBreed(name: $0.key) }
			let sortedDogBreeds = dogBreeds.sorted { $0.name < $1.name }
			DispatchQueue.main.async {
				self.dogItems = sortedDogBreeds
			}
		} catch {
			debugPrint("Error: \(error)")
		}
		
	}
}
