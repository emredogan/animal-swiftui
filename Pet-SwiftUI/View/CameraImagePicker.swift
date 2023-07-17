//
//  ImagePicker.swift
//  Pet-SwiftUI
//
//  Created by Emre Dogan on 16/07/2023.
//

import PhotosUI
import SwiftUI

struct CameraImagePicker: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> UIImagePickerController {
		let imagePicker = UIImagePickerController()
		imagePicker.sourceType = .camera
		return imagePicker
	}
	
	func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
		// Perform any necessary updates here
	}
}
