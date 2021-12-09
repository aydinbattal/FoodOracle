//
//  PushNotificationHelper.swift
//  FoodOracle
//
//  Created by Aydin Battal on 2021-12-09.
//

import Foundation
import UIKit

class PushNotificationHelper{
    
    static func scheduleNotificationForDinner(){
        let content = UNMutableNotificationContent()
        content.title = "Dinner Time!"
        content.body = "It's time for a dinner"
        content.sound = UNNotificationSound.default
        content.badge = 3
        
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.hour = 19
//        dateComponents.minute = 55
           
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
           }
        }
    }
    
    static func scheduleNotificationForBreakfast(){
        let content = UNMutableNotificationContent()
        content.title = "Breakfast Time!"
        content.body = "It's time for a breakfast"
        content.sound = UNNotificationSound.default
        content.badge = 3
        
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.hour = 9
//        dateComponents.minute = 55
           
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
           }
        }
    }
    
    static func scheduleNotificationForLunch(){
        let content = UNMutableNotificationContent()
        content.title = "Lunch Time!"
        content.body = "It's time for a lunch"
        content.sound = UNNotificationSound.default
        content.badge = 3
        
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.hour = 14
//        dateComponents.minute = 55
           
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
           }
        }
    }
    
    
    static func registerForPushNotification(){
        //request user's permission to receive remote notification
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]){ granted, _ in
            print(#function, "Permission Granted \(granted)")
            
            guard granted else{
                return
            }
            
            print(#function, "Permission for push notification is granted")
            //fetch notification setting and then register
//            PushNotificationHelper.getNotificationSettings()
            PushNotificationHelper.scheduleNotificationForDinner()

        }
    }
    
    static func getNotificationSettings(){
        //fetch notification setting and then register
        
        UNUserNotificationCenter.current().getNotificationSettings{settings in
            
            print(#function, "Notification Settings \(settings)")
            
            guard settings.authorizationStatus == .authorized else{
                return
            }
            
            //authorized
            
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
}
