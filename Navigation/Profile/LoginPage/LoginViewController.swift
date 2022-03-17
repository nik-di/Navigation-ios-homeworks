//
//  LoginViewController.swift
//  Navigation
//
//  Created by D.Nikishin on 12.03.2022.
//

import UIKit

class LoginViewController: UIViewController {
	var completion: (() -> Void)?

	private lazy var scrollView: UIScrollView = {
		let view = UIScrollView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	private lazy var textFieldsStackView: UIStackView = {
		let verticalStack = UIStackView()
		verticalStack.translatesAutoresizingMaskIntoConstraints = false
		verticalStack.clipsToBounds = true

		verticalStack.axis = .vertical
		verticalStack.distribution = .fillEqually
		verticalStack.layer.cornerRadius = 10
		verticalStack.layer.borderWidth = 0.5
		verticalStack.layer.borderColor = UIColor.lightGray.cgColor

		return verticalStack
	}()

	private lazy var logoVK: UIImageView = {
		guard let image = UIImage(named: "VK") else { return UIImageView() }
		let imageView = UIImageView(image: image)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	private lazy var emailField: UITextField = {
		return createFormTextField(placeholder: "Email or login")
	}()

	private lazy var passwordField: UITextField = {
		createFormTextField(placeholder: "Password", isPasswordField: true)
	}()

	private lazy var loginButton: UIButton = {
		let button = UIButton()
		let buttonImage = UIImage(named: "blue_pixel")

		if let img = buttonImage {
			let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
			let renderer = UIGraphicsImageRenderer(size: img.size)

			let result = renderer.image { ctx in
				ctx.fill(rect)

				img.draw(in: rect, blendMode: .normal, alpha: 0.8)
			}
			button.setBackgroundImage(result, for: .highlighted)
			button.setBackgroundImage(result, for: .selected)
			button.setBackgroundImage(result, for: .disabled)
		}
		button.setBackgroundImage(buttonImage, for: .normal)

		button.translatesAutoresizingMaskIntoConstraints = false
		button.clipsToBounds = true
		button.layer.cornerRadius = 10
		button.setTitle("Log In", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.addTarget(self, action: #selector(onTapLogin), for: .touchUpInside)

		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationController?.navigationBar.isHidden = true
		setupScreenView()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		let nc = NotificationCenter.default
		nc.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		nc.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		let nc = NotificationCenter.default
		nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
	}

	private func setupScreenView() {
		let contentView = UIView()
		contentView.translatesAutoresizingMaskIntoConstraints = false

		textFieldsStackView.addArrangedSubview(emailField)
		textFieldsStackView.addArrangedSubview(passwordField)

		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		contentView.addSubview(logoVK)
		contentView.addSubview(textFieldsStackView)
		contentView.addSubview(loginButton)

		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

			contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
			contentView.heightAnchor.constraint(equalToConstant: 510),

			logoVK.widthAnchor.constraint(equalToConstant: 100),
			logoVK.heightAnchor.constraint(equalToConstant: 100),
			logoVK.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			logoVK.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),

			textFieldsStackView.topAnchor.constraint(equalTo: logoVK.bottomAnchor, constant: 120),
			textFieldsStackView.heightAnchor.constraint(equalToConstant: 100),
			textFieldsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			textFieldsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

			loginButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 16),
			loginButton.heightAnchor.constraint(equalToConstant: 50),
			loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
		])
	}

	private func createFormTextField(placeholder: String, isPasswordField: Bool = false) -> UITextField {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.isSecureTextEntry = isPasswordField
		textField.placeholder = placeholder

		textField.textColor = .black
		textField.backgroundColor = .systemGray6
		textField.autocapitalizationType = .none
		textField.layer.borderColor = UIColor.lightGray.cgColor
		textField.layer.borderWidth = 0.5

		textField.font = UIFont(name: "System", size: 16)

		let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
		textField.leftView = paddingView
		textField.leftViewMode = .always

		return textField
	}

	private var isKeyboardShowing = false

	@objc func keyboardWillShow(_ notification: Notification) {
		if !isKeyboardShowing {
			guard let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

			let adjustmentHeight = keyboardFrame.cgRectValue.height
			scrollView.contentInset.bottom = adjustmentHeight
			scrollView.verticalScrollIndicatorInsets.bottom = adjustmentHeight
			scrollView.frame.origin.y -= logoVK.frame.origin.y
			isKeyboardShowing = true
		}
	}

	@objc func keyboardWillHide(_ notification: Notification) {
		scrollView.contentInset.bottom = .zero
		scrollView.verticalScrollIndicatorInsets.bottom = .zero
		scrollView.frame.origin.y = view.safeAreaLayoutGuide.layoutFrame.origin.y
		isKeyboardShowing = false
	}

	@objc private func onTapLogin(_ sender: UITextField) {
		emailField.endEditing(true)
		passwordField.endEditing(true)
		
		completion?()
	}
}
