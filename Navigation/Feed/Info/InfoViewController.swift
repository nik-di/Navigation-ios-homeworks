//
//  InfoViewController.swift
//  Navigation
//
//  Created by D.Nikishin on 23.02.2022.
//

import UIKit

class InfoViewController: UIViewController, ButtonProtocol {

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemGreen

		setupAlertButton()
	}

	private func setupAlertButton() {
		let button = createButton(title: "Показать алерт", bgColor: .systemYellow, textColor: .darkText, tapHandler: #selector(onTapAlertButton))

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

	@objc private func onTapAlertButton(_ sender: UIButton) {
		animateButton(sender) { [weak self] in
			let alert = UIAlertController(title: "Важное сообщение!", message: "Важное уведомление! Прочтите внимательно и нажмите Ok!", preferredStyle: .alert)
			let confirmAction = UIAlertAction(title: "Ok", style: .default) { _ in print("Ok") }
			let cancelAction = UIAlertAction(title: "Закрыть", style: .destructive) { _ in print("Закрыть") }
			alert.addAction(confirmAction)
			alert.addAction(cancelAction)
			self?.present(alert, animated: true)
		}
	}
}
