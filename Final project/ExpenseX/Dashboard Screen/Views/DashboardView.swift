import UIKit


class DashboardView: UIView, UITabBarDelegate{
    
    
    // UI Elements
        let dateLabel = UILabel()
        let nameLabel = UILabel()
        let accountBalanceLabel = UILabel()
    let incomeModel = FinancialEntryView.EntryModel(value: "25000", icon: UIImage(named: "incomeIcon"), backgroundColor: .systemGreen)
    let expensesModel = FinancialEntryView.EntryModel(value: "11200", icon: UIImage(named: "expensesIcon"), backgroundColor: .systemRed)

    let incomeLabel = FinancialEntryView()
    let expensesLabel = FinancialEntryView()

        let transactionFilterSegmentedControl = UISegmentedControl(items: ["Today", "Week", "Month", "Year"])
        let recentTransactionsLabel = UILabel()
        let viewAllButton = UIButton()
        let navigationBar = UITabBar() // Simplified representation of a bottom navigation bar
        let addTransactionButton = UIButton()
        let avatarImageView = UIImageView() // Added avatar image view
        let horizontalLineView = UIView()
        let transactionsContainer = UIStackView()
        let cardView = UIView()
        let accountBalanceTitleLabel = UILabel()

    var onTransactionButtonTapped: (() -> Void)?
    // Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardView()
        styleAccountBalanceTitleLabel()
        setupDashboardView()
        incomeLabel.configure(with: incomeModel)
        expensesLabel.configure(with: expensesModel)
        backgroundColor = UIColor(red: 167/255.0, green: 150/255.0, blue: 152/255.0, alpha: 1) // Updated background color
        addTransactionButton.addTarget(self, action: #selector(transactionButtonTapped), for: .touchUpInside)
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCardView()
        styleAccountBalanceTitleLabel()
        setupDashboardView()
        backgroundColor = UIColor(red: 167/255.0, green: 150/255.0, blue: 152/255.0, alpha: 1) // Updated background color
        avatarImageView.image = UIImage(named: "fallbackImage") // Replace with any image from your assets
        addTransactionButton.addTarget(self, action: #selector(transactionButtonTapped), for: .touchUpInside)

    }
  
    
    private func styleAccountBalanceTitleLabel() {
        accountBalanceTitleLabel.font = UIFont.systemFont(ofSize: 16) // Adjust the font size as needed
        accountBalanceTitleLabel.textColor = .darkGray // Adjust the text color as needed
        accountBalanceTitleLabel.textAlignment = .center
    }
    
    

    
    private func setupCardView() {
        // Add the cardView to self first
        addSubview(cardView)
        cardView.backgroundColor = UIColor(red: 235/255.0, green: 226/255.0, blue: 210/255.0, alpha: 1)
        cardView.layer.cornerRadius = 20
        cardView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews to the cardView
        cardView.addSubview(dateLabel)
        cardView.addSubview(nameLabel)
        cardView.addSubview(accountBalanceLabel)
        cardView.addSubview(incomeLabel)
        cardView.addSubview(expensesLabel)
        
    }
        
    
    // Setup the dashboard view
    private func setupDashboardView() {
           // Add all subviews
           addSubview(dateLabel)
           addSubview(nameLabel)
           addSubview(accountBalanceLabel)
           addSubview(incomeLabel)
           addSubview(expensesLabel)
           addSubview(transactionFilterSegmentedControl)
           addSubview(recentTransactionsLabel)
           addSubview(viewAllButton)
           addSubview(navigationBar)
           addSubview(addTransactionButton)
           addSubview(avatarImageView) // Add the avatar image view to the view hierarchy
           addSubview(horizontalLineView) // Add the horizontal line view to the view hierarchy
           addSubview(accountBalanceTitleLabel)
            cardView.addSubview(dateLabel)
            cardView.addSubview(nameLabel)
           // Style and layout all subviews
           styleDateLabel()
           styleNameLabel()
           styleAccountBalanceLabel()
           styleIncomeLabel()
           styleExpensesLabel()
           styleTransactionFilterSegmentedControl()
           styleRecentTransactionsLabel()
           styleViewAllButton()
           styleNavigationBar()
           styleAddTransactionButton()
           styleAvatarImageView() // Apply styles to the avatarImageView
           styleHorizontalLineView() // Apply styles to the horizontalLineView
           setupAutoLayoutConstraints()
           setupTransactionsContainer()
           layoutSubviewsManually() // Update this method to handle the new views
       }

    private func setupTransactionsContainer() {
          transactionsContainer.axis = .vertical
          transactionsContainer.spacing = 8
          transactionsContainer.distribution = .fill
          transactionsContainer.alignment = .fill

          addSubview(transactionsContainer)

          // Set up constraints for transactionsContainer
          transactionsContainer.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              transactionsContainer.topAnchor.constraint(equalTo: recentTransactionsLabel.bottomAnchor, constant: 20),
              transactionsContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
              transactionsContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
              // Comment out the bottom anchor constraint if you want the stack view to grow with its content
              // transactionsContainer.bottomAnchor.constraint(equalTo: navigationBar.topAnchor, constant: -20)
          ])
        UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        
      }
        
    // MARK: - Style Functions
    private func styleDateLabel() {
            dateLabel.text = "MONDAY 9 NOVEMBER"
            dateLabel.font = UIFont.systemFont(ofSize: 16)
            dateLabel.textAlignment = .left
            addSubview(dateLabel)
        }
    
    private func styleAvatarImageView() {
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 20 // Adjust as needed
        avatarImageView.clipsToBounds = true
        avatarImageView.backgroundColor = .blue // Temporary background color to ensure visibility
        avatarImageView.image = UIImage(systemName: "person.circle")

        // Debugging: Check if the UIImage is correctly formed from the system name
        if avatarImageView.image == nil {
            print("System image didn't load. This could be due to a lower iOS version.")
        }
    }

    
    private func setupAutoLayoutConstraints() {
        // Disable autoresizing mask translation for all subviews

        let padding: CGFloat = 16.0
        let remValue: CGFloat = 200.0
        let incomeLabelHeightConstraint = incomeLabel.heightAnchor.constraint(equalToConstant: padding + (5 * 16))
        incomeLabelHeightConstraint.isActive = true
        let expensesLabelHeightConstraint = expensesLabel.heightAnchor.constraint(equalToConstant: padding + (5 * 16)) //
        expensesLabelHeightConstraint.isActive = true
        // Define the constraints for all the subviews
        NSLayoutConstraint.activate([
            // Date label constraints
            horizontalLineView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            horizontalLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            horizontalLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            horizontalLineView.heightAnchor.constraint(equalToConstant: 1),
            transactionFilterSegmentedControl.topAnchor.constraint(equalTo: horizontalLineView.bottomAnchor, constant: 180), // Moved down by 6rem
            transactionFilterSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 200),
            transactionFilterSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 80),
            recentTransactionsLabel.topAnchor.constraint(equalTo: transactionFilterSegmentedControl.bottomAnchor, constant: padding),
        ])
        
        NSLayoutConstraint.activate([
            incomeLabel.topAnchor.constraint(equalTo: accountBalanceLabel.bottomAnchor, constant: 1),
            incomeLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: padding),
            incomeLabel.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.45, constant: -1),
            incomeLabel.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.15, constant: 10),
            incomeLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -5)

        ])

                // Expenses Label constraints
        NSLayoutConstraint.activate([
            expensesLabel.topAnchor.constraint(equalTo: accountBalanceLabel.bottomAnchor, constant: padding),
            expensesLabel.leadingAnchor.constraint(equalTo: incomeLabel.trailingAnchor, constant: padding),
            expensesLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -padding)
        ])
        
        // CardView constraints
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: expensesLabel.bottomAnchor, constant: 200)
            ])

        // Date label constraints
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: avatarImageView.leadingAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
                accountBalanceTitleLabel.bottomAnchor.constraint(equalTo: accountBalanceLabel.topAnchor, constant: -8), // 8 points above account balance label
                accountBalanceTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                accountBalanceTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // Avatar ImageView constraints
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 65),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40)
        ])

        // Name label constraints
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -padding)
        ])

        // Account Balance Label constraints
        NSLayoutConstraint.activate([
            accountBalanceLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: padding+50),
            accountBalanceLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: padding),
            accountBalanceLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -padding)
        ])

        NSLayoutConstraint.activate([
                // Move transactionFilterSegmentedControl down by 6rem from the bottom of the cardView
                transactionFilterSegmentedControl.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: remValue),
                transactionFilterSegmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
                transactionFilterSegmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),

                // Position recentTransactionsLabel below transactionFilterSegmentedControl
                recentTransactionsLabel.topAnchor.constraint(equalTo: transactionFilterSegmentedControl.bottomAnchor, constant: padding),
                recentTransactionsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
                recentTransactionsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            ])
        self.layoutIfNeeded()
        cardView.layer.cornerRadius = 20
        cardView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                
    }

    

    @objc func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // 根据选中的标签项执行不同的逻辑
        switch item.title {
        case "Home":
            // 处理 Home 标签的逻辑
            print("Home tab selected")
        case "Transaction":
            // 处理 Transaction 标签的逻辑
            print("Transactions tab selected")
        case "Statistics":
            // 处理 Statistics 标签的逻辑
            print("Statistics tab selected")
        case "Profile":
            // 处理 Profile 标签的逻辑
            print("Profile tab selected")
        default:
            break
        }
    }
    
    
    private func styleNameLabel() {
            nameLabel.text = "VISHNU"
            nameLabel.font = UIFont.systemFont(ofSize: 16)
            nameLabel.textAlignment = .right
            addSubview(nameLabel)
        }
    
    private func styleAccountBalanceLabel() {
        accountBalanceLabel.text = "9400.0"
        accountBalanceLabel.font = UIFont.boldSystemFont(ofSize: 32)
        accountBalanceLabel.textAlignment = .center
        addSubview(accountBalanceLabel)
    }
    
    private func styleIncomeLabel() {
        incomeLabel.valueLabel.text = "25000"
            incomeLabel.iconImageView.image = UIImage(systemName: "arrow.down.circle") // Use your own asset
            addSubview(incomeLabel)

    }
    
    private func styleExpensesLabel() {
        expensesLabel.valueLabel.text = "11200"
        expensesLabel.iconImageView.image = UIImage(systemName: "arrow.up.circle") // Use your own asset
        addSubview(expensesLabel)
    }
    
    private func styleTransactionFilterSegmentedControl() {
        transactionFilterSegmentedControl.selectedSegmentIndex = 0
        addSubview(transactionFilterSegmentedControl)
    }
    
    private func styleRecentTransactionsLabel() {
        recentTransactionsLabel.text = "Recent Transactions"
        addSubview(recentTransactionsLabel)
        addSubview(transactionCard)
    }
    
    private func styleViewAllButton() {
        viewAllButton.setTitle("View All", for: .normal)
        viewAllButton.setTitleColor(.black, for: .normal)
        addSubview(viewAllButton)
    }
    

    
    
    private func styleNavigationBar() {
        // 创建 UITabBarItem 实例
        let homeItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        homeItem.tag = 0

        let transactionItem = UITabBarItem(title: "Transaction", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet.fill"))
        transactionItem.tag = 1

        let statsItem = UITabBarItem(title: "Statistics", image: UIImage(systemName: "chart.bar"), selectedImage: UIImage(systemName: "chart.bar.fill"))
        statsItem.tag = 2

        let profileItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        profileItem.tag = 3

        // 将这些项添加到 navigationBar
        navigationBar.items = [homeItem, transactionItem, statsItem, profileItem]

        // 设置 Home 按钮为选中状态
        navigationBar.selectedItem = homeItem

        // 设置选中标签的颜色
        let selectedColor = UIColor(red: 126/255.0, green: 62/255.0, blue: 255/255.0, alpha: 1)
        navigationBar.tintColor = selectedColor
        // 为选中状态的标题文本设置颜色
        let attributes = [NSAttributedString.Key.foregroundColor: selectedColor]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .selected)
        addSubview(navigationBar)
        navigationBar.delegate = self
    }
    


    private func styleAddTransactionButton() {
        addTransactionButton.setTitle("+", for: .normal)
        addTransactionButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        
        // Set the background color using RGBA values
        addTransactionButton.backgroundColor = UIColor(red: 126/255.0, green: 62/255.0, blue: 255/255.0, alpha: 1)

        // Set the button to be circular
        addTransactionButton.layer.cornerRadius = 30 // Half of the height and width to make it a perfect circle
        
        addSubview(addTransactionButton)
    }

    
    private func styleHorizontalLineView() {
            horizontalLineView.backgroundColor = .black
        }
    
    
    // MARK: - Layout Functions
    private func layoutSubviewsManually() {
        let viewWidth = self.bounds.width
        let padding: CGFloat = 16.0
        let labelHeight: CGFloat = 22.0
        let largeLabelHeight: CGFloat = 44.0
        let navigationBarHeight: CGFloat = 50.0
        let buttonHeight: CGFloat = 44.0
        let segmentedControlHeight: CGFloat = 32.0
        let additionalOffset: CGFloat = 80.0 // 5rem assuming 1rem = 16pts

        // Layout dateLabel and nameLabel at the top
        dateLabel.frame = CGRect(x: padding, y: padding, width: (viewWidth - 3 * padding) / 2, height: labelHeight)
        nameLabel.frame = CGRect(x: dateLabel.frame.maxX + padding, y: padding, width: (viewWidth - 3 * padding) / 2, height: labelHeight)

        // Layout accountBalanceLabel below the dateLabel and nameLabel
        accountBalanceLabel.frame = CGRect(x: padding, y: dateLabel.frame.maxY + padding, width: viewWidth - 2 * padding, height: largeLabelHeight)

        // Layout incomeLabel and expensesLabel side by side below the accountBalanceLabel
        incomeLabel.frame = CGRect(x: padding, y: accountBalanceLabel.frame.maxY + 60, width: (viewWidth - 3 * 20) / 2, height: 100)
        expensesLabel.frame = CGRect(x: incomeLabel.frame.maxX + padding, y: accountBalanceLabel.frame.maxY + 60, width: (viewWidth - 3 * 20) / 2, height: 100)

        // Layout transactionFilterSegmentedControl below the incomeLabel and expensesLabel
        // Increased y position by additionalOffset
        transactionFilterSegmentedControl.frame = CGRect(x: padding, y: incomeLabel.frame.maxY + 60 + additionalOffset, width: viewWidth - 2 * padding, height: segmentedControlHeight)

        // Layout recentTransactionsLabel below the transactionFilterSegmentedControl
        // Increased y position by additionalOffset
        recentTransactionsLabel.frame = CGRect(x: padding, y: transactionFilterSegmentedControl.frame.maxY + padding, width: viewWidth - 2 * padding, height: labelHeight)

        // Layout viewAllButton to the right of recentTransactionsLabel
        // Increased y position by additionalOffset
        viewAllButton.frame = CGRect(x: viewWidth - padding - 80, y: transactionFilterSegmentedControl.frame.maxY + padding, width: 80, height: labelHeight)

        // Other views layout code...
        // Ensure that any views positioned relative to the transactionFilterSegmentedControl
        // or recentTransactionsLabel are also adjusted by additionalOffset to maintain the layout

        // Layout the addTransactionButton at the bottom center
        addTransactionButton.frame = CGRect(x: (viewWidth - buttonHeight) / 2, y: self.bounds.height - padding - buttonHeight, width: buttonHeight, height: buttonHeight)

        // Layout navigationBar at the bottom
        navigationBar.frame = CGRect(x: 0, y: self.bounds.height - navigationBarHeight, width: viewWidth, height: navigationBarHeight)
        
        // Other views layout...
    }
    
    @objc func transactionButtonTapped() {
            onTransactionButtonTapped?()
        }
    
    
    let transactionCard = TransactionCardView()
    private func layoutSubviewsWithAutoLayout() {
            // Enable Auto Layout for all subviews
              subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
               
            
            // Set up constraints for each UI element
            NSLayoutConstraint.activate([
                // Date label constraints
                dateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
                dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                
                // Name label constraints
                nameLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor),
                nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: dateLabel.trailingAnchor, constant: 8),
                
                // Account balance label constraints
                accountBalanceLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
                accountBalanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                accountBalanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                
                // Income label constraints
                incomeLabel.topAnchor.constraint(equalTo: accountBalanceLabel.bottomAnchor, constant: 20),
                incomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                
                // Expenses label constraints
                expensesLabel.topAnchor.constraint(equalTo: incomeLabel.topAnchor),
                expensesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                expensesLabel.leadingAnchor.constraint(equalTo: incomeLabel.trailingAnchor, constant: 16),
                expensesLabel.widthAnchor.constraint(equalTo: incomeLabel.widthAnchor),
                
                // Transaction filter segmented control constraints
                transactionFilterSegmentedControl.topAnchor.constraint(equalTo: incomeLabel.bottomAnchor, constant: 16),
                transactionFilterSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                transactionFilterSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                
                // Recent transactions label constraints
                recentTransactionsLabel.topAnchor.constraint(equalTo: transactionFilterSegmentedControl.bottomAnchor, constant: 8),
                recentTransactionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                recentTransactionsLabel.trailingAnchor.constraint(equalTo: viewAllButton.leadingAnchor, constant: -8),
                
                // View all button constraints
                viewAllButton.topAnchor.constraint(equalTo: recentTransactionsLabel.topAnchor),
                viewAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                
                // Add transaction button constraints
                addTransactionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                addTransactionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
                addTransactionButton.widthAnchor.constraint(equalToConstant: 60),
                addTransactionButton.heightAnchor.constraint(equalToConstant: 60),
                
                // Navigation bar constraints
                navigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
                navigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
                navigationBar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                navigationBar.heightAnchor.constraint(equalToConstant: 50),
               
            ])
        
            
            // Additional constraints to ensure proper sizing
            incomeLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
            expensesLabel.heightAnchor.constraint(equalTo: incomeLabel.heightAnchor).isActive = true
        }
        
        // Override layoutSubviews to activate your constraints
        override func layoutSubviews() {
            super.layoutSubviews()
            layoutSubviewsWithAutoLayout()
        }
    
    
        
}
