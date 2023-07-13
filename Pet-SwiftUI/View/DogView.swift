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
	var dogBreed: DogBreed
    var body: some View {
		VStack {
			Text("\(dogBreed.name)")
			ScrollView(.horizontal) {
				HStack {
					ForEach(viewModel.dogImagesUrls, id: \.self) {urlString in
						if let url = URL(string: urlString) {
							WebImage(url: url)
								.resizable()
								.frame(width: 150, height: 150)
								.aspectRatio(contentMode: .fit)
								.accessibilityLabel("Sample image of \(dogBreed.name)")
								.accessibilityRemoveTraits(.isImage)
								.onTapGesture {
									if listViewModel.chosenDogUrls.contains(urlString) {
										if let index = listViewModel.chosenDogUrls.firstIndex(of: urlString) {
											listViewModel.chosenDogUrls.remove(at: index)
										}
									} else {
										listViewModel.chosenDogUrls.append(urlString)
									}
								}
						}
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
