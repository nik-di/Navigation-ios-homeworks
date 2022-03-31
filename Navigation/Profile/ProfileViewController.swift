//
//  ProfileViewController.swift
//  Navigation
//
//  Created by D.Nikishin on 22.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

	private lazy var tableView: UITableView = {
		let view = UITableView(frame: .zero, style: .grouped)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.dataSource = self
		view.delegate = self
		view.rowHeight = UITableView.automaticDimension
		view.estimatedRowHeight = 44
		view.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
		view.register(PostsTableViewCell.self, forCellReuseIdentifier: "PostsCell")
		view.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosCell")
		return view
	}()

	private lazy var profileHeaderView: ProfileHeaderView = {
		let view = ProfileHeaderView()
		return view
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.backButtonTitle = ""

		let appearance = UINavigationBarAppearance()
		appearance.shadowImage = nil
		appearance.shadowColor = .clear
		navigationItem.standardAppearance = appearance
		navigationItem.scrollEdgeAppearance = appearance
		navigationItem.compactAppearance = appearance

		view.addSubview(tableView)

		setupConstraints()
	}

	private func setupConstraints() {
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
		])
	}
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return section == 0 ? 1 : posts.count
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)

		if indexPath.section == 0 {
			cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath)
		} else {
			let postsCell = tableView.dequeueReusableCell(withIdentifier: "PostsCell", for: indexPath)
			if let castedCell = postsCell as? PostsTableViewCell {
				let data = posts[indexPath.row]
				let dataModel = UserPost(author: data.author, description: data.description, image: data.image, likes: data.likes, views: data.views)
				castedCell.setData(with: dataModel)

				cell = castedCell
			}
		}

		return cell
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		print(section)
		return profileHeaderView
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return section == 0 ? 300 : 0
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == 0 {
			navigationController?.pushViewController(PhotosViewController(), animated: true)
		}
	}
}
