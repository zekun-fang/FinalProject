//
//  AccountScreenFirebaseManager.swift
//  ExpenseX
//
//  Created by 方泽堃 on 12/10/23.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

extension AccountInfoViewController{
    func uploadProfilePhotoToStorage(){
        var profilePhotoURL:URL?
        
        //MARK: Upload the profile photo if there is any...
        if let image = pickedImage{
            if let jpegData = image.jpegData(compressionQuality: 80){
                let storageRef = storage.reference()
                let imagesRepo = storageRef.child("imagesUsers")
                let imageRef = imagesRepo.child("\(NSUUID().uuidString).jpg")
                
                let uploadTask = imageRef.putData(jpegData, completion: {(metadata, error) in
                    if error == nil{
                        imageRef.downloadURL(completion: {(url, error) in
                            if error == nil{
                                profilePhotoURL = url
                                self.setPhotoOfTheUserInFirebaseAuth(photoURL: profilePhotoURL)
                                // After successful upload and fetching the updated image:
                                if let updatedImageURL = profilePhotoURL {
                                    self.delegate?.didUpdateProfilePhoto(updatedImageURL)
                                }
                                // After successfully uploading the profile photo and getting the new URL
                                let newProfilePhotoURL = profilePhotoURL
                                NotificationCenter.default.post(name: NSNotification.Name("ProfilePhotoUpdated"), object: nil, userInfo: ["profilePhotoURL": newProfilePhotoURL])
                            }
                        })
                    }
                })
            }
        }else{
        }
    }
    
    func setPhotoOfTheUserInFirebaseAuth(photoURL: URL?){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = photoURL
        
        print("\(photoURL)")
        changeRequest?.commitChanges(completion: {(error) in
            if error != nil{
                print("Error occured: \(String(describing: error))")
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
}

