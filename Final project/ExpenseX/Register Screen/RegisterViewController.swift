import UIKit

class RegisterViewController: UIViewController {
    
    let registerView = RegisterView()
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let registerView = view as? RegisterView {
            registerView.signUpButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        }
    }

    @objc func signUpAction() {
        guard let registerView  = view as? RegisterView else { return }

        // Validate name
        guard let name = registerView.nameTextField.text, !name.isEmpty else {
            showAlert(message: "Please enter your name.")
            return
        }

        // Validate email
        guard let email = registerView.emailTextField.text, isValidEmail(email) else {
            showAlert(message: "Please enter a valid email address.")
            return
        }

        // Validate password
        guard let password = registerView.passwordTextField.text, isValidPassword(password) else {
            showAlert(message: "Password must be at least 6 characters.")
            return
        }
        
        // Validate confirm password
        guard let confirmPassword = registerView.confirmPasswordTextField.text, confirmPassword == password else {
            showAlert(message: "Passwords do not match.")
            return
        }

        //MARK: creating a new user on Firebase...
        registerNewAccount()
    }
    
    // Utility Functions for validation and alert
    // Same as provided in the previous example for LoginViewController
    
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


