//
//  FoodOracleApp.swift
//  FoodOracle
//
//  Created by Aydin Battal on 2021-11-22.
//
//Deep Patel - 991584445, Karan Patel - 991519115, Aydin Battal - 991521740
import SwiftUI
import Firebase
import FirebaseFirestore

class AppDelegate : UIResponder, UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print(#function, "App did launched with options")
        
        //register for remote notfications
        PushNotificationHelper.registerForPushNotification()
        
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        //this will only be printed if you are testing on real device not on simulator
        guard let aps = userInfo["aps"] as? [String: AnyObject] else{
            completionHandler(.failed)
            return
        }
        
        print(#function, "Notification Received \(aps)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let tokenParts = deviceToken.map{data in String(format: "%02.2hhx", data)}
        let token = tokenParts.joined()
        
        print(#function, "Device Token \(token)")   //this will only be printed if you are testing on real device not on simulator
//        167BCB70-D409-4210-9AC1-01DA8670E030
//        iphone12
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(#function, "Failed to register for remote notifications \(error)")
    }
    
    //to send push notification on simulator

    // xcrun simctl push 167BCB70-D409-4210-9AC1-01DA8670E030 ca.sheridancollege.FoodOracle NotificationMessage.apn
}

@main
struct FoodOracleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let fireDBHelper: FireDBHelper
    let locationHelper = LocationHelper()
    
    init(){
        FirebaseApp.configure()
        fireDBHelper = FireDBHelper(database: Firestore.firestore())
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreen().environmentObject(fireDBHelper).environmentObject(locationHelper)
        //ContentView().environmentObject(fireDBHelper)
          //AddRecipeView().environmentObject(fireDBHelper)
        }
    }
}
