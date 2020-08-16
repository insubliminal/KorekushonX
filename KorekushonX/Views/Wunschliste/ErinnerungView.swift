import UIKit

class ErinnerungView: UIViewController {
    @IBOutlet private var tableView: UITableView!
    let manager = ErinnerungManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

        manager.reloadIfNeccessary(tableView, true)
        if #available(iOS 13, *) {} else {
            tableView.contentInset = UIEdgeInsets(top: -36, left: 0, bottom: -38, right: 0)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manager.reloadIfNeccessary(tableView)

        let enabled = UserDefaults.standard.bool(forKey: "ErinnerungActive")
        self.navigationItem.rightBarButtonItem?.isEnabled = enabled
        if !enabled {
            AlertManager.shared.notificationError(self)
            self.tabBarController?.selectedIndex = 0
        }
    }
}

extension ErinnerungView: UITableViewDelegate, UITableViewDataSource, UIAdaptivePresentationControllerDelegate {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 70 }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat { 70 }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 0 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        navigationController?.tabBarItem.badgeValue = String(manager.rawCount())
        return manager.list.count
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let remove = UIContextualAction(style: .destructive, title: "Löschen") { _, _, completion in
            self.manager.removeErinnerung(self.manager.list[indexPath.row])
            self.manager.reloadIfNeccessary(self.tableView, true)
            completion(true)
        }
        remove.image = UIImage(named: "müll")
        remove.backgroundColor = .systemRed

        return UISwipeActionsConfiguration(actions: [remove])
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "erinnerungCell") as! ErinnerungCell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let erinnerung = manager.list[indexPath.row]
        let date = manager.formatter.string(from: Date(timeIntervalSince1970: erinnerung.date))
        (cell as! ErinnerungCell).setUp(erinnerung, date)
    }

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.viewWillAppear(false)
    }
}
