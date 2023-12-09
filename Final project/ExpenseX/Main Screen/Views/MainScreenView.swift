//
//  MainScreenView.swift
//  APP12
//
//  Created by 方泽堃 on 11/20/23.
//

import UIKit

class MainScreenView: UIView {
    
    // UI elements that will be visible on this screen
    var coinJarImageView: UIImageView!
    var budgetSolutionLabel: UILabel!
    var continueButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white // Set the background color to pink
        
        setupCoinJarImageView()
        setupBudgetSolutionLabel()
        setupContinueButton()
        setupConstraints()
    }

    
    // Method to setup the coin jar image view
    private func setupCoinJarImageView() {
        coinJarImageView = UIImageView(image: UIImage(named: "img"))
        coinJarImageView.contentMode = .scaleAspectFill // or .scaleAspectFit
        coinJarImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(coinJarImageView)
        roundTopCornersOfImageView() // Make sure this function only rounds the top corners
    }

    
    // Method to setup the budget solution label
    private func setupBudgetSolutionLabel() {
        budgetSolutionLabel = UILabel()

        // Configure the paragraph style for the main text
        let mainParagraphStyle = NSMutableParagraphStyle()
        mainParagraphStyle.alignment = .justified
        mainParagraphStyle.paragraphSpacing = 20 // This is the space after the main text. Adjust as needed.

        // Configure the paragraph style for the subtitle text
        let subtitleParagraphStyle = NSMutableParagraphStyle()
        subtitleParagraphStyle.alignment = .justified
        subtitleParagraphStyle.paragraphSpacingBefore = 11 // This is the space before the subtitle text.

        // Configure the main text
        let mainText = "Simple solution for your budget."
        let mainAttributedString = NSMutableAttributedString(string: mainText, attributes: [
            .font: UIFont.boldSystemFont(ofSize: 32),
            .foregroundColor: UIColor.black,
            .paragraphStyle: mainParagraphStyle
        ])
        
        // Add a newline character to separate the main text from the subtitle
        let newlineString = NSAttributedString(string: "\n", attributes: [.paragraphStyle: mainParagraphStyle])
        mainAttributedString.append(newlineString)

        // Configure the subtitle text
        let subtitleText = "Counter and distribute the income correctly..."
        let subtitleAttributedString = NSAttributedString(string: subtitleText, attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.black,
            .paragraphStyle: subtitleParagraphStyle
        ])
        
        // Combine the attributed strings
        mainAttributedString.append(subtitleAttributedString)
        
        // Assign the combined attributed string to the label
        budgetSolutionLabel.attributedText = mainAttributedString
        budgetSolutionLabel.numberOfLines = 0
        budgetSolutionLabel.textAlignment = .justified
        budgetSolutionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(budgetSolutionLabel)
    }

    
    // Method to setup the continue button
    private func setupContinueButton() {
        continueButton = UIButton(type: .system)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        continueButton.backgroundColor = .black
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.layer.cornerRadius = 25
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(continueButton)
    }
    private func roundTopCornersOfImageView() {
        let path = UIBezierPath(roundedRect: coinJarImageView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 25.0, height: 25.0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        coinJarImageView.layer.mask = maskLayer
        coinJarImageView.layer.masksToBounds = true
    }


    
    // Method to setup constraints for all UI elements
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Constraints for coinJarImageView
            coinJarImageView.topAnchor.constraint(equalTo: topAnchor),
            coinJarImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coinJarImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coinJarImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),

            budgetSolutionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            budgetSolutionLabel.topAnchor.constraint(equalTo: coinJarImageView.bottomAnchor, constant: 121), // 3 rem top margin
            budgetSolutionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50), // 2 rem leading margin
            budgetSolutionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -34), // 2 rem trailing margin
                   // Constraints for continueButton
            continueButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        roundTopCornersOfImageView()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
