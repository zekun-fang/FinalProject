//
//  LoginView.swift
//  ExpenseX
//
//  Created by 方泽堃 on 12/9/23.
//

import UIKit

class LoginView: UIView {

    let logoImageView = UIImageView()
    let loginLabel = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signInButton = UIButton()
    let signUpLabel = UILabel()
    let signUpButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        backgroundColor = .white
        
        // Logo ImageView Setup
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "appstore")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(logoImageView)
        
        // Login Label Setup
        loginLabel.text = "Login to your Account"
        loginLabel.textAlignment = .center
        loginLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loginLabel)

        // Email TextField Setup
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emailTextField)
        
        // Password TextField Setup
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(passwordTextField)
        
        // Sign In Button Setup
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.backgroundColor = .blue
        signInButton.layer.cornerRadius = 5
        signInButton.layer.shadowColor = UIColor.black.cgColor
        signInButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        signInButton.layer.shadowRadius = 4
        signInButton.layer.shadowOpacity = 0.5
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(signInButton)
        
        // Sign Up Label Setup
        signUpLabel.text = "Don't have an account?"
        signUpLabel.textColor = .gray
        signUpLabel.textAlignment = .center
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(signUpLabel)
        
        // Sign Up Button Setup
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.setTitleColor(.blue, for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(signUpButton)
        
        // Auto Layout Constraints
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            loginLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),
            emailTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            signInButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signInButton.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Sign Up Label Setup
            signUpLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            signUpLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            
            // Sign Up Button Setup
            signUpButton.centerYAnchor.constraint(equalTo: signUpLabel.centerYAnchor),
            signUpButton.leadingAnchor.constraint(equalTo: signUpLabel.trailingAnchor, constant: 4)
        ])
    }
}

