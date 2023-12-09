//
//  RegisterView.swift
//  APP12
//
//  Created by 方泽堃 on 11/20/23.
//

import UIKit

class RegisterView: UIView {
    let logoImageView = UIImageView()
    let createAccountLabel = UILabel()
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let confirmPasswordTextField = UITextField()
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
        logoImageView.image = UIImage(named: "logo") // Replace "logo" with your image asset name
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(logoImageView)
        
        // Create Account Label Setup
        createAccountLabel.text = "Create your Account"
        createAccountLabel.textAlignment = .center
        createAccountLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        createAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(createAccountLabel)

        // Name TextField Setup
        setupTextField(nameTextField, placeholder: "Name")

        // Email TextField Setup
        setupTextField(emailTextField, placeholder: "Email")

        // Password TextField Setup
        setupTextField(passwordTextField, placeholder: "Password", isSecure: true)
        
        // Confirm Password TextField Setup
        setupTextField(confirmPasswordTextField, placeholder: "Confirm Password", isSecure: true)

        // Sign Up Button Setup
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.backgroundColor = .blue
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.shadowColor = UIColor.black.cgColor
        signUpButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        signUpButton.layer.shadowRadius = 4
        signUpButton.layer.shadowOpacity = 0.5
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(signUpButton)
        
        // Auto Layout Constraints
        setConstraints()
    }
    
    private func setupTextField(_ textField: UITextField, placeholder: String, isSecure: Bool = false) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = isSecure
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            
            createAccountLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30),
            createAccountLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 20),
            nameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            emailTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmPasswordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            confirmPasswordTextField.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor),
            
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 30),
            signUpButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signUpButton.widthAnchor.constraint(equalTo: confirmPasswordTextField.widthAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
