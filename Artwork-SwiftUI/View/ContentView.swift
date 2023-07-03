//
//  ContentView.swift
//  Artwork-SwiftUI
//
//  Created by Emre Dogan on 01/07/2023.
//

import SwiftUI

struct ContentView: View {
	@StateObject private var viewModel = DogListViewModel()
    var body: some View {
		List(viewModel.dogItems, id: \.self) { dogItem in
			DogView(dogBreed: dogItem)
				.frame(width: UIScreen.main.bounds.width, height: 200) // Set the desired width and height for the DogView
		}
		.task {
			if viewModel.dogItems.isEmpty {
				await viewModel.fetchDogBreedsListWithAsyncAwait()
			}
		}
		.onAppear {
			if viewModel.dogItems.isEmpty {
				//viewModel.fetchDogBreedsListWithUrlRequest()
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
