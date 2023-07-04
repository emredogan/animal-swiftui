//
//  NotificationsManager.swift
//  Artwork-SwiftUI
//
//  Created by Emre Dogan on 04/07/2023.
//

import Foundation
import UserNotifications

@MainActor
class NotificationsManager: ObservableObject {
	@Published private(set) var hasPermission = false
	
	init() {
		Task {
			await getAuthStatus()
		}
	}
	
	func request() async {
		do {
			self.hasPermission =  try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
		} catch {
			debugPrint("Error: \(error.localizedDescription)")
		}
	}
	
	func getAuthStatus() async {
		let status = await UNUserNotificationCenter.current().notificationSettings()
		switch status.authorizationStatus {
			case .authorized,
					.provisional,
					.ephemeral:
				hasPermission = true
			default:
				hasPermission = false
		}
	}
}
