//
//  ArtworkView.swift
//  Artwork-SwiftUI
//
//  Created by Emre Dogan on 01/07/2023.
//

import SwiftUI

struct ArtworkView: View {
	let artwork: Artwork
    var body: some View {
		NavigationLink {
			ArtworkDetailView(artwork: artwork)
		} label: {
			Text(artwork.title)
		}

    }
}

struct ArtworkView_Previews: PreviewProvider {
    static var previews: some View {
		ArtworkView(artwork: previewArtwork)
			.previewLayout(.sizeThatFits)
    }
}
