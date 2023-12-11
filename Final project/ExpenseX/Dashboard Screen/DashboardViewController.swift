import UIKit
import FirebaseAuth
import FirebaseFirestore

class DashboardViewController: UIViewController, UITabBarDelegate {
    
    // This will be the main view for this view controller.
    private var dashboardView: DashboardView!
    
    private var timer: Timer?
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    let database = Firestore.firestore()
    
    //represent all transactions of the current user
    var transactions: [Transaction] = []

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
        timer?.invalidate()  // Invalidate the timer when the view is about to disappear
        
        fetchTransactions()
        loadTransactions(transactions)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCurrentUser()
        // Set up any additional configurations or data for your dashboardView here.
        configureView()
        
        updateNameLabelAndPhoto()
        updateDateLabel()
        startTimer()
        calculateAndDisplayTotals()
        
        // Add target-actions for controls
        dashboardView.viewAllButton.addTarget(self, action: #selector(viewAllButtonTapped), for: .touchUpInside)
        dashboardView.addTransactionButton.addTarget(self, action: #selector(addTransactionButtonTapped), for: .touchUpInside)
        dashboardView.transactionFilterSegmentedControl.addTarget(self, action: #selector(transactionFilterChanged(_:)), for: .valueChanged)
        dashboardView.navigationBar.delegate = self
       
        NotificationCenter.default.addObserver(self, selector: #selector(profilePhotoUpdated(_:)), name: NSNotification.Name("ProfilePhotoUpdated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userNameUpdated), name: NSNotification.Name("UserNameUpdated"), object: nil)
        
        navigationItem.hidesBackButton = true
    }
    
    @objc private func profilePhotoUpdated(_ notification: Notification) {
        if let photoURL = notification.userInfo?["profilePhotoURL"] as? URL {
            // Use your extension to load the image
            dashboardView.avatarImageView.loadRemoteImage(from: photoURL)
        }
    }
    
    @objc private func userNameUpdated(_ notification: Notification) {
        if let newName = notification.userInfo?["newName"] as? String {
            self.dashboardView.nameLabel.text = newName
        }
    }
    
    private func setupCurrentUser(){
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
            }else{
                //MARK: the user is signed in...
                self.currentUser = user
            }
        }
    }
    
    private func updateNameLabelAndPhoto(){
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
            }else{
                //MARK: the user is signed in...
                self.currentUser = user
                print("\(user?.displayName ?? "Anonymous")")
                self.dashboardView.nameLabel.text = "\(user?.displayName ?? "Anonymous")"
                print("success")
                
                if let url = self.currentUser?.photoURL{
                    self.dashboardView.avatarImageView.loadRemoteImage(from: url)
                }
            }
        }
    }
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { [weak self] _ in
            self?.updateDateLabel()
        }
    }

    private func updateDateLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE d MMMM"
        let dateString = formatter.string(from: Date())
        print("Updating date label to: \(dateString)")  // 调试输出
        dashboardView.dateLabel.text = dateString.uppercased()
    }
    
    private func calculateAndDisplayTotals() {
        var totalIncome: Double = 0
        var totalExpenses: Double = 0

        for transaction in transactions {
            if transaction.isIncome {
                totalIncome += transaction.amount
            } else {
                totalExpenses += transaction.amount
            }
        }

        // Calculate Account Blance
        let accountBalance = totalIncome - totalExpenses

        // Update UI
        dashboardView.incomeLabel.valueLabel.text = "Income:\n$\(totalIncome)"
        dashboardView.expensesLabel.valueLabel.text = "Expenses:\n$\(totalExpenses)"
        dashboardView.accountBalanceLabel.text = "$\(accountBalance)"
    }

    
    private func configureView() {
        // Assuming you have methods to fetch or calculate these values
//        dashboardView.nameLabel.text = "Zekun"
        dashboardView.accountBalanceLabel.text = "$9400.0"
        dashboardView.incomeLabel.valueLabel.text = "Income:\n25000"
        dashboardView.expensesLabel.valueLabel.text = "Expenses:\n11200"
        
    }
    
    private func loadTransactions(_ transactions: [Transaction]) {
        // Keep last four elements of array of transactions
        let recentTransactions = transactions.suffix(4)

        // remove all current transaction view
        dashboardView.transactionsContainer.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for transaction in recentTransactions {
            let cardView = TransactionCardView()
            cardView.configure(with: transaction)
            dashboardView.transactionsContainer.addArrangedSubview(cardView)
            cardView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
    
    private func filterTransactions(for timeRange: TimeRange) -> [Transaction] {
        let filteredTransactions: [Transaction]
        let now = Date()
        let calendar = Calendar.current

        switch timeRange {
        case .today:
            filteredTransactions = transactions.filter { calendar.isDateInToday($0.date) }
        case .week:
            filteredTransactions = transactions.filter { calendar.isDate($0.date, equalTo: now, toGranularity: .weekOfYear) }
        case .month:
            filteredTransactions = transactions.filter { calendar.isDate($0.date, equalTo: now, toGranularity: .month) }
        case .year:
            filteredTransactions = transactions.filter { calendar.isDate($0.date, equalTo: now, toGranularity: .year) }
        }

        return filteredTransactions
    }

    enum TimeRange {
        case today
        case week
        case month
        case year
    }
    
    @objc private func addTransactionButtonTapped() {
       let addTransactionVC = AddTransactionViewController()
        addTransactionVC.currentUser = self.currentUser
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
            let transactionVC = TransactionsViewController()
            transactionVC.transactionsFromDashboard = self.transactions // 传递交易数据
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
    
    private func fetchTransactions() {
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
            }else{
                //MARK: the user is signed in...
                self.currentUser = user
                guard let userEmail = self.currentUser?.email else { return }

                self.database.collection("users").document(userEmail).collection("transactions")
                    .addSnapshotListener { [weak self] querySnapshot, error in
                        guard let self = self else { return }
                        if let error = error {
                            print("Error getting transactions: \(error.localizedDescription)")
                            return
                        }
                        // Clear existing transactions before appending new ones
                        self.transactions.removeAll()

                        for document in querySnapshot?.documents ?? [] {
                            do {
                                let transaction = try document.data(as: Transaction.self)
                                self.transactions.append(transaction)
                                print("Fetched transaction: \(transaction)") // test
                            } catch {
                                print("Error decoding transaction: \(error)")
                            }
                        }

                        // Reload the transactions on the UI
                        DispatchQueue.main.async {
                            self.loadTransactions(self.transactions)
                            self.calculateAndDisplayTotals()
                        }
                    }
            }
        }
        
    }

    
    // MARK: - Actions
    
    @objc private func viewAllButtonTapped() {
        let transactionVC = TransactionsViewController()
        
        // 传递所有交易记录给 TransactionViewController
        transactionVC.transactionsFromDashboard = self.transactions
        
        // 设置 TransactionViewController 的分段控制器为 "All"
        transactionVC.selectedSegment = .all

        // 使用导航控制器推送 TransactionViewController
        navigationController?.pushViewController(transactionVC, animated: true)
    }

    
    @objc private func transactionFilterChanged(_ sender: UISegmentedControl) {
        let selectedTimeRange: TimeRange

        switch sender.selectedSegmentIndex {
        case 0:
            selectedTimeRange = .today
        case 1:
            selectedTimeRange = .week
        case 2:
            selectedTimeRange = .month
        case 3:
            selectedTimeRange = .year
        default:
            return
        }

        let filteredTransactions = filterTransactions(for: selectedTimeRange)
        // 现在您有了过滤后的交易，可以根据这些交易来更新界面
        loadTransactions(filteredTransactions)
    }

}
