import Foundation
import UIKit

class UsersView: UIViewController, UITableViewDataSource, UITableViewDelegate {

    weak var delegate: ViewModelDelegate?
    var users: [UserSingle]

    var tableView = UITableView.init(frame: .zero, style: .insetGrouped)

    init(delegate: ViewModelDelegate? = nil) {
        self.delegate = delegate
        self.users = delegate?.getUsers() ?? []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Header
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Players"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        // Table
        self.view.addSubview(self.tableView)
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect.init(origin: .zero, size: view.frame.size)
    }

    // MARK: table rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    // MARK: table cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let item = self.users[indexPath.row]
        customCell.configureCell(with: item)
        customCell.selectionStyle = .none
        return customCell
    }

    // MARK: table swipe
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trash = UIContextualAction(style: .destructive, title: "") { (_, _, completionHandler) in
            self.delegate?.deleteUser(id: self.users[indexPath.row].id)
            self.users.remove(at: indexPath.row)
            self.delegate?.saveUsers()
            self.tableView.deleteRows(at: [indexPath], with: .right)
            completionHandler(true)
        }
        trash.backgroundColor = .systemRed
        trash.image = UIImage(systemName: "trash.fill")
        let configuration = UISwipeActionsConfiguration(actions: [trash])
        return configuration
    }
}

class TableViewCell: UITableViewCell {
    
    var name = UILabel()
    var score = UILabel()
    var stack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stack)
        stack.addArrangedSubview(name)
        stack.addArrangedSubview(score)
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing

        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -30),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(with item: UserSingle) {
        self.name.text = item.name
        self.score.text = String(item.score)
    }
}
