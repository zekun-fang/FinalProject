import UIKit

class DashboardViewController: UIViewController, UITabBarDelegate {
    
    // This will be the main view for this view controller.
    private var dashboardView: DashboardView!

    override func loadView() {
        // Instantiate your custom view and assign it to the view controller's main view.
        dashboardView = DashboardView()
        view = dashboardView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            // 设置 navigationBar 的选中项
            // 假设您想要选中 "Home" 标签
            if let homeItem = dashboardView.navigationBar.items?.first(where: { $0.title == "Home" }) {
                dashboardView.navigationBar.selectedItem = homeItem
            }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up any additional configurations or data for your dashboardView here.
        configureView()
        
        // Add target-actions for controls
        dashboardView.viewAllButton.addTarget(self, action: #selector(viewAllButtonTapped), for: .touchUpInside)
        dashboardView.addTransactionButton.addTarget(self, action: #selector(addTransactionButtonTapped), for: .touchUpInside)
        dashboardView.transactionFilterSegmentedControl.addTarget(self, action: #selector(transactionFilterChanged(_:)), for: .valueChanged)
        dashboardView.navigationBar.delegate = self
       
        navigationItem.hidesBackButton = true
    }
    

    
    private func configureView() {
        // Assuming you have methods to fetch or calculate these values
        dashboardView.dateLabel.text = "MONDAY 9 NOVEMBER"
        dashboardView.nameLabel.text = "VISHNU"
        dashboardView.accountBalanceLabel.text = "9400.0"
        dashboardView.incomeLabel.valueLabel.text = "Income:25000"
        dashboardView.expensesLabel.valueLabel.text = "Expenses:11200"
        loadTransactions()
    }
    
    private func loadTransactions() {
        let transactions = fetchTransactions()

        for transaction in transactions {
            let cardView = TransactionCardView()
            cardView.configure(with: transaction)
            dashboardView.transactionsContainer.addArrangedSubview(cardView)

            // Since you're using a stack view, you only need to set the height constraint.
            // The stack view will manage the other constraints for you.
            cardView.heightAnchor.constraint(equalToConstant: 50).isActive = true // Set this to your requirement
        }
    }
    
    @objc private func addTransactionButtonTapped() {
           let addTransactionVC = AddTransactionViewController()
           navigationController?.pushViewController(addTransactionVC, animated: true)
       }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            switch item.tag {
            case 0:
                navigateToHome()
            case 1:
                navigateToTransactions()
            case 2:
                navigateToStatistics()
            case 3:
                navigateToProfile()
            default:
                break
            }
        }

        // 根据需要实现这些跳转方法
        private func navigateToHome() {
            let homeVC = DashboardViewController() // 用您的 'Home' 视图控制器替换
            navigationController?.pushViewController(homeVC, animated: true)
        }
        
        private func navigateToTransactions() {
           let transactionVC = TransactionsViewController() // 用您的 'Home' 
           navigationController?.pushViewController(transactionVC, animated: true)
        }

        private func navigateToStatistics() {
            let statsVC = StatisticViewController() // 用您的 'Statistics' 视图控制器替换
            navigationController?.pushViewController(statsVC, animated: true)
        }

        private func navigateToProfile() {
            let profileVC = ProfileViewController() // 用您的 'Profile' 视图控制器替换
            navigationController?.pushViewController(profileVC, animated: true)
        }
    
    private func fetchTransactions() -> [Transaction] {
            // Fetch or create transaction data
            // For demonstration, create some dummy data
            return [
                Transaction(amount: 15000, category: "Income", isIncome: true),
                Transaction(amount: 6500, category: "Food", isIncome: false),
                Transaction(amount: 2800, category: "Income", isIncome: true)
            ]
        }
    
    // MARK: - Actions
    
    @objc private func viewAllButtonTapped() {
        // Handle the action for the view all button tap
        print("View All button tapped")
    }

    
    @objc private func transactionFilterChanged(_ sender: UISegmentedControl) {
        // Handle the action for the transaction filter segment control value change
        switch sender.selectedSegmentIndex {
        case 0:
            print("Today selected")
        case 1:
            print("Week selected")
        case 2:
            print("Month selected")
        case 3:
            print("Year selected")
        default:
            break
        }
    }
}
