//
//  SplashViewController.swift
//  DigitalNomands
//
//  Created by Viktor on 18.01.2021.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    private let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.7882352941, green: 0.631372549, blue: 0.9411764706, alpha: 1), endColor: #colorLiteral(red: 0.4784313725, green: 0.6980392157, blue: 0.9215686275, alpha: 1))
    
    private let animationView: AnimationView = {
        let animationView = AnimationView()
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.animation = Animation.named("startingCat")
        return animationView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupConstraints()
    }
    
    func startAnimation() {
        animationView.play()
    }
}

// MARK: - Setup constraints
extension SplashViewController {
    private func setupConstraints() {
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        gradientView.backgroundColor = .black
        view.addSubview(gradientView)
        gradientView.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }
}

// MARK: - SwiftUI
import SwiftUI
struct ActiveChatProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = SplashViewController()
        
        func makeUIViewController(context: Context) -> SplashViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: SplashViewController, context: Context) {}
    }
}

