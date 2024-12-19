//
//  ViewController.swift
//  Bankey
//
//  Created by Kompas Digital on 16/12/24.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {

    let titleLabel = UILabel()
    let captionTitleLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()

    weak var delegate: LoginViewControllerDelegate?

    var username: String? {
        return loginView.usernameTextField.text
    }

    var password: String? {
        return loginView.passwordTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.signInButton.configuration?.showsActivityIndicator = false
    }
}

extension LoginViewController {
    private func style() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 28, weight: .medium)
        titleLabel.text = "Bankey"

        captionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        captionTitleLabel.textAlignment = .center
        captionTitleLabel.numberOfLines = 2
        captionTitleLabel.font = .systemFont(ofSize: 20)
        captionTitleLabel.text = "Your premium source for all things banking!"

        // To make our custom constraints work properly
        // Don't forget to make this value to false
        loginView.translatesAutoresizingMaskIntoConstraints = false

        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)

        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.text = "Error Failure"
        errorMessageLabel.isHidden = true
    }

    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(captionTitleLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)

        // Title Label
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1), // 1x = 8px, coming from leading anchor
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 1) // Trailing anchor view, calculated after loginView trailing anchor, not after view trailing anchor
        ])

        // Caption Title Label
        NSLayoutConstraint.activate([
            captionTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2),
            captionTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor), // 1x = 8px, coming from leading anchor
            captionTitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])

        // Login
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: captionTitleLabel.bottomAnchor, multiplier: 2),
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1), // 1x = 8px, coming from leading anchor
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1) // Trailing anchor view, calculated after loginView trailing anchor, not after view trailing anchor
        ])

        // Button
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])

        // Label
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor)
        ])
    }
}

extension LoginViewController {
    @objc func signInTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }

    private func login() {
//        guard let username = username, let password = password else {
//            assertionFailure("Username / Password should never be nil")
//            return
//        }

        signInButton.configuration?.showsActivityIndicator = true
        delegate?.didLogin()
//        if username.isEmpty || password.isEmpty {
//            configureView(withMessage: "Username / Password should cannot be blank")
//            return
//        }
//
//        if username == "Reza" && password == "Welcome" {
//            signInButton.configuration?.showsActivityIndicator = true
//            delegate?.didLogin()
//        } else {
//            configureView(withMessage: "Incorrect username / password")
//        }
    }

    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}
