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
	@State private var showingCameraPicker = false
	@State private var showingSettings = false
	var body: some View {
		NavigationStack {
			VStack {
				Text("Number of dogs: \(viewModel.chosenDogUrls.count)")
				List(viewModel.dogItems, id: \.self) { dogItem in
					DogView(dogBreed: dogItem)
						.frame(width: UIScreen.main.bounds.width, height: 200)
				}
			}
			.sheet(isPresented: $showingSettings) {
				SettingsView()
			}
			.sheet(isPresented: $showingCameraPicker, content: {
				CameraImagePicker()
			})
			.toolbar {
				HStack {
					Button("Request") {
						Task {
							showingCameraPicker = true
							await notifManager.request()
						}
					}
					.disabled(notifManager.hasPermission)
					.accessibilityHidden(true)
					Button("Camera") {
						Task {
							showingCameraPicker = true
						}
					}
					Button("Settings") {
						Task {
							showingSettings = true
						}
					}
				}
				
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
