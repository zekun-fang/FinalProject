//
//  ViewController.swift
//  APP12
//
//  Created by 方泽堃 on 11/19/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {

    let mainScreen = MainScreenView()
    
    var contactsList = [Contact]()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    
    let database = Firestore.firestore()
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScreen.continueButton.addTarget(self, action: #selector(dashboardButtonTapped), for: .touchUpInside)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                self.currentUser = nil
                
                //MARK: Reset tableView...
                self.contactsList.removeAll()
                //MARK: Sign in bar button...
            }else{
                //MARK: the user is signed in...
                self.currentUser = user
                //MARK: Logout bar button...
                
                //MARK: Observe Firestore database to display the contacts list...
                self.database.collection("users")
                    .document((self.currentUser?.email)!)
                    .collection("contacts")
                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                        if let documents = querySnapshot?.documents{
                            self.contactsList.removeAll()
                            for document in documents{
                                do{
                                    let contact  = try document.data(as: Contact.self)
                                    self.contactsList.append(contact)
                                }catch{
                                    print(error)
                                }
                            }
                            self.contactsList.sort(by: {$0.name < $1.name})
                        }
                    })
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    @objc func dashboardButtonTapped() {
        // Instantiate DashboardViewController and push it onto the navigation stack
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
    @objc func addContactButtonTapped(){
        let addContactController = AddContactViewController()
        addContactController.currentUser = self.currentUser
        navigationController?.pushViewController(addContactController, animated: true)
    }
    
}

