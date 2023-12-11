import UIKit

class SpendingProgressView: UIView {
    
    private let categoryLabel = UILabel()
    private let amountLabel = UILabel()
    let progressBar = UIProgressView()
    
    var category: String = "" {
        didSet {
            categoryLabel.text = category
        }
    }
    
    var amount: Int = 0 {
        didSet {
            amountLabel.text = String(format: "%d", abs(amount))
        }
    }
    
    var progress: Float = 0 {
        didSet {
            progressBar.setProgress(progress, animated: true)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Set the background color to the specified RGBA values
        backgroundColor = UIColor(red: 246/255.0, green: 237/255.0, blue: 220/255.0, alpha: 1)

        addSubview(categoryLabel)
        addSubview(amountLabel)
        addSubview(progressBar)
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 4)
        ])
        
        categoryLabel.textColor = .black
        amountLabel.textColor = .red
        progressBar.progressTintColor = .orange
        progressBar.trackTintColor = .clear
        progressBar.layer.cornerRadius = 2
        progressBar.clipsToBounds = true
        
        // Set custom fonts if needed
        // categoryLabel.font = ...
        // amountLabel.font = ...
    }
    
    func configure(category: String, amount: Int, progress: Float) {
        self.category = category
        // 使用绝对值确保显示的金额总是正数
        self.amount = amount
        self.progress = progress
    }
}
