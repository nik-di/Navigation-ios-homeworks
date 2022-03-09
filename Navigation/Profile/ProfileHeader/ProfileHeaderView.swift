//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by D.Nikishin on 07.03.2022.
//

import UIKit

class ProfileHeaderView: UIView {
	@IBOutlet weak var avatar: UIImageView!
	@IBOutlet weak var profileButton: UIButton!
	@IBOutlet weak var statusTextField: UITextField!
	@IBOutlet weak var statusLabel: UILabel!
	@IBOutlet weak var profileButtonTopAnchor: NSLayoutConstraint!

	private var statusText = "" {
		willSet {
			if newValue != "" {
				profileButton.setTitle("Set status", for: .normal)
			} else {
				profileButton.setTitle("Close field", for: .normal)
			}
		}
	}
	private var textFieldVisible: Bool {
		return self.statusTextField.layer.opacity == 1
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	private func setupView() {
		guard let view = Bundle.main.loadNibNamed("ProfileHeaderView", owner: self)?.first as? UIView else { return }

		addSubview(view)
		view.frame = frame

		if let superview = superview {
			NSLayoutConstraint.activate([
				view.topAnchor.constraint(equalTo: superview.topAnchor),
				view.heightAnchor.constraint(equalToConstant: 220)
			])
		}

		configureAvatar()
		configureProfileButton()
		configureStatusEditField()
	}

	private func configureAvatar() {
		avatar.layer.borderColor = UIColor.white.cgColor
		avatar.layer.cornerRadius = avatar.frame.height / 2
	}

	private func configureProfileButton() {
		profileButton.setTitle("Change status", for: .normal)
		profileButton.addTarget(self, action: #selector(animateButton), for: .touchUpInside)
	}

	private func configureStatusEditField() {
		statusTextField.clipsToBounds = true
		statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
	}

	@objc func animateButton(_ button: UIButton) {
		let closure = onTapProfileButton
		button.transform = CGAffineTransform(scaleX: 0.95, y: 0.9)
		UIView.animate(withDuration: 0.15, animations: { button.transform = CGAffineTransform.identity }, completion: { isEnd in
			if isEnd {
				closure()
			}
		})
	}

	@objc private func onTapProfileButton() {
		let textFieldVisible = self.textFieldVisible
		UIView.animate(withDuration: 0.15, animations: { [weak self] in
			guard self != nil else { return }

			self!.statusTextField.layer.opacity = textFieldVisible ? 0 : 1
			self!.profileButtonTopAnchor.constant = textFieldVisible ? 16 : 75
			self!.layoutIfNeeded()
		})

		if statusText != "" {
			statusLabel.text = statusText
			statusTextField.text = ""
			statusTextField.endEditing(true)
		}

		profileButton.setTitle("Change status", for: .normal)
	}

	@objc func statusTextChanged(_ textField: UITextField) {
		guard let text = textField.text else { return }
		statusText = text
	}
}
