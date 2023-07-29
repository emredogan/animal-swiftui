//
//  Artwork_SwiftUIApp.swift
//  Artwork-SwiftUI
//
//  Created by Emre Dogan on 01/07/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseMessaging

class MyAppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
	var app: Pet_SwiftUIApp?
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
	) -> Bool {

		FirebaseApp.configure()
		Messaging.messaging().delegate = self

		application.registerForRemoteNotifications()
		return true
	}
	
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
			Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
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

extension MyAppDelegate: MessagingDelegate {
	func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
	  print("Firebase registration token: \(String(describing: fcmToken))")

	  let dataDict: [String: String] = ["token": fcmToken ?? ""]
	  NotificationCenter.default.post(
		name: Notification.Name("FCMToken"),
		object: nil,
		userInfo: dataDict
	  )
	  // TODO: If necessary send token to application server.
	  // Note: This callback is fired at each app startup and whenever a new token is generated.
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
