import UIKit

struct Transaction_demo {
    let category: String
    let description: String
    let amount: Double
    let time: String
    let isIncome: Bool
}

class TransactionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var allTransactions: [Transaction_demo] = []
    private var monthTransactions: [Transaction_demo] = []
    private var transactions: [Transaction_demo] {
        return segmentedControl.selectedSegmentIndex == 0 ? monthTransactions : allTransactions
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Transactions"
        label.font = UIFont.systemFont(ofSize: 20) // 设置字体大小为20点
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30) // 根据需要调整高度
        ])
    }

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.identifier)
        tableView.backgroundColor = .clear
        return tableView
    }()

    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Month", "All"])
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor(red: 255/255.0, green: 235/255.0, blue: 205/255.0, alpha: 1).cgColor, UIColor.white.cgColor]
        return layer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255/255.0, green: 235/255.0, blue: 205/255.0, alpha: 1)
        setupGradientBackground()
        setupSegmentedControl()
        setupTableView()
        loadMockTransactions()
        self.navigationItem.title = "Transaction"
    }

    private func setupGradientBackground() {
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }

    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func loadMockTransactions() {
        // Mock transactions for demonstration
        allTransactions = [
            Transaction_demo(category: "Shopping", description: "Buy some grocery", amount: 5120, time: "10:00 AM", isIncome: false),
            Transaction_demo(category: "Food", description: "Arabian Hut", amount: 532, time: "07:30 PM", isIncome: false),
            Transaction_demo(category: "Salary", description: "Salary for August", amount: 5000, time: "04:30 PM", isIncome: true)
        ]

        // Example: Filter transactions for current month (assuming some logic here)
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
            let currentMonth = Calendar.current.component(.month, from: Date())

            monthTransactions = allTransactions.filter { transaction in
                if let date = dateFormatter.date(from: transaction.time) {
                    return Calendar.current.component(.month, from: date) == currentMonth
                }
                return false
            }

        tableView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }

    // UITableViewDataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return transactions.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifier, for: indexPath) as? TransactionTableViewCell else {
            fatalError("Could not dequeue TransactionTableViewCell")
        }
        let transaction = transactions[indexPath.section]
        cell.configure(with: transaction)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30 // Adjust the spacing to your liking
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}
