//
//  ArtworkDetailView.swift
//  Artwork-SwiftUI
//
//  Created by Emre Dogan on 01/07/2023.
//

import SwiftUI

struct ArtworkDetailView: View {
	let artwork: Artwork
    var body: some View {
		ScrollView {
			artworkImageView
			Text(artwork.title)
				.font(.title)
				.padding()
		}
		.navigationTitle("Artwork Details")
		.navigationBarTitleDisplayMode(.inline)
    }
	
	/// It makes sense to use view builder when you have some conditional work on views
	@ViewBuilder var artworkImageView: some View {
		if let imageID = artwork.imageId,
		   let imageURL = URL(string: "https://www.artic.edu/iiif/2/\(imageID)/full/843,/0/default.jpg") {
			AsyncImage(url: imageURL) { image in
				image.resizable()
					.aspectRatio(contentMode: .fit)
				
			} placeholder: {
				ProgressView()
			}
		} else {
			Text("No image found")
		}
	}
}

struct ArtworkDetailView_Previews: PreviewProvider {
    static var previews: some View {
		ArtworkDetailView(artwork: previewArtwork)
    }
}
