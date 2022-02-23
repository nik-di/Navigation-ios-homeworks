//
//  TabBarContoller.swift
//  Navigation
//
//  Created by D.Nikishin on 21.02.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setupViewControllers()
    }

	fileprivate func createNavigationController(for rootViewController: UIViewController,
												title: String,
												image: UIImage) -> UIViewController {

		let navigationController = UINavigationController(rootViewController: rootViewController)
		navigationController.tabBarItem.title = title
		navigationController.tabBarItem.image = image
		navigationController.navigationBar.prefersLargeTitles = true
		rootViewController.navigationItem.title = title
		return navigationController
	}

	func setupViewControllers() {
		viewControllers = [
			createNavigationController(for: FeedViewController(), title: "Лента", image: UIImage(systemName: "house")!),
			createNavigationController(for: ProfileViewController(), title: "Профиль", image: UIImage(systemName: "person")!)
		]
	}
}
