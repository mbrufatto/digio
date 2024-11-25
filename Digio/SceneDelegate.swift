//
//  SceneDelegate.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 22/11/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: ProductsCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController = UINavigationController()
        let networkService = NetworkService()
        let coordinator = ProductsCoordinator(navigationController: navigationController, networkService: networkService)
        self.coordinator = coordinator
        
        coordinator.start()
        
        navigationController.navigationBar.tintColor = UIColor(named: "PrimaryColor")
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}

