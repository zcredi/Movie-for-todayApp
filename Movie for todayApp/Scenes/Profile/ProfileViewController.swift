//
//  ProfileViewController.swift
//  Movie for todayApp
//
//  Created by Владислав on 25.12.2023.
//

import UIKit

protocol ProfileDisplayLogic: AnyObject {
    func displayProfile()
}

class ProfileViewController: UIViewController {
    // MARK: - UI components
    
    // MARK: - Internal vars
    
    // MARK: - External vars
    private weak var interactor: ProfileInteractionLogic?
    // MARK: - Initializing
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupVC()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupVC()
    }
    
    private func setupVC() {
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor()
        
        presenter.viewController = self
        interactor.presenter = presenter
        self.interactor = interactor
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
// MARK: - Display logic
extension ProfileViewController: ProfileDisplayLogic {
    func displayProfile() {
        // TODO: Display profile
    }
}
// MARK: - Setup UI
extension ProfileViewController {
    
    func setupView() {
        
    }
    
    func setupConstraints() {
        
    }
}
