//
//  MyViewController.swift
//  Pet-SwiftUI
//
//  Created by Emre Dogan on 17/07/2023.
//

import UIKit
import SwiftUI
import AVKit

struct WelcomeVideoView: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> SettingsViewController {
		SettingsViewController()
	}

	func updateUIViewController(_ uiViewController: SettingsViewController, context: Context) {}
}

class SettingsViewController: UIViewController {
	private let button: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Watch Welcome Video 🐶", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
		button.backgroundColor = .blue
		button.setTitleColor(.white, for: .normal)
		button.layer.cornerRadius = 8
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		
		view.addSubview(button)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(watchVideo), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			button.widthAnchor.constraint(equalToConstant: 300),
			button.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	@objc func watchVideo(_ sender: UIButton) {
		if let videoURL = URL(string: "https://www.pexels.com/video/10167684/download/") {
			let videoPlayer = VideoPlayer(player: AVPlayer(url: videoURL))
				.frame(height: 400)
			let videoPlayerCompatible = UIHostingController(rootView: videoPlayer)
			present(videoPlayerCompatible, animated: true)
		}
	}
}
