//
//  ProfileViewController.swift
//  Navigation
//
//  Created by D.Nikishin on 22.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
	private lazy var profileHeaderView: ProfileHeaderView = {
		let view = ProfileHeaderView()
		return view
	}()

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.navigationBar.prefersLargeTitles = false
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .lightGray

		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = .systemGray3
		navigationItem.standardAppearance = appearance
		navigationItem.scrollEdgeAppearance = appearance
		navigationItem.compactAppearance = appearance
    }

	override func viewWillLayoutSubviews() {
		view.addSubview(profileHeaderView)
		profileHeaderView.frame = view.frame
	}
}
