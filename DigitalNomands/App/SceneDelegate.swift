//
//  SceneDelegate.swift
//  DigitalNomands
//
//  Created by Viktor on 18.01.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private var splashPresenter: SplashPresenterDescription? = SplashPresenter()
    let delay: TimeInterval = 5
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController()
        let mainView = MainViewController()
        navigationController.viewControllers = [mainView]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        //MARK: - Loading animation main point
        splashPresenter?.present()
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.splashPresenter?.dismiss { [weak self] in
                self?.splashPresenter = nil
            }
        }
    }
}

