//
//  SceneDelegate.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 22/11/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let productsViewController = ProductsViewController()
        window?.rootViewController = productsViewController
        window?.makeKeyAndVisible()
    }

}

