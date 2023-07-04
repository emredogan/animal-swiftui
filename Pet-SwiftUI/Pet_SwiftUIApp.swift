//
//  Artwork_SwiftUIApp.swift
//  Artwork-SwiftUI
//
//  Created by Emre Dogan on 01/07/2023.
//

import SwiftUI
import UserNotifications

class MyAppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		UNUserNotificationCenter.current().delegate = self
		return true
	}
}

extension MyAppDelegate: UNUserNotificationCenterDelegate {
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
		if let deepLink = response.notification.request.content.userInfo["link"] as? String {
			print("Received deeplink ❤️ \(deepLink)")
		}
	}
}

@main
struct Pet_SwiftUIApp: App {
	@UIApplicationDelegateAdaptor private var appDelegate: MyAppDelegate
	@State private var showPromo = false

    var body: some Scene {
        WindowGroup {
            ContentView()
				.onOpenURL { url in
					print(url)
					if url.host() == "german" {
						showPromo = true
					}
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
