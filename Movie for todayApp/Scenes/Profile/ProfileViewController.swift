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
// MARK: - Profile Model
// Profile top image section
struct ProfileHeaderModel {
    let image: UIImage?
    let handler: (() -> Void)
}
// Profile settings menu items section
struct ProfileSettingsItemModel {
    let title: String
    let image: UIImage?
    let imageBackGroundColor: UIColor
    let handler: (() -> Void)
}
// Logout section
struct ProfileLogOutModel {
    let title: String
    let handler: (() -> Void)
}
// Section types
enum ProfileDetailsType {
    case header(model: ProfileHeaderModel)
    case settingsMenuItem(model: ProfileSettingsItemModel)
    case logout(model: ProfileLogOutModel)
}
struct ProfileSection {
    let title: String?
    let options: [ProfileDetailsType]
}
// MARK: - Profile View Controller
class ProfileViewController: UIViewController, UITableViewDelegate {
    // UI components
    private lazy var tableView = createTableView()
    // Internal vars
    private var models = [ProfileSection]()
    // External vars
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
        
        setupUI()
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
    // MARK: - UI Elements
    private func createTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ProfileHeaderCell.self,
                                   forCellReuseIdentifier: ProfileHeaderCell.identifier)
        tableView.register(ProfileSettingsItemCell.self,
                                   forCellReuseIdentifier: ProfileSettingsItemCell.identifier)
        tableView.register(ProfileLogOutCell.self,
                                   forCellReuseIdentifier: ProfileLogOutCell.identifier)
        //tableView.backgroundColor = UIColor.primaryDark
        return tableView
    }
    // MARK: - UI methods
    private func setupUI() {
        configure()
        setupView()
        setupConstraints()
    }
    // MARK: - Configure cell models
    private func configure() {
        // Header section
        let header: ProfileHeaderModel =
            .init(image: UIImage(systemName: "plane")) {
                print("Header")
            }
        // Settings section items
        // General
        let notification: ProfileSettingsItemModel =
            .init(title: "Notification",
                  image: UIImage(systemName: "bell.fill"),
                  imageBackGroundColor: .primaryDark) {
                print("Notification cell tapped")
            }
        let language: ProfileSettingsItemModel =
            .init(title: "Language",
                  image: UIImage(systemName: "pencil"),
                  imageBackGroundColor: .primaryDark) {
                print("Language cell tapped")
            }
        // More
        let legalAndPolicies: ProfileSettingsItemModel =
            .init(title: "Legal and Policies",
                  image: UIImage(systemName: "list.bullet"),
                  imageBackGroundColor: .primaryDark) {
                print("Legal and Policies cell tapped")
            }
        let aboutUs: ProfileSettingsItemModel =
            .init(title: "About Us",
                  image: UIImage(systemName: "pencil.tip.crop.circle.badge.plus"),
                  imageBackGroundColor: .primaryDark) {
                print("About Us cell tapped")
            }
        // Log out section
        let logOut: ProfileLogOutModel =
            .init(title: "LogOut") {
                print("LogOut")
            }
        
        // Header
        self.models.append(.init(title: nil, options: [
            .header(model: header)
        ]))
        // General
        self.models.append(.init(title: "General", options: [
            .settingsMenuItem(model: notification),
            .settingsMenuItem(model: language)
        ]))
        // More
        self.models.append(.init(title: "More", options: [
            .settingsMenuItem(model: legalAndPolicies),
            .settingsMenuItem(model: aboutUs)
        ]))
        // LogOut
        self.models.append(.init(title: nil, options: [
            .logout(model: logOut)
        ]))
        //
    }
    
    private func setupView() {
        title = "Profile"
        view.backgroundColor = UIColor.primaryDark
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    // MARK: - Constraints
    private func setupConstraints() {
        tableView.frame = view.bounds
    }
}
// MARK: - TableView data source
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        switch model.self {
        case .header(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileHeaderCell.identifier,
                for: indexPath
            ) as? ProfileHeaderCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .settingsMenuItem(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileSettingsItemCell.identifier,
                for: indexPath
            ) as? ProfileSettingsItemCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .logout(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileLogOutCell.identifier,
                for: indexPath
            ) as? ProfileLogOutCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self {
        case .header(let model):
            model.handler()
        case .settingsMenuItem:
            return
        case .logout(let model):
            model.handler()
        }
    }
}
