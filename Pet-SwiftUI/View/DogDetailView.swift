//
//  DogDetailView.swift
//  Pet-SwiftUI
//
//  Created by Emre Dogan on 13/07/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct DogDetailView: View {
	@EnvironmentObject var listViewModel: DogListViewModel
	var imageUrl: String
	
	var body: some View {
		VStack {
			WebImage(url: URL(string: imageUrl))
				.resizable()
				.aspectRatio(contentMode: .fit)
				.navigationBarTitleDisplayMode(.inline)
			Text("Add to Cart 🛍️")
				.onTapGesture {
					if listViewModel.chosenDogUrls.contains(imageUrl) {
						if let index = listViewModel.chosenDogUrls.firstIndex(of: imageUrl) {
							listViewModel.chosenDogUrls.remove(at: index)
						}
					} else {
						listViewModel.chosenDogUrls.append(imageUrl)
					}
				}
		}
	}
}


struct DogDetailView_Previews: PreviewProvider {
	static var previews: some View {
		DogDetailView(imageUrl: "")
	}
}
