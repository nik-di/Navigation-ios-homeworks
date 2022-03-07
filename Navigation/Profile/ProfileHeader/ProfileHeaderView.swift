//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by D.Nikishin on 07.03.2022.
//

import UIKit

class ProfileHeaderView: UIView {
	private var statusText = ""

	@IBOutlet weak var avatar: UIImageView!
	@IBOutlet weak var profileButton: UIButton!
	@IBOutlet weak var statusEditField: UITextField!
	@IBOutlet weak var statusLabel: UILabel!
	
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

		configureAvatar()
		configureProfileButton()
		configureStatusEditField()
	}

	private func configureAvatar() {
		avatar.layer.borderWidth = 3
		avatar.layer.borderColor = UIColor.white.cgColor
		avatar.layer.cornerRadius = avatar.frame.height / 2
	}

	private func configureProfileButton() {
		profileButton.layer.cornerRadius = 4
		profileButton.layer.shadowRadius = 4
		profileButton.layer.shadowOpacity = 0.7
		profileButton.layer.shadowColor = UIColor.black.cgColor
		profileButton.layer.shadowOffset = CGSize(width: 4, height: 4)

		profileButton.setTitle("Set status", for: .normal)

		profileButton.addTarget(self, action: #selector(animateButton), for: .touchDown)
		profileButton.addTarget(self, action: #selector(onTapProfileButton), for: .touchUpInside)
	}

	private func configureStatusEditField() {
		statusEditField.layer.borderWidth = 1
		statusEditField.layer.cornerRadius = 12
		statusEditField.layer.borderColor = UIColor.black.cgColor
		statusEditField.layer.backgroundColor = UIColor.white.cgColor
		statusEditField.clipsToBounds = true

		statusEditField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
	}

	@objc func animateButton(_ button: UIButton) {
		button.transform = CGAffineTransform(scaleX: 0.95, y: 0.9)
		UIView.animate(withDuration: 0.15, animations: { button.transform = CGAffineTransform.identity })
	}

	@objc private func onTapProfileButton() {
		if statusText != "" {
			statusLabel.text = statusText
			statusEditField.text = ""
			statusEditField.endEditing(true)
		}
	}

	@objc func statusTextChanged(_ textField: UITextField) {
		guard let text = textField.text else { return }

		if text != "" {
			statusText = text
		}
	}
}
