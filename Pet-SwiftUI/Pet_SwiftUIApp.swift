//
//  Artwork_SwiftUIApp.swift
//  Artwork-SwiftUI
//
//  Created by Emre Dogan on 01/07/2023.
//

import SwiftUI
import UserNotifications

class MyAppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
	var app: Pet_SwiftUIApp?
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		UNUserNotificationCenter.current().delegate = self
		return true
	}
}

extension MyAppDelegate: UNUserNotificationCenterDelegate {
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
		if let deepLink = response.notification.request.content.userInfo["link"] as? String {
			print("Received deeplink ❤️ \(deepLink)")
			let url = URL(string: deepLink)
			Task {
				if url?.host() == "german" {
					app?.showPromo = true
				}
			}
		}
		
	}
	
	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
		return [.sound, .badge, .banner, .list]
	}
}
	

@main
struct Pet_SwiftUIApp: App {
	@UIApplicationDelegateAdaptor private var appDelegate: MyAppDelegate
	@State var showPromo = false

    var body: some Scene {
        WindowGroup {
            ContentView()
				.task {
					appDelegate.app = self
				}
				.sheet(isPresented: $showPromo) {
					// Content of the sheet
					VStack {
						Text("Tuborg %25 Rabat 🍺🍺🍺")
						Button("Add to cart") {
							
						}
					}
				}
		}
	}
}
