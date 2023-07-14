//
//  ContentLoader.swift
//  Pet-SwiftUI
//
//  Created by Emre Dogan on 13/07/2023.
//

import SwiftUI

struct ContentLoader: View {
    var body: some View {
		ZStack {
			Color.white
			VStack {
				ShimmerEffectBox()
			}
		}
    }
}

struct ContentLoader_Previews: PreviewProvider {
    static var previews: some View {
        ContentLoader()
    }
}
