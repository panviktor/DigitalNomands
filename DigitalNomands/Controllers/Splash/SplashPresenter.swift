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
    private var animator: SplashAnimatorDescription?
    func present() {
        if let currentWindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            splashWindow = UIWindow(frame: currentWindowScene.coordinateSpace.bounds)
            splashWindow?.windowScene = currentWindowScene
            splashWindow?.frame = UIScreen.main.bounds
            splashWindow?.backgroundColor = .clear
            splashWindow?.windowLevel = UIWindow.Level.statusBar + 1
            splashWindow?.rootViewController = SplashViewController()
            splashWindow?.makeKeyAndVisible()
            
            animator = SplashAnimator(foregroundSplashWindow: splashWindow!)
            animator?.animateAppearance()
        }
    }
    
    func dismiss(completion: @escaping () -> Void) {
        animator?.animateDisappearance(completion: completion)
        splashWindow = nil
    }
}




// NEXT file
protocol SplashAnimatorDescription: class {
    func animateAppearance()
    func animateDisappearance(completion: @escaping () -> Void)
}

final class SplashAnimator: SplashAnimatorDescription {
    private unowned let foregroundSplashWindow: UIWindow
    private unowned let foregroundSplashViewController: SplashViewController
    
    private var splashWindow: UIWindow?
    
    init(foregroundSplashWindow: UIWindow) {
        self.foregroundSplashWindow = foregroundSplashWindow
        guard let foregroundSplashViewController = foregroundSplashWindow.rootViewController as? SplashViewController else {
            fatalError("Splash window doesn't have splash root view controller!")
        }
        
        self.foregroundSplashViewController = foregroundSplashViewController
    }
    
    func animateAppearance() {
        foregroundSplashViewController.startAnimation()
        
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .last?.windows
                .filter({$0.isKeyWindow}).first
  
        keyWindow?.alpha = 0.5
    }
    
    func animateDisappearance(completion: @escaping () -> Void) {
        
    }
}
