// RegisterViewController.swift
import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {

    let registerView = RegisterView()
    let childProgressView = ProgressSpinnerViewController()

    override func loadView() {
        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        registerView.buttonRegister.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        title = "Register"
    }

    @objc func onRegisterTapped() {
        guard let name = registerView.textFieldName.text, !name.isEmpty,
              let email = registerView.textFieldEmail.text, !email.isEmpty,
              let password = registerView.textFieldPassword.text, !password.isEmpty else {
            displayAlert(message: "Please fill in all fields")
            return
        }

        if !isValidEmail(email) {
            displayAlert(message: "Invalid email format")
            return
        }

        if password.count < 6 {
            displayAlert(message: "Password should be at least 6 characters")
            return
        }

        registerNewAccount(name: name, email: email, password: password)
    }

    func registerNewAccount(name: String, email: String, password: String) {
        showActivityIndicator()

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }

            self.hideActivityIndicator()
            
            if let error = error {
                self.displayAlert(message: "Error: \(error.localizedDescription)")
                return
            }

            self.setNameOfTheUserInFirebaseAuth(name: name)
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    func displayAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
