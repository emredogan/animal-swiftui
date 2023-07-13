//
//  ContentView.swift
//  Artwork-SwiftUI
//
//  Created by Emre Dogan on 01/07/2023.
//

import SwiftUI

struct ContentView: View {
	@StateObject private var viewModel = DogListViewModel()
	@StateObject private var notifManager = NotificationsManager()
	var body: some View {
		NavigationStack {
			VStack {
				Text("Number of dogs: \(viewModel.chosenDogUrls.count)")
				List(viewModel.dogItems, id: \.id) { dogItem in
					DogView(dogBreed: dogItem)
						.frame(width: UIScreen.main.bounds.width, height: 200)
				}
			}
			.toolbar {
				Button("Request") {
					Task {
						await notifManager.request()
					}
				}
				.disabled(notifManager.hasPermission)
				.accessibilityHidden(true)
			}
			.task {
				await notifManager.getAuthStatus()
				if viewModel.dogItems.isEmpty {
					await viewModel.fetchDogBreedsListWithAsyncAwait()
				}
			}
			.navigationTitle("Number of dogs: \(viewModel.chosenDogUrls.count)")
		}
		.environmentObject(viewModel)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
