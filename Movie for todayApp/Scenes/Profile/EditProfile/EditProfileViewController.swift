//
//  EditProfileViewController.swift
//  Movie for todayApp
//
//  Created by Andrei Shpartou on 03/01/2024.
//

import UIKit

class EditProfileViewController: UIViewController {
    // UI elements
    private lazy var userImageView = createUserImage()
    private lazy var nameLabel = createNameLabel()
    private lazy var emailLabel = createEmailLabel()
    private lazy var nameTextField = createNameTextField()
    private lazy var emailTextField = createEmailTextField()
    private lazy var saveButton = createSaveButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

// MARK: - Setup UI
extension EditProfileViewController {
    
    func createUserImage() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "ProfileImageSet/avatar"))
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    // create edit icon
    func createNameLabel() -> UILabel {
        UILabel(text: "Tiffany", font: .montserratSemiBold16(), textColor: .textColorWhite)
    }
    
    func createEmailLabel() -> UILabel {
        UILabel(text: "Tiffany007@gmail.com", font: .montserratRegular10(), textColor: .textColorGrey)
    }
    
    func createNameTextField() -> UITextField {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        textField.layer.borderWidth = 2.0
        textField.font = .montserratMedium14()
        textField.textColor = .textColorWhite
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.size.height))
        return textField
    }
    
    func createEmailTextField() -> UITextField {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email Address",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        textField.layer.borderWidth = 2.0
        textField.font = .montserratMedium14()
        textField.textColor = .textColorWhite
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.size.height))
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        return textField
    }
    // title for TextField
    func createTextFieldLabel(with text: String) -> UILabel {
        UILabel(text: text, font: .montserratSemiBold14(), textColor: .textColorWhite)
    }
    
    func createSaveButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Save Changes", for: .normal)
        
        return button
    }
    
    func setupUI() {
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        title = "Edit Profile"
        view.backgroundColor = .primaryDark
        view.addSubview(userImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(saveButton)
    }
    // MARK: - Constraints
    func setupConstraints() {
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        userImageView.layer.cornerRadius = 60.0
        nameTextField.layer.cornerRadius = 30.0
        emailTextField.layer.cornerRadius = 30.0
        saveButton.layer.cornerRadius = 30.0
        
        
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            userImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 120.0),
            userImageView.heightAnchor.constraint(equalToConstant: 120.0),
            
            nameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 30.0),
            nameLabel.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10.0),
            emailLabel.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 40.0),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            nameTextField.heightAnchor.constraint(equalToConstant: 60.0),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20.0),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            emailTextField.heightAnchor.constraint(equalToConstant: 60.0),
            
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50.0),
            saveButton.heightAnchor.constraint(equalToConstant: 60.0)
            
            
        ])
    }
    
    
}
