//
//  SceneDelegate.swift
//  Countries
//
//  Created by Ivan Redreev on 10.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let assembly = CountriesListAssembly(NetworkService())
            let navigator = UINavigationController(rootViewController: assembly.view)
            window.rootViewController = navigator
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
}

