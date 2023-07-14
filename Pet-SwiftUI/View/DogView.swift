//
//  DogView.swift
//  Artwork-SwiftUI
//
//  Created by Emre Dogan on 02/07/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct DogView: View {
	@StateObject var viewModel: DogViewModel = DogViewModel()
	@EnvironmentObject var listViewModel: DogListViewModel
	@State private var showPlaceholder = true

	var dogBreed: DogBreed
    var body: some View {
		VStack {
			Text("\(dogBreed.name)")
			ScrollView(.horizontal) {
				HStack {
					ForEach(viewModel.dogImagesUrls, id: \.self) {urlString in
						if let url = URL(string: urlString) {
							NavigationLink(destination: DogDetailView(imageUrl: urlString)) {
								Group {
									if showPlaceholder {
										ContentLoader()
											.frame(width: 150, height: 150)

									} else {
										WebImage(url: url)
											.resizable()
											.frame(width: 150, height: 150)
											.aspectRatio(contentMode: .fit)
											.accessibilityLabel("Sample image of \(dogBreed.name)")
											.accessibilityRemoveTraits(.isImage)
									}
								}
							}
						}
					}
				}
				.onAppear {
					DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
						showPlaceholder = false
					}
				}
			}
		}
		.onAppear {
			if viewModel.dogImagesUrls.isEmpty {
				viewModel.fetchDogBreedsImagesWithCombine(breedName: dogBreed.name)				
			}
		}
	}
}

struct DogView_Previews: PreviewProvider {
    static var previews: some View {
		DogView(dogBreed: DogBreed(name: "terrier"))
    }
}
