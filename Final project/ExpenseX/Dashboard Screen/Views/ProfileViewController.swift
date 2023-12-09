import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let profileTableView = UITableView(frame: .zero, style: .grouped)
    let profileOptions = ["Account", "Settings", "Export Data", "Logout"]
    var userName = "Vishnu P V" // Replace with actual user name variable
    private let userImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfileTableView()
        setupBottomTabBar()
        setProfileHeader()
        view.backgroundColor = UIColor(red: 246/255.0, green: 237/255.0, blue: 220/255.0, alpha: 1)
    }

    private func setupProfileTableView() {
        view.addSubview(profileTableView)

                profileTableView.delegate = self
                profileTableView.dataSource = self

                profileTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

                // Constraints for profileTableView
                profileTableView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                    profileTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    profileTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9) // 90% of the parent view's width
                ])

                // Set background color
                profileTableView.backgroundColor = UIColor(red: 246/255.0, green: 237/255.0, blue: 220/255.0, alpha: 1)

                // Add border radius
                profileTableView.layer.cornerRadius = 10
                profileTableView.clipsToBounds = true
    }

    private func setProfileHeader() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        headerView.backgroundColor = .clear

        let profileImageView = UIImageView(frame: CGRect(x: 15, y: 25, width: 50, height: 50))
        // Set the image named "man" for profileImageView
        profileImageView.backgroundColor = UIColor.black
        profileImageView.image = UIImage(systemName: "person.circle")
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.clipsToBounds = true

        let nameLabel = UILabel(frame: CGRect(x: 75, y: 25, width: view.frame.size.width - 90, height: 50))
        nameLabel.text = userName
        // Customize nameLabel properties
        nameLabel.font = UIFont.systemFont(ofSize: 20) // Example font size
        nameLabel.textColor = UIColor.black // Example text color

        headerView.addSubview(profileImageView)
        headerView.addSubview(nameLabel)

        profileTableView.tableHeaderView = headerView
    }


    private func setupBottomTabBar() {
        // Initialize and set properties for bottomTabBar to match the screenshot
        // ...
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 // 设置为您想要的高度，例如 60
    }
    
    func tableView(_ tableView: UITableView, widthForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 // 设置为您想要的高度，例如 60
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = profileOptions[indexPath.row]

        // 使用系统自带的SF Symbols图标
        let systemIconNames = ["person.fill", "gear", "square.and.arrow.up", "arrow.backward"] // 用相应的SF Symbols替换
        if let image = UIImage(systemName: systemIconNames[indexPath.row]) {
            cell.imageView?.image = image
        }

        return cell
    }



    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle cell selection
    }
}
