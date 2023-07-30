//
//  DogDetailView.swift
//  Pet-SwiftUI
//
//  Created by Emre Dogan on 13/07/2023.
//

import SwiftUI
import SDWebImageSwiftUI
import CoreMotion

struct DogDetailView: View {
	@EnvironmentObject var listViewModel: DogListViewModel
	@State private var tiltAngleX: Double = 0.0
	@State private var tiltAngleY: Double = 0.0

	let motionManager: CMMotionManager = CMMotionManager()

	var imageUrl: String
	
	var body: some View {
		VStack {
			WebImage(url: URL(string: imageUrl))
				.resizable()
				.rotation3DEffect(Angle(degrees: tiltAngleX), axis: (x: 0, y: 1, z: 0))
				.rotation3DEffect(Angle(degrees: tiltAngleY), axis: (x: -1, y: 0, z: 0))
				.aspectRatio(contentMode: .fit)
				.navigationBarTitleDisplayMode(.inline)
				.padding(20)
			Text("Add to Favorites ❤️")
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
		.onAppear {
			startMotionUpdates()
		}
		.onDisappear {
			stopMotionUpdates()
		}
	}
	
	private func startMotionUpdates() {
		motionManager.deviceMotionUpdateInterval = 0.1
		motionManager.startDeviceMotionUpdates(to: .main) { motionData, _ in
			let maxTiltAngle = 15
			if let attitude = motionData?.attitude {
				let pitch = attitude.pitch
				let roll = attitude.roll

				tiltAngleX = limitAngle(roll * 180.0 / .pi, within: maxTiltAngle)
				tiltAngleY = limitAngle(pitch * 180.0 / .pi, within: maxTiltAngle)
			}
		}
	}

	private func limitAngle(_ angle: Double, within range: Int) -> Double {
		let maxAngle = Double(range)

		if angle > maxAngle {
			return maxAngle
		} else if angle < -maxAngle {
			return -maxAngle
		} else {
			return angle
		}
	}

		private func stopMotionUpdates() {
			motionManager.stopDeviceMotionUpdates()
		}
}


struct DogDetailView_Previews: PreviewProvider {
	static var previews: some View {
		DogDetailView(imageUrl: "")
	}
}
