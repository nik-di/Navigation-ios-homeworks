//
//  PhotosViewController.swift
//  Navigation
//
//  Created by D.Nikishin on 30.03.2022.
//

import UIKit

class PhotosViewController: UIViewController {

	private enum Constants {
		static let itemsInRowCount = 3
		static let fixedSpacing = CGFloat(8)
	}

	lazy var layout: UICollectionViewFlowLayout = {
		let view = UICollectionViewFlowLayout()
		view.scrollDirection = .vertical
		view.minimumInteritemSpacing = Constants.fixedSpacing
		view.minimumLineSpacing = Constants.fixedSpacing
		view.sectionInset = UIEdgeInsets(top: 0, left: Constants.fixedSpacing, bottom: 0, right: Constants.fixedSpacing)
		return view
	}()

	lazy var collectionView: UICollectionView = {
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
		view.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
		view.delegate = self
		view.dataSource = self
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationItem.title = "Photos"
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		let appearance = UINavigationBarAppearance()
		appearance.shadowImage = nil
		appearance.shadowColor = .clear
		navigationItem.standardAppearance = appearance
		navigationItem.scrollEdgeAppearance = appearance
		navigationItem.compactAppearance = appearance
		
		view.addSubview(collectionView)

		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}

	func getItemSize(with spacing: CGFloat) -> CGSize {
		let count = CGFloat(Constants.itemsInRowCount)
		let neededSize = floor((collectionView.frame.width - spacing * (count + 1)) / count)
		let width = neededSize
		return CGSize(width: width, height: neededSize)
	}
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return photos.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? PhotosCollectionViewCell else {
			return UICollectionViewCell()
		}

		cell.setup(with: photos[indexPath.row])
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let spacing = layout.minimumInteritemSpacing
		let itemSize = getItemSize(with: spacing)
		return itemSize
	}

}
