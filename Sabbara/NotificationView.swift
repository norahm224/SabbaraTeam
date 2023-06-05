//
//  NotificationView.swift
//  Sabbara
//
//  Created by salma alorifi on 19/11/1444 AH.
//

import SwiftUI

import UserNotifications

struct NotificationView: View {
    @State private var notificationMessage: String = ""
    
    var body: some View {
        Text(notificationMessage)
            .onAppear {
                AppDelegate.scheduleNotification()
                notificationMessage = ""
            }
    }
}  
struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
