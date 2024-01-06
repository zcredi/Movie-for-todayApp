//
//  ProfileInteractor.swift
//  Movie for todayApp
//
//  Created by Andrei Shpartou on 26/12/2023.
//

import Foundation

protocol ProfileInteractionLogic: AnyObject {
    func fetchProfile()
}

class ProfileInteractor {
    // MARK: - External vars
    weak var presenter: ProfilePresentationLogic?
}

// MARK: - Interaction logic
extension ProfileInteractor: ProfileInteractionLogic {
    func fetchProfile() {
        presenter?.presentProfile()
    }
}
