//
//  FinancialEntryView.swift
//  APP12
//
//  Created by 孔祥睿 on 07/12/2023.
//

import Foundation
import UIKit
class FinancialEntryView: UIView {
        let iconImageView = UIImageView()
        let valueLabel = UILabel()
        private var heightConstraint: NSLayoutConstraint?

        // Assuming this is the original height of the FinancialEntryView
        private let originalHeight: CGFloat = 100 // Replace with the current original height

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
            setHeightConstraint()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupView()
            setHeightConstraint()
        }
    
    private func setHeightConstraint() {
            // Create a height constraint with the original height
            heightConstraint = heightAnchor.constraint(equalToConstant: originalHeight)
            heightConstraint?.isActive = true
        }
        
        func adjustHeight(additionalRem rem: CGFloat) {
            let remInPoints = rem * 16 // Convert rem to points
            // Deactivate the old height constraint
            heightConstraint?.isActive = false
            // Set the new height
            heightConstraint = heightAnchor.constraint(equalToConstant: originalHeight + remInPoints)
            heightConstraint?.isActive = true
            
            UIView.animate(withDuration: 0.3) {
                self.superview?.layoutIfNeeded() // Animate the change in height
            }
        }
    
    
    private func setupView() {
        // Set the corner radius to match the image
        layer.cornerRadius = 15
        // Enable masks to bounds for corner radius
        clipsToBounds = true
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(iconImageView)
        addSubview(valueLabel)
        
        // Set up iconImageView constraints
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 4),
            iconImageView.heightAnchor.constraint(equalToConstant: 4)
        ])
        
        // Set up valueLabel constraints
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        // Set the label properties to match the design
        valueLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        valueLabel.textColor = .white
        
        // Set up shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
        
        // Set placeholder properties for the icon and background color
        // These should be replaced with the actual properties you want
        iconImageView.image = UIImage(systemName: "bag.fill")
        backgroundColor = .green // Placeholder color
    }
    
    func configure(with model: EntryModel) {
        valueLabel.text = model.value
        iconImageView.image = model.icon
        backgroundColor = model.backgroundColor
    }
    
    struct EntryModel {
        let value: String
        let icon: UIImage?
        let backgroundColor: UIColor
    }
}
