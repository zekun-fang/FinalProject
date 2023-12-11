import UIKit

struct Transaction_demo {
    let category: String
    let description: String
    let amount: Double
    let time: String
    let isIncome: Bool
}

class TransactionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var monthTransactions: [Transaction] = []
    var transactionsFromDashboard: [Transaction] = []
    private var transactions: [Transaction] {
        return segmentedControl.selectedSegmentIndex == 0 ? monthTransactions : transactionsFromDashboard
    }
    
    enum SelectedSegment {
            case month, all
        }

    var selectedSegment: SelectedSegment = .month

    
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
        
        // 根据 selectedSegment 设置分段控制器的选项
        switch selectedSegment {
        case .month:
            segmentedControl.selectedSegmentIndex = 0
        case .all:
            segmentedControl.selectedSegmentIndex = 1
        }
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
        tableView.isScrollEnabled = true
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
        // 获取当前月份
        let currentMonth = Calendar.current.component(.month, from: Date())

        monthTransactions = transactionsFromDashboard.filter { transaction in
            // 比较交易日期的月份是否与当前月份相同
            return Calendar.current.component(.month, from: transaction.date) == currentMonth
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
