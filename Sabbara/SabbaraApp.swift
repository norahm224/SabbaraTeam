//
//  SabbaraApp.swift
//  Sabbara
//
//  Created by Omnya Kamal  on 15/05/2023.
//
import SwiftUI
import UserNotifications
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //FirebaseApp.configure()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                // Handle error
                print("Failed to request authorization for notifications: \(error)")
            } else if granted {
                // Authorization granted, continue with scheduling notifications
                UNUserNotificationCenter.current().delegate = self
                AppDelegate.scheduleNotification()
            } else {
                // Authorization denied
                print("Authorization denied for notifications")
            }
        }
        
        return true
    }
    static func scheduleNotification() {
        let triggerDays: [Int] = [5, 6, 7] // Thursday, Friday, Saturday
        
        for day in triggerDays {
            let content = UNMutableNotificationContent()
            content.sound = .default
            
            var dateComponents = DateComponents()
            dateComponents.weekday = day
            dateComponents.hour = 19
            dateComponents.minute = 26
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let requestIdentifier = "messageNotification_\(day)"
            
            switch day {
            case 5:
                content.title = NSLocalizedString("Thursday Message", comment: "")
                content.body = NSLocalizedString("You have a new message for Thursday", comment: "")
            case 6:
                content.title = NSLocalizedString("Friday Message", comment: "")
                content.body = NSLocalizedString("You have a new message for Friday", comment: "")
            case 7:
                content.title = NSLocalizedString("Saturday Message", comment: "")
                content.body = NSLocalizedString("You have a new message for Saturday", comment: "")
                
            default:
                break
            }
            
            let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    // Handle error
                    print("Failed to schedule notification for day \(day): \(error)")
                } else {
                    // Notification scheduled successfully
                    print("Notification scheduled for day \(day)")
                }
            }
        }
    }
    
    
    
}



@main
struct SabbaraApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var dataController = DataController()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            Splash()
//            MainPage()
                .environment(\.managedObjectContext,
                              dataController.container.viewContext)
               .environment(\.locale, .init(identifier: "ar"))
            .environment(\.layoutDirection, .rightToLeft)
            
            //AllModifiers()
//
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                .environment(\.locale, .init(identifier: "ar"))
//                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}


