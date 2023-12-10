import UIKit

class AccountInfoView: UIView, UITableViewDataSource, UITableViewDelegate {

    let titleLabel = UILabel()
    let tableView = UITableView()
    var userEmail: String?
    var userID: String?
    var currentUserName: String?
    var buttonLabelPhoto: UIButton!
    var buttonTakePhoto: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        NotificationCenter.default.addObserver(self, selector: #selector(userNameUpdated(_:)), name: NSNotification.Name("UserNameUpdated"), object: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    @objc private func userNameUpdated(_ notification: Notification) {
        if let newName = notification.userInfo?["newName"] as? String {
            // Update the tableView to reflect the new name
            tableView.reloadData()
        }
    }

    private func setupViews() {
        backgroundColor = .white

        // Title Label
        titleLabel.text = "Account Information"
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        // TableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonLabelPhoto = UIButton(type: .system)
        buttonLabelPhoto.setTitle("Add/Change Profile Photo", for: .normal)
        buttonLabelPhoto.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        buttonLabelPhoto.translatesAutoresizingMaskIntoConstraints = false
        buttonLabelPhoto.addTarget(self, action: #selector(labelPhotoTapped), for: .touchUpInside)
        self.addSubview(buttonLabelPhoto)
        
        buttonTakePhoto = UIButton(type: .system)
        buttonTakePhoto.setTitle("", for: .normal)
        buttonTakePhoto.setImage(UIImage(systemName: "camera.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        buttonTakePhoto.contentHorizontalAlignment = .fill
        buttonTakePhoto.contentVerticalAlignment = .fill
        buttonTakePhoto.imageView?.contentMode = .scaleAspectFit
        buttonTakePhoto.showsMenuAsPrimaryAction = true
        buttonTakePhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonTakePhoto)
        

        // Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            // This is the important line: setting the bottom constraint for tableView
            tableView.bottomAnchor.constraint(equalTo: buttonTakePhoto.topAnchor, constant: -16),

            buttonTakePhoto.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonTakePhoto.widthAnchor.constraint(equalToConstant: 100),
            buttonTakePhoto.heightAnchor.constraint(equalToConstant: 100),
            buttonTakePhoto.bottomAnchor.constraint(equalTo: buttonLabelPhoto.topAnchor, constant: -8),

            buttonLabelPhoto.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonLabelPhoto.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -250)
        ])
    }
    
    @objc private func labelPhotoTapped() {
            NotificationCenter.default.post(name: NSNotification.Name("LabelPhotoTapped"), object: nil)
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Name: \(currentUserName ?? "Tap to Change")"
        case 1:
            cell.textLabel?.text = "Email: \(userEmail ?? "Not available")"
        case 2:
            cell.textLabel?.text = "UserID: \(userID ?? "Not available")"
        default:
            break
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            // Notify view controller to handle name change action
            NotificationCenter.default.post(name: NSNotification.Name("ChangeNameNotification"), object: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

