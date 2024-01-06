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
    private lazy var iconContainer = createIconContainer()
    private lazy var iconImageView = createIconImageView()
    private lazy var nameLabel = createNameLabel()
    private lazy var emailLabel = createEmailLabel()
    private lazy var nameTextField = createNameTextField()
    private lazy var nameTextFieldTitle = createTextFieldLabel(text: "Full Name")
    private lazy var emailTextField = createEmailTextField()
    private lazy var emailTextFieldTitle = createTextFieldLabel(text: "Email")
    private lazy var saveButton = createSaveButton()
    
    weak var delegate: ProfileViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        uploadUserDefaults()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //delegate?.uploadUserDefaults()
    }
  
}
//MARK: - Actions, UIImagePicker
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func changeProfileImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            userImageView.image = selectedImage
            saveAvatarToUserDefaults()
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
// MARK: - Text Fields Delegate
extension EditProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveNameToUserDefaults()
        saveEmailToUserDefaults()
        textField.resignFirstResponder()
        return true
    }
    
    @objc func hideKeyboard() {
        saveNameToUserDefaults()
        saveEmailToUserDefaults()
        view.endEditing(true)
    }
}

// MARK: - Setup UI
extension EditProfileViewController {
    // MARK: - create UI elements methods
    func createUserImage() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "ProfileImageSet/avatar"))
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    func createIconContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = .primarySoft
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        view.layer.masksToBounds = true
        return view
    }
    
    func createIconImageView() -> UIImageView{
        let imageView = UIImageView(image: UIImage(named: "ProfileImageSet/editAvatarImage"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
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
        textField.delegate = self
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
        textField.delegate = self
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
    func createTextFieldLabel(text: String) -> UILabel {
        UILabel(text: text, font: .boldSystemFont(ofSize: 13.0), textColor: .textColorWhite)
    }
    
    func createSaveButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Save Changes", for: .normal)
        button.backgroundColor = .primaryBlueAccent
        button.addTarget(self, action: #selector(saveChangesButtonTapped), for: .touchUpInside)
        return button
    }
    // MARK: - Setup View / Actions
    func setupUI() {
        setupView()
        setupTargets()
        setupConstraints()
    }
    
    func setupView() {
        title = "Edit Profile"
        view.backgroundColor = .primaryDark
        view.addSubview(userImageView)
        view.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(nameTextFieldTitle)
        view.addSubview(emailTextFieldTitle)
        view.addSubview(saveButton)
    }
    
    func setupTargets() {
        let tapChangeImageContainer = UITapGestureRecognizer(target: self, action: #selector(changeProfileImage))
        let tapChangeImage = UITapGestureRecognizer(target: self, action: #selector(changeProfileImage))
        let tapViewGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        iconContainer.addGestureRecognizer(tapChangeImageContainer)
        iconImageView.addGestureRecognizer(tapChangeImage)
        view.addGestureRecognizer(tapViewGesture)
    }
    
    @objc func saveChangesButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func uploadUserDefaults() {
        if let name = UserDefaults.standard.string(forKey: "name") {
            nameTextField.text = name
            nameLabel.text = name
        } else {
            nameLabel.text = "Tiffany"
            nameTextField.text = "Tiffany"
        }
        if let email = UserDefaults.standard.string(forKey: "email") {
            emailTextField.text = email
            emailLabel.text = email
            
        } else {
            emailTextField.text = "Tiffany007@gmail.com"
            emailLabel.text = "Tiffany007@gmail.com"
        }
        
        guard let data = UserDefaults.standard.data(forKey: "avatar") else {
            userImageView.image = UIImage(named: "ProfileImageSet/avatar")
            return
        }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        userImageView.image = UIImage(data: decoded)
        
    }
    
    func saveNameToUserDefaults() {
        let name = nameTextField.text
        UserDefaults.standard.set(name, forKey: "name")
    }
    
    func saveEmailToUserDefaults() {
        let email = emailTextField.text
        UserDefaults.standard.set(email, forKey: "email")
    }
    
    func saveAvatarToUserDefaults() {
        guard let data = userImageView.image?.jpegData(compressionQuality: 0.5) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: "avatar")
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        nameTextFieldTitle.translatesAutoresizingMaskIntoConstraints = false
        emailTextFieldTitle.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        userImageView.layer.cornerRadius = 60.0
        iconContainer.layer.cornerRadius = 20.0
        nameTextField.layer.cornerRadius = 30.0
        emailTextField.layer.cornerRadius = 30.0
        saveButton.layer.cornerRadius = 30.0
        
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0.0
        
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            userImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 120.0),
            userImageView.heightAnchor.constraint(equalToConstant: 120.0),
            
            iconContainer.heightAnchor.constraint(equalToConstant: 40.0),
            iconContainer.widthAnchor.constraint(equalToConstant: 40.0),
            iconContainer.bottomAnchor.constraint(equalTo: userImageView.bottomAnchor),
            iconContainer.trailingAnchor.constraint(equalTo: userImageView.trailingAnchor),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 15.0),
            iconImageView.widthAnchor.constraint(equalToConstant: 15.0),
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 30.0),
            nameLabel.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10.0),
            emailLabel.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 40.0),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            nameTextField.heightAnchor.constraint(equalToConstant: 60.0),
            
            nameTextFieldTitle.centerYAnchor.constraint(equalTo: nameTextField.topAnchor),
            nameTextFieldTitle.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: 15.0),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20.0),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            emailTextField.heightAnchor.constraint(equalToConstant: 60.0),
            
            emailTextFieldTitle.centerYAnchor.constraint(equalTo: emailTextField.topAnchor),
            emailTextFieldTitle.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: 15.0),
            
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            saveButton.heightAnchor.constraint(equalToConstant: 60.0),
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0 - tabBarHeight)
            
        ])
    }
    
    
}
