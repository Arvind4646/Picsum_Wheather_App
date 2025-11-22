//
//  AssessmentApp.swift
//  Assessment
//
//  Created by Arvind Rawat on 22/11/25.
//

import SwiftUI
import GoogleMaps

@main
struct AssessmentApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("appTheme") private var appTheme: String = "system"
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
    
    private var currentColorScheme: ColorScheme? {
        switch appTheme {
        case "light": return .light
        case "dark": return .dark
        default: return nil   // System default
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let key = Bundle.main.object(forInfoDictionaryKey: "GoogleMapsAPIKey") as? String {
            GMSServices.provideAPIKey(key)
        }
        return true
    }
}
