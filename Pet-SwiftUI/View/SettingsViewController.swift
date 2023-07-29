//
//  MyViewController.swift
//  Pet-SwiftUI
//
//  Created by Emre Dogan on 17/07/2023.
//

import UIKit
import SwiftUI
import AVKit

struct SettingsView: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> SettingsViewController {
		SettingsViewController()
	}

	func updateUIViewController(_ uiViewController: SettingsViewController, context: Context) {}
}

class SettingsViewController: UIViewController {
	private let button: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Hello, UIKit!", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
		button.backgroundColor = .blue
		button.setTitleColor(.white, for: .normal)
		button.layer.cornerRadius = 8
		button.addTarget(self, action: #selector(didButtonClick), for: .touchUpInside)
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		
		view.addSubview(button)
		button.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			button.widthAnchor.constraint(equalToConstant: 200),
			button.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	@objc func didButtonClick(_ sender: UIButton) {
		let videoPlayer = VideoPlayer(player: AVPlayer(url: URL(string: "https://www.pexels.com/video/10167684/download/")!))
			.frame(height: 400)
		let videoPlayerCompatible = UIHostingController(rootView: videoPlayer)
		present(videoPlayerCompatible, animated: true)
	}
}

