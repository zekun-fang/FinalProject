//
//  RegisterFirebaseManager.swift
//  APP12
//
//  Created by 方泽堃 on 11/20/23.
//

import Foundation
import FirebaseAuth

extension RegisterViewController{
    
    func registerNewAccount(){
        //MARK: display the progress indicator...
        showActivityIndicator()
        //MARK: create a Firebase user with email and password...
        if let name = registerView.nameTextField.text,
           let email = registerView.emailTextField.text,
           let password = registerView.passwordTextField.text{
            print("Password Length: \(password.count)")
            //Validations....
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    //MARK: the user creation is successful...
                    self.setNameOfTheUserInFirebaseAuth(name: name)
                }else{
                    //MARK: there is a error creating the user...
                    print(error)
                    self.showAlert(message: "There is a error creating the user.")
                    self.hideActivityIndicator()
                }
            })
        }
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(name: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                
                //MARK: hide the progress indicator...
                self.hideActivityIndicator()
                
                let dashboardVC = DashboardViewController()
                self.navigationController?.pushViewController(dashboardVC, animated: true)
            }else{
                //MARK: there was an error updating the profile...
                print("Error occured: \(String(describing: error))")
            }
        })
    }
}
