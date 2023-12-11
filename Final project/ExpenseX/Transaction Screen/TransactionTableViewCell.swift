import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    static let identifier = "TransactionTableViewCell"
    // UI components for the cell
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cardPaddingView: UIView = {
            let view = UIView()
            view.backgroundColor = .clear
            return view
        }()
    
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Initialization code
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        self.contentView.layer.cornerRadius = 20
        
        // 设置单元格的内边距
        self.contentView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        setupSubviews()
        applyConstraints()
        setupCell()
    }
    
    private func setupCell() {
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.white.cgColor // 设置边框颜色为白色
        contentView.clipsToBounds = true  // This is crucial to make the cor
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(cardPaddingView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(amountLabel)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
                    cardPaddingView.heightAnchor.constraint(equalToConstant: 80), // 上下间距为20
                    cardPaddingView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    cardPaddingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    cardPaddingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                ])
        NSLayoutConstraint.activate([
                categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                categoryLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),

                descriptionLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4),
                descriptionLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
                descriptionLabel.trailingAnchor.constraint(equalTo: categoryLabel.trailingAnchor),
                
                timeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
                timeLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
                timeLabel.trailingAnchor.constraint(equalTo: categoryLabel.trailingAnchor),
                
                amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                
                // Adjust the bottom anchor of the contentView to the bottom of the last label
                contentView.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16)
            ])
        contentView.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20).isActive = true
    }
    
    public func configure(with transaction: Transaction) {
        categoryLabel.text = transaction.category
        descriptionLabel.text = transaction.description
        amountLabel.text = transaction.isIncome ? "+\(transaction.amount)" : "-\(transaction.amount)"
        amountLabel.textColor = transaction.isIncome ? .systemGreen : .systemRed

        // 设置日期格式器
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // 或者任何您需要的格式
        timeLabel.text = dateFormatter.string(from: transaction.date)
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = nil
        descriptionLabel.text = nil
        timeLabel.text = nil
        amountLabel.text = nil
    }
}
