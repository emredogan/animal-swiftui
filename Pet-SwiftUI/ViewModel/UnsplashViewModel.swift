//
//  ArtworkViewModel.swift
//  Artwork-SwiftUI
//
//  Created by Emre Dogan on 01/07/2023.
//

import Foundation
import Combine

class UnsplashViewModel: ObservableObject {
	/// Private so our views can not change it.
	@Published private(set) var  unsplashItems = [Unsplash]()
	@Published var searchText: String  = "flowers"
	private var cancellables = Set<AnyCancellable>()
	private let jsonDecoder = JSONDecoder()
	private let accessKey = "An02_W_gHb7kuWngegVfPtUyLQ1gh51qeDHo2ZzR6fQ"
	
	func fetchUnsplashWithCombine() {
		guard let url = URL(string: "https://api.unsplash.com/search/photos?page=1&query=\(searchText)") else { return }
		
		/// A key decoding strategy that converts snake-case keys to camel-case keys.
		jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
		
		URLSession.shared.dataTaskPublisher(for: url)
			.map(\.data)
			.decode(type: UnsplashDataResponse.self, decoder: jsonDecoder)
			.receive(on: DispatchQueue.main)
			.sink { completion in
				switch completion {
					case .failure(let error):
						print("Error is \(error)")
					case .finished:
						print("Finished")
				}
			} receiveValue: { [weak self] response in
				self?.unsplashItems = response.results
			}
			.store(in: &cancellables)
	}
	
	func fetchUnsplashWithUrlRequest() {
		let url = URL(string: "https://api.unsplash.com/search/photos?page=1&query=\(searchText)")
		guard let url else { return }
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.setValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")
		
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard let data = data else { return }
			
			do {
				let res = try JSONDecoder().decode(UnsplashDataResponse.self, from: data)
				self.unsplashItems.append(contentsOf: res.results)
			} catch {
				print("Error: \(error)")
			}
		}
		
		task.resume()
	}
}
