//
//  LoginViewController.swift
//  ExpenseX
//
//  Created by 方泽堃 on 12/9/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = LoginView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        if let loginView = view as? LoginView {
            loginView.signInButton.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
            loginView.signUpButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        }
    }

    @objc func signInAction() {
        guard let loginView = view as? LoginView else { return }

        // Validate email
        if let email = loginView.emailTextField.text, isValidEmail(email) {
            // Email is valid
        } else {
            // Handle invalid email
            showAlert(message: "Please enter a valid email address.")
            return
        }

        // Validate password
        if let password = loginView.passwordTextField.text, isValidPassword(password) {
            // Password is valid, proceed with sign in
            // ...
        } else {
            // Handle invalid password
            showAlert(message: "Password must be at least 6 characters.")
            return
        }

        // Proceed with authentication or other sign in logic
        if let email = loginView.emailTextField.text,
           let password = loginView.passwordTextField.text{
            //MARK: sign-in logic for Firebase...
            self.signInToFirebase(email: email, password: password)
            
        }
    }
    
    func signInToFirebase(email: String, password: String){
        //MARK: can you display progress indicator here?
        showActivityIndicator()
        //MARK: authenticating the user...
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error == nil{
                //MARK: user authenticated...move to Dashboard Screen
                //MARK: can you hide the progress indicator here?
                self.hideActivityIndicator()
                let dashboardVC = DashboardViewController()
                self.navigationController?.pushViewController(dashboardVC, animated: true)
            }else{
                //MARK: alert that no user found or password wrong...
                self.showAlert(message: "There's no user found or password wrong.")
                self.hideActivityIndicator()
            }
        })
    }
    
    @objc func signUpAction() {
        // Navigate to the Sign Up screen
        let registerViewController = RegisterViewController() // Replace with your sign-up view controller
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

    

