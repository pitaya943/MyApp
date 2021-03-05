//
//  MyAppApp.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/22.
//

import SwiftUI
import Firebase

@main
struct MyAppApp: App {
    
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    @StateObject var viewRouter = ViewRouter()

    var body: some Scene {
        
        WindowGroup {
            MotherView()
                .environmentObject(viewRouter)
                .preferredColorScheme(.light)
        }
    }
}

class Delegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Needed for phone auth
    }
}
