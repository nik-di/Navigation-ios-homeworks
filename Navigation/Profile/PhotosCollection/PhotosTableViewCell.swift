//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by D.Nikishin on 31.03.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

	private lazy var backView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.clipsToBounds = true
		view.backgroundColor = .white
		return view
	}()

	private lazy var sectionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
		label.text = "Photos"
		label.textColor = .black
		return label
	}()

	private lazy var rightArrow: UIImageView = {
		let imageView = UIImageView()

		if let rightArrow = UIImage(systemName: "arrow.right") {
			rightArrow.withTintColor(.black)
			imageView.image = rightArrow
		}

		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.clipsToBounds = true

		return imageView
	}()

	private lazy var photosStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.clipsToBounds = true
		stack.axis = .horizontal
		stack.spacing = 8
		stack.distribution = .fillEqually
		return stack
	}()

	private func getCellImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.clipsToBounds = true
		imageView.contentMode = .scaleToFill
		imageView.layer.cornerRadius = 6
		return imageView
	}

	private func setupView() {
		contentView.addSubview(backView)
		backView.addSubview(sectionLabel)
		backView.addSubview(rightArrow)
		backView.addSubview(photosStackView)

		for i in 0..<4 {
			let cellImageView = getCellImageView()
			cellImageView.image = photos[i]
			photosStackView.addArrangedSubview(cellImageView)
		}

		NSLayoutConstraint.activate([
			backView.topAnchor.constraint(equalTo: contentView.topAnchor),
			backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

			sectionLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 12),
			sectionLabel.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 12),

			rightArrow.heightAnchor.constraint(equalTo: sectionLabel.heightAnchor),
			rightArrow.widthAnchor.constraint(equalTo: rightArrow.heightAnchor),
			rightArrow.centerYAnchor.constraint(equalTo: sectionLabel.centerYAnchor),
			rightArrow.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -12),

			photosStackView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 12),
			photosStackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -12),
			photosStackView.heightAnchor.constraint(equalToConstant: 80),
			photosStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12),
			photosStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -12),
		])
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
