//
//  AppDelegate.swift
//  Bankey
//
//  Created by Kompas Digital on 16/12/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
//        loginViewController.delegate = self
//        window?.rootViewController = loginViewController
        onboardingContainerViewController.delegate = self
        window?.rootViewController = onboardingContainerViewController
//        window?.rootViewController = OnboardingContainerViewController()
        return true
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        print("Did login")
    }
}

extension AppDelegate: OnboardingViewControllerDelegate {
    func didFinishOnboarding() {
        print("Did Finish")
    }
}
