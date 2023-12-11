import UIKit
import FirebaseAuth
import PhotosUI
import FirebaseStorage

class AccountInfoViewController: UIViewController {

    weak var delegate: AccountInfoViewControllerDelegate?
    
    let accountInfoView = AccountInfoView()
    
    //MARK: variable to store the picked Image...
    var pickedImage:UIImage?
    
    let storage = Storage.storage()

    override func loadView() {
        view = accountInfoView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let currentUser = Auth.auth().currentUser {
            accountInfoView.userEmail = currentUser.email
            accountInfoView.userID = currentUser.uid
            accountInfoView.currentUserName = currentUser.displayName
        }

        NotificationCenter.default.addObserver(self, selector: #selector(handleNameChange), name: NSNotification.Name("ChangeNameNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleLabelPhotoTap), name: NSNotification.Name("LabelPhotoTapped"), object: nil)
        
        accountInfoView.buttonTakePhoto.menu = getMenuImagePicker()
    }
    
    @objc private func handleLabelPhotoTap() {
        let alert = UIAlertController(title: "Submit Photo", message: "Are you sure you want to submit this photo?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Submit", style: .default) { [weak self] _ in
            self?.uploadProfilePhotoToStorage()
            self?.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }
    
    //MARK: menu for buttonTakePhoto setup...
    func getMenuImagePicker() -> UIMenu{
        let menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    //MARK: take Photo using Camera...
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    //MARK: pick Photo using Gallery...
    func pickPhotoFromGallery(){
        //MARK: Photo from Gallery...
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    @objc func handleNameChange() {
        // Handle the name change action, e.g., show an alert to change the name
        let alert = UIAlertController(title: "Change Name", message: "Enter your new name", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "New name"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let newName = alert.textFields?.first?.text else { return }
            // Here, implement the logic to update the user's name in Firebase
            self?.updateUserName(newName: newName)
        })
        present(alert, animated: true)
    }

    private func updateUserName(newName: String) {
        guard let currentUser = Auth.auth().currentUser else { return }

        let changeRequest = currentUser.createProfileChangeRequest()
        changeRequest.displayName = newName
        changeRequest.commitChanges { [weak self] error in
            if let error = error {
                print("Error updating name: \(error.localizedDescription)")
            } else {
                // After successful Firebase update
                self?.accountInfoView.currentUserName = newName
                self?.delegate?.didUpdateUserName(newName: newName)
                self?.accountInfoView.tableView.reloadData()
            }
        }
    }


    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

protocol AccountInfoViewControllerDelegate: AnyObject {
    func didUpdateUserName(newName: String)
    func didUpdateProfilePhoto(_ profilePhotoURL:URL)
}
