//
//  FeedViewController.swift
//  Navigation
//
//  Created by D.Nikishin on 22.02.2022.
//

import UIKit

struct Post {
	var title: String
}

protocol ButtonProtocol: AnyObject { }

extension ButtonProtocol {
	func createButton(title: String, bgColor: UIColor, textColor: UIColor, tapHandler: Selector) -> UIButton {
		let button = UIButton()
		button.layer.cornerRadius = 12
		button.clipsToBounds = true
		button.backgroundColor = bgColor
		button.setTitle(title, for: .normal)
		button.setTitleColor(textColor, for: .normal)
		button.addTarget(self, action: tapHandler, for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}
	
	func animateButton(_ button: UIButton, _ onAnimationEnd: (() -> Void)? = nil) {
		button.transform = CGAffineTransform(scaleX: 0.95, y: 0.9)
		UIView.animate(withDuration: 0.3, animations: { button.transform = CGAffineTransform.identity }) { isEnd in
			if isEnd, let closure = onAnimationEnd {
				closure()
			}
		}
	}
}

class FeedViewController: UIViewController, ButtonProtocol {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupMainButton()
		navigationItem.backButtonTitle = ""
	}
	
	private func setupMainButton() {
		let firstButton = createButton(title: "Перейти на пост так", bgColor: .systemYellow, textColor: .darkText, tapHandler: #selector(onTapMainButton))
		let secondButton = createButton(title: "Перейти на пост сяк", bgColor: .systemYellow, textColor: .darkText, tapHandler: #selector(onTapMainButton))
		let verticalStackView = createStackView(withSpacing: 10, distribution: .fillEqually)

		verticalStackView.addArrangedSubview(firstButton)
		verticalStackView.addArrangedSubview(secondButton)
		view.addSubview(verticalStackView)

		let constraints = [
			verticalStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
			verticalStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
			verticalStackView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.75),
			verticalStackView.heightAnchor.constraint(equalToConstant: 110)
		]
		NSLayoutConstraint.activate(constraints)
	}

	private func createStackView(withSpacing spacing: CGFloat, andAxis axis: NSLayoutConstraint.Axis = .vertical, distribution: UIStackView.Distribution? = nil, alignment: UIStackView.Alignment? = nil) -> UIStackView {
		let stackView = UIStackView()
		stackView.spacing = spacing
		stackView.axis = axis
		if distribution != nil {
			stackView.distribution = distribution!
		} else if alignment != nil {
			stackView.alignment = alignment!
		}
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}
	
	@objc private func onTapMainButton(_ sender: UIButton) {
		animateButton(sender) { [weak self] in
			let postVC = PostViewController()
			let postInfo = Post(title: "Мой пост")
			postVC.postInfo = postInfo
			self?.navigationController?.pushViewController(postVC, animated: true)
		}
	}
}
