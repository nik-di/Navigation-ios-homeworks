//
//  PostsTableViewCell.swift
//  Navigation
//
//  Created by D.Nikishin on 23.03.2022.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

	private lazy var backView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.clipsToBounds = true
		return view
	}()

	private func createStackView(axis: NSLayoutConstraint.Axis = .vertical, distribution: UIStackView.Distribution = .fillEqually, spacing: CGFloat = 0) -> UIStackView {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.clipsToBounds = true

		stack.axis = axis
		stack.spacing = spacing
		stack.distribution = distribution

		return stack
	}

	private lazy var cellStackView: UIStackView = {
		let verticalStack = createStackView(distribution: .fillProportionally, spacing: 10)
		return verticalStack
	}()

	private func createLabel(textColor: UIColor, font: UIFont, textAlignment: NSTextAlignment = .center, numberOfLines: Int = 0) -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.backgroundColor = .white

		label.textColor = textColor
		label.font = font
		label.numberOfLines = numberOfLines
		label.textAlignment = textAlignment

		return label
	}

	private lazy var authorLabel: UILabel = {
		let label = createLabel(textColor: .black, font: UIFont.boldSystemFont(ofSize: 22), textAlignment: .left, numberOfLines: 2)
		return label
	}()

	private lazy var cellImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.setContentCompressionResistancePriority(UILayoutPriority(100), for: .vertical)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.backgroundColor = .black
		return imageView
	}()

	private lazy var descriptionLabel: UILabel = {
		let label = createLabel(textColor: .systemGray, font: UIFont.systemFont(ofSize: 14), textAlignment: .left)
		label.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
		return label
	}()

	private lazy var cellFooterStackView: UIStackView = {
		return createStackView(axis: .horizontal, distribution: .equalSpacing)
	}()

	private lazy var viewsLabel: UILabel = {
		return createLabel(textColor: .black, font: UIFont.systemFont(ofSize: 16))
	}()

	private lazy var likesLabel: UILabel = {
		return createLabel(textColor: .black, font: UIFont.systemFont(ofSize: 16))
	}()

	override func prepareForReuse() {
		super.prepareForReuse()
		authorLabel.text = nil
		cellImageView.image = nil
		descriptionLabel.text = nil
		viewsLabel.text = nil
		likesLabel.text = nil
	}

	private func setupView() {
		contentView.addSubview(backView)

		backView.addSubview(cellStackView)
		cellStackView.addArrangedSubview(authorLabel)
		cellStackView.addArrangedSubview(cellImageView)
		cellStackView.addArrangedSubview(descriptionLabel)
		cellStackView.addArrangedSubview(cellFooterStackView)

		cellFooterStackView.addArrangedSubview(likesLabel)
		cellFooterStackView.addArrangedSubview(viewsLabel)

		NSLayoutConstraint.activate([
			backView.topAnchor.constraint(equalTo: contentView.topAnchor),
			backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

			cellStackView.topAnchor.constraint(equalTo: backView.topAnchor),
			cellStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
			cellStackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
			cellStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),

			authorLabel.heightAnchor.constraint(equalToConstant: 40),
			cellFooterStackView.heightAnchor.constraint(equalToConstant: 40)
		])
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setData(with data: UserPost) {
		authorLabel.text = data.author
		cellImageView.image = UIImage(named: data.image)
		descriptionLabel.text = data.description
		viewsLabel.text = "Views: " + String(data.views)
		likesLabel.text = "Likes: " + String(data.likes)
	}
}
