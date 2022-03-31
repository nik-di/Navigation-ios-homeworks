//
//  CollectionViewCell.swift
//  Navigation
//
//  Created by D.Nikishin on 30.03.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

	lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.addSubview(imageView)

		NSLayoutConstraint.activate([
			imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
			imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image = nil
	}

	func setup(with image: UIImage) {
		imageView.image = image
	}
}
