//
//  PushNotificationHelper.swift
//  FoodOracle
//
//  Created by Aydin Battal on 2021-12-09.
//

import Foundation
import UIKit

class PushNotificationHelper{
    
    
    static func registerForPushNotification(){
        //request user's permission to receive remote notification
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]){ granted, _ in
            print(#function, "Permission Granted \(granted)")
            
            guard granted else{
                return
            }
            
            print(#function, "Permission for push notification is granted")
            //fetch notification setting and then register
            PushNotificationHelper.getNotificationSettings()
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
