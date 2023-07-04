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
			List(viewModel.dogItems, id: \.self) { dogItem in
				DogView(dogBreed: dogItem)
					.frame(width: UIScreen.main.bounds.width, height: 200) // Set the desired width and height for the DogView
			}
			.toolbar {
				Button("Request") {
					Task {
						await notifManager.request()
					}
				}
				.disabled(notifManager.hasPermission)
			}
			.task {
				await notifManager.getAuthStatus()
				if viewModel.dogItems.isEmpty {
					await viewModel.fetchDogBreedsListWithAsyncAwait()
				}
		}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
