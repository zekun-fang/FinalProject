//
//  AddTransactionViewController.swift
//  ExpenseX
//
//  Created by 方泽堃 on 12/10/23.
//

import UIKit
import CoreLocation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AddTransactionViewController: UIViewController, CLLocationManagerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    private var addTransactionView: AddTransactionView!
    private var isIncome = false
    private let locationManager = CLLocationManager()
    private let categories = ["Food", "Transport", "Entertainment", "Utilities", "Other"]
    
    let childProgressView = ProgressSpinnerViewController()
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()

    override func loadView() {
        addTransactionView = AddTransactionView()
        view = addTransactionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Transaction"
        setupActions()
        setupCategoryPicker()
        setupDatePicker()
    }

    private func setupActions() {
        addTransactionView.incomeButton.addTarget(self, action: #selector(incomeButtonTapped), for: .touchUpInside)
        addTransactionView.expenseButton.addTarget(self, action: #selector(expenseButtonTapped), for: .touchUpInside)
        addTransactionView.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }

    @objc private func incomeButtonTapped() {
        isIncome = true
        updateButtonSelection()
    }

    @objc private func expenseButtonTapped() {
        isIncome = false
        updateButtonSelection()
    }

    private func updateButtonSelection() {
        addTransactionView.incomeButton.backgroundColor = isIncome ? .green : .lightGray
        addTransactionView.expenseButton.backgroundColor = isIncome ? .lightGray : .red
    }

    @objc private func continueButtonTapped() {
        guard let amountString = addTransactionView.amountTextField.text,
              !amountString.isEmpty, // 确保金额不为空
              let amount = Double(amountString), // 尝试将输入转换为 Double
              let category = addTransactionView.categoryTextField.text,
              let description = addTransactionView.descriptionTextField.text else {
            
            // 如果输入无效或金额为空，显示一个警告框
            showAlert(title: "Invalid Input", message: "Please enter a valid amount")
            return
        }

        let date = addTransactionView.datePicker.date
        let transaction = Transaction(amount: amount, category: category, isIncome: isIncome, description: description, date: date)
        
        saveTransactionToFireStore(transaction: transaction)
    }

    // 显示警告框的方法
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }


    //MARK: logic to add a transaction to Firestore...
    func saveTransactionToFireStore(transaction: Transaction){
        if let userEmail = currentUser!.email{
            let collectionTransactions = database
                .collection("users")
                .document(userEmail)
                .collection("transactions")
            
            //MARK: show progress indicator...
            showActivityIndicator()
            
            do{
                try collectionTransactions.addDocument(from: transaction, completion: {(error) in
                    if error == nil{
                        //MARK: hide progress indicator...
                        self.hideActivityIndicator()
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                })
            }catch{
                print("Error adding document!")
            }
        }
    }
    
    private func setupCategoryPicker() {
        addTransactionView.categoryPicker.dataSource = self
        addTransactionView.categoryPicker.delegate = self
        addTransactionView.categoryTextField.inputView = addTransactionView.categoryPicker
    }

    private func setupDatePicker() {
        // Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        // Bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
        toolbar.setItems([doneButton], animated: true)

        // Assign datepicker to textfield
        addTransactionView.dateTextField.inputAccessoryView = toolbar
        addTransactionView.dateTextField.inputView = addTransactionView.datePicker
    }

    @objc private func didTapDone() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        addTransactionView.dateTextField.text = formatter.string(from: addTransactionView.datePicker.date)
        view.endEditing(true)
    }

    // UIPickerView DataSource and Delegate methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        addTransactionView.categoryTextField.text = categories[row]
        view.endEditing(true)
    }
}

//MARK: adopting progress indicator protocol...
extension AddTransactionViewController:ProgressSpinnerDelegate{
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
