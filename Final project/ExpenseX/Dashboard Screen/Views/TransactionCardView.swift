import UIKit

class TransactionCardView: UIView {
    private let transactionIconImageView = UIImageView()
    private let transactionAmountLabel = UILabel()
    private let transactionCategoryLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        // Add subviews
        addSubview(transactionIconImageView)
        addSubview(transactionAmountLabel)
        addSubview(transactionCategoryLabel)
        
        applyStyling()
        setupConstraints()
    }

    private func applyStyling() {
        // Style the transaction amount label
        transactionAmountLabel.font = UIFont.boldSystemFont(ofSize: 18)
        transactionAmountLabel.textColor = .black
        
        // Style the transaction category label
        transactionCategoryLabel.font = UIFont.systemFont(ofSize: 16)
        transactionCategoryLabel.textColor = .gray
        backgroundColor = .clear 
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }

    private func setupConstraints() {
        transactionIconImageView.translatesAutoresizingMaskIntoConstraints = false
        transactionAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        transactionCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Icon constraints
            transactionIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            transactionIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            transactionIconImageView.widthAnchor.constraint(equalToConstant: 24),
            transactionIconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            // Amount label constraints
            transactionAmountLabel.leadingAnchor.constraint(equalTo: transactionIconImageView.trailingAnchor, constant: 8),
            transactionAmountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Category label constraints
            transactionCategoryLabel.leadingAnchor.constraint(equalTo: transactionAmountLabel.trailingAnchor, constant: 8),
            transactionCategoryLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -12),
            transactionCategoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    func configure(with transaction: Transaction) {
           transactionAmountLabel.text = "₹ \(transaction.amount)"
           transactionCategoryLabel.text = transaction.category
           
           let iconName = transaction.isIncome ? "arrow.up.circle.fill" : "arrow.down.circle.fill"
           transactionIconImageView.image = UIImage(systemName: iconName)
           transactionIconImageView.tintColor = transaction.isIncome ? .green : .red

           // Set the background color based on transaction type
           self.backgroundColor = transaction.isIncome ? UIColor(red: 193/255.0, green: 184/255.0, blue: 185/255.0, alpha: 1) : UIColor(red: 217/255.0, green: 217/255.0, blue: 217/255.0, alpha: 1)
       }
}

// Assuming you have a Transaction struct defined somewhere
struct Transaction {
    let amount: Double
    let category: String
    let isIncome: Bool
}
