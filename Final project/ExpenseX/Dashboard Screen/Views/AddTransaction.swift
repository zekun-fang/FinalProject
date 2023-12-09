//
//  AddTransaction.swift
//  APP12
//
//  Created by 孔祥睿 on 07/12/2023.
//

import Foundation
import UIKit
import MapKit
import CoreLocation


class AddTransactionViewController:  UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CLLocationManagerDelegate {
    private let categoryPicker = UIPickerView()
    private let categories = ["Food", "Transport", "Entertainment", "Utilities", "Other"]
    private let datePicker: UIDatePicker = {
            let picker = UIDatePicker()
            picker.datePickerMode = .date // or .time or .dateAndTime
            picker.preferredDatePickerStyle = .wheels // or .compact or .inline based on your UI preference
            return picker
        }()
    // 创建UI组件
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "₹ 55698"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()

    
    
    private let categoryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Category"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Description"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let incomeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Income", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let expenseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Expense", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Pick your date"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          if let location = locations.first {
              let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
              let region = MKCoordinateRegion(center: location.coordinate, span: span)
              mapView.setRegion(region, animated: true)
          }
      }

      func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
          // 处理授权状态变化
      }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Transaction"
        setupViews()
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // 请求用户权限
        locationManager.startUpdatingLocation() // 开始更新位置
        setupCategoryPicker()
        mapView.showsUserLocation = true // 显示用户位置
        setupDatePicker()
        view.backgroundColor = UIColor(red: 246/255.0, green: 237/255.0, blue: 220/255.0, alpha: 1)
    }
    
    private func setupDatePicker() {
            // Toolbar
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            // Bar button item
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
            toolbar.setItems([doneButton], animated: true)

            // Assign datepicker to textfield
            dateTextField.inputAccessoryView = toolbar
            dateTextField.inputView = datePicker
        }

        @objc private func didTapDone() {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none // or .short if you included time in your datePickerMode

            dateTextField.text = formatter.string(from: datePicker.date)
            view.endEditing(true)
        }
    
    
    private func setupViews() {
        view.backgroundColor = .white
        incomeButton.addTarget(self, action: #selector(incomeButtonTapped), for: .touchUpInside)
        expenseButton.addTarget(self, action: #selector(expenseButtonTapped), for: .touchUpInside)

        // 将组件添加到视图
        view.addSubview(amountLabel)
        view.addSubview(categoryTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(incomeButton)
        view.addSubview(expenseButton)
        view.addSubview(dateTextField)
        view.addSubview(continueButton)
        view.addSubview(mapView)
        
        // 设置约束
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            amountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            categoryTextField.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 30),
            categoryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionTextField.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor, constant: 20),
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            incomeButton.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20),
            incomeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            incomeButton.widthAnchor.constraint(equalToConstant: 100),
            incomeButton.heightAnchor.constraint(equalToConstant: 30),
            
            expenseButton.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20),
            expenseButton.leadingAnchor.constraint(equalTo: incomeButton.trailingAnchor, constant: 20),
            expenseButton.widthAnchor.constraint(equalToConstant: 100),
            expenseButton.heightAnchor.constraint(equalToConstant: 30),
            
            dateTextField.topAnchor.constraint(equalTo: incomeButton.bottomAnchor, constant: 20),
            dateTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            mapView.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 20),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mapView.heightAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    private func setupCategoryPicker() {
            categoryPicker.dataSource = self
            categoryPicker.delegate = self
            categoryTextField.inputView = categoryPicker
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
            categoryTextField.text = categories[row]
            view.endEditing(true)
        }

        @objc private func incomeButtonTapped() {
            descriptionTextField.text = "Income \(categoryTextField.text ?? "")"
        }
        
        @objc private func expenseButtonTapped() {
            descriptionTextField.text = "Expense \(categoryTextField.text ?? "")"
        }
    
    @objc private func continueButtonTapped() {
        // 处理继续按钮点击事件
    }
    
}

