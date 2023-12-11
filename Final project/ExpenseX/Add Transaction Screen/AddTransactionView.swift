//
//  AddTransactionView.swift
//  ExpenseX
//
//  Created by 方泽堃 on 12/10/23.
//

import UIKit
import MapKit

class AddTransactionView: UIView {
    let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "0.00"
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        let dollarLabel = UILabel()
        dollarLabel.text = "$ "
        dollarLabel.font = textField.font
        textField.leftView = dollarLabel
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let categoryPicker = UIPickerView()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels // 设置为 wheels 样式，如果您希望用 compact 或 inline，可以修改
        return picker
    }()

    let categoryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Category"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Description"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let incomeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Income", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let expenseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Expense", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Pick your date"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = UIColor(red: 246/255.0, green: 237/255.0, blue: 220/255.0, alpha: 1)

        addSubview(amountTextField)
        addSubview(categoryTextField)
        addSubview(descriptionTextField)
        addSubview(incomeButton)
        addSubview(expenseButton)
        addSubview(dateTextField)
        addSubview(continueButton)
        addSubview(mapView)

        NSLayoutConstraint.activate([
            amountTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            amountTextField.centerXAnchor.constraint(equalTo: centerXAnchor),

            categoryTextField.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 30),
            categoryTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            categoryTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            descriptionTextField.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor, constant: 20),
            descriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            incomeButton.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20),
            incomeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            incomeButton.widthAnchor.constraint(equalToConstant: 100),
            incomeButton.heightAnchor.constraint(equalToConstant: 30),

            expenseButton.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20),
            expenseButton.leadingAnchor.constraint(equalTo: incomeButton.trailingAnchor, constant: 20),
            expenseButton.widthAnchor.constraint(equalToConstant: 100),
            expenseButton.heightAnchor.constraint(equalToConstant: 30),

            dateTextField.topAnchor.constraint(equalTo: incomeButton.bottomAnchor, constant: 20),
            dateTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dateTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 50),

            mapView.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 20),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mapView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

