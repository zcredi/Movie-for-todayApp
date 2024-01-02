//
//  ProfilePresenter.swift
//  Movie for todayApp
//
//  Created by Andrei Shpartou on 26/12/2023.
//

import Foundation

protocol ProfilePresentationLogic: AnyObject {
    func presentProfile()
}

class ProfilePresenter {
    // MARK: - External vars
    weak var viewController: ProfileDisplayLogic?
}
// MARK: - Presentation logic
extension ProfilePresenter: ProfilePresentationLogic {
    func presentProfile() {
        //
    }
}
