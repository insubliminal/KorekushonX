import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .secondarySystemBackground
        } else {
            self.view.backgroundColor = .white
        }

        UITabBarItem.appearance().setBadgeTextAttributes([.foregroundColor: UIColor.clear, .font: UIFont.systemFont(ofSize: 12, weight: .bold)], for: .normal)
        UITabBarItem.appearance().setBadgeTextAttributes([.foregroundColor: UIColor.systemPurple, .font: UIFont.systemFont(ofSize: 12, weight: .bold)], for: .selected)

        tabBar.layer.shadowOffset = CGSize(width: 0, height: 6)
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowRadius = 12.0
        tabBar.layer.shadowOpacity = 0.4
        delegate = self

        if !UserDefaults.standard.bool(forKey: Constants.Keys.showAnimeView.rawValue) {
            if viewControllers?.count == 5 {
                viewControllers?.removeLast()
            }
        }
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        (viewController as? UINavigationController)?.popToRootViewController(animated: false)
    }

    func addManga() {
        selectedIndex = 0
        (selectedViewController as? UINavigationController)?.topViewController?.performSegue(withIdentifier: Constants.Segues.edit.rawValue, sender: nil)
    }
}
