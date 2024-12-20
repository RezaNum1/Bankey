//
//  AppDelegate.swift
//  Bankey
//
//  Created by Kompas Digital on 16/12/24.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let dummyViewController = DummyViewController()
    let mainViewController = MainViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        dummyViewController.logoutDelegate = self
        
        
//        window?.rootViewController = mainViewController
//        window?.rootViewController = OnboardingContainerViewController()
        window?.rootViewController = AccountSummaryViewController()
        return true
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        if LocalState.hasOnBoarded {
            self.setRootViewController(dummyViewController)
        } else {
            self.setRootViewController(onboardingContainerViewController)
        }
    }
}

extension AppDelegate: OnboardingViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnBoarded = true
        self.setRootViewController(dummyViewController)
    }
}

extension AppDelegate: LogoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(
            with: window,
            duration: 0.7,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil
        )
    }
}
