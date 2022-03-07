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
		let button = createButton(title: "Перейти на пост", bgColor: .systemYellow, textColor: .darkText, tapHandler: #selector(onTapMainButton))
		
		view.addSubview(button)
		
		button.translatesAutoresizingMaskIntoConstraints = false
		let constraints = [
			button.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
			button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			button.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
			button.heightAnchor.constraint(equalToConstant: 50)
		]
		NSLayoutConstraint.activate(constraints)
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
