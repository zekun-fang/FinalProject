import UIKit

class StatisticViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Expense", "Income"])
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var progressRingView: ProgressRingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Financial Report"
        view.backgroundColor = UIColor(red: 246/255.0, green: 237/255.0, blue: 220/255.0, alpha: 1)
        setupProgressRingView()
        setupViews()
        layoutViews()
    }

    private func setupViews() {
        view.addSubview(segmentControl)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 246/255.0, green: 237/255.0, blue: 220/255.0, alpha: 1)
        view.backgroundColor = UIColor(red: 246/255.0, green: 237/255.0, blue: 220/255.0, alpha: 1)
    }
    
    private func setupProgressRingView() {
            progressRingView = ProgressRingView()
            progressRingView.isOpaque = false 
            progressRingView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(progressRingView)
            progressRingView.backgroundColor = .clear
            NSLayoutConstraint.activate([
                progressRingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                progressRingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                progressRingView.widthAnchor.constraint(equalToConstant: 200),
                progressRingView.heightAnchor.constraint(equalToConstant: 200),
            ])
        }
    
    
    private func layoutViews() {
        // Add ProgressRingView constraints
        progressRingView = ProgressRingView()
        progressRingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressRingView)
        progressRingView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            progressRingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressRingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            progressRingView.widthAnchor.constraint(equalToConstant: 200),
            progressRingView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // Add SegmentControl constraints
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: progressRingView.bottomAnchor, constant: 20),
            segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
        
        // Add TableView constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        let progressView = SpendingProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(progressView)
        cell.backgroundColor = UIColor(red: 246/255.0, green: 237/255.0, blue: 220/255.0, alpha: 1)
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            progressView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            progressView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            progressView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8)
        ])
        
        let categories = ["Shopping", "Subscription", "Food"]
        let amounts = [-5120, -1280, -532]
        let progresses: [Float] = [0.7, 0.4, 0.2]
        let colors: [UIColor] = [.orange, .blue, .red]
        
        if indexPath.row < categories.count {
            let category = categories[indexPath.row]
            let amount = amounts[indexPath.row]
            let progress = progresses[indexPath.row]
            let color = colors[indexPath.row]
            
            progressView.configure(category: category, amount: amount, progress: progress)
            progressView.progressBar.progressTintColor = color
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
