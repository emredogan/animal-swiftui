//
//  ShimmerEffect.swift
//  Pet-SwiftUI
//
//  Created by Emre Dogan on 13/07/2023.
//

import SwiftUI

struct ShimmerEffectBox: View {
	@State private var startPoint: UnitPoint = .init(x: -1.8, y: -1.2)
	@State private var endPoint: UnitPoint = .init(x: 0, y: -0.2)
	private var gradientColors = [
		Color(uiColor: UIColor.systemGray5),
		Color(uiColor: UIColor.systemGray6),
		Color(uiColor: UIColor.systemGray5)]
    var body: some View {
		LinearGradient(colors: gradientColors, startPoint: startPoint, endPoint: endPoint)
			.onAppear {
				withAnimation(.easeOut(duration: 1).repeatForever(autoreverses: false)) {
					startPoint = .init(x: 1, y: 1)
					endPoint = .init(x: 2.2 , y: 2.2)
				}
			}
    }
}

struct ShimmerEffectBox_Previews: PreviewProvider {
    static var previews: some View {
        ShimmerEffectBox()
    }
}
