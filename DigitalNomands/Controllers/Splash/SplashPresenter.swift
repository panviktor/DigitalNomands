//
//  SplashPresenter.swift
//  DigitalNomands
//
//  Created by Viktor on 18.01.2021.
//

import UIKit

protocol SplashPresenterDescription: class {
    func present()
    func dismiss(completion: @escaping () -> Void)
}

final class SplashPresenter: SplashPresenterDescription {
    private var splashWindow: UIWindow?
    func present() {
        if let currentWindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            splashWindow = UIWindow(frame: currentWindowScene.coordinateSpace.bounds)
            splashWindow?.windowScene = currentWindowScene
            splashWindow?.frame = UIScreen.main.bounds
            splashWindow?.backgroundColor = .clear
            splashWindow?.windowLevel = UIWindow.Level.statusBar + 1
            let vc = SplashViewController()
            splashWindow?.rootViewController = vc
            splashWindow?.makeKeyAndVisible()
            vc.startAnimation()
        }
    }
    
    func dismiss(completion: @escaping () -> Void) {
        splashWindow = nil
    }
}
