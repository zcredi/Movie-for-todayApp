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

struct ProfileSection {
    let title: String
    let options: [ProfileDetailsOption]
}

struct ProfileDetailsOption {
    let title: String
    let image: UIImage?
    let imageBackGroundColor: UIColor
    let handler: (() -> Void)
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
// MARK: - ProfileTableViewCell type
//class ProfileTableViewCell: UITableViewCell {
//    func setup(with viewModel)
//}
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
//        tableView.register(ProfileDetailsTableViewCell.self,
//                           forCellReuseIdentifier: ProfileDetailsTableViewCell.identifier)
        tableView.register(ProfileDetailsTableViewCell.self,
                                   forCellReuseIdentifier: ProfileDetailsTableViewCell.identifier)
        //tableView.backgroundColor = UIColor.primaryDark
        return tableView
    }
    // MARK: - UI methods
    private func setupUI() {
        configure()
        setupView()
        setupConstraints()
    }
    
    private func configure() {
        //General section
        self.models.append(ProfileSection(title: "General", options: [
            ProfileDetailsOption(title: "Notification",
                                 image: UIImage(systemName: "bell.fill"),
                                 imageBackGroundColor: UIColor.primaryDark,
                                 handler: {
                                     print("Notification cell tapped")
                                 }),
            ProfileDetailsOption(title: "Language",
                                 image: UIImage(systemName: "pencil"),
                                 imageBackGroundColor: UIColor.primaryDark,
                                 handler: {
                                     print("Language cell tapped")
                                 })
        ]))
        //More section
        self.models.append(ProfileSection(title: "More", options: [
            ProfileDetailsOption(title: "Legal and Policies",
                                 image: UIImage(systemName: "list.bullet"),
                                 imageBackGroundColor: UIColor.primaryDark,
                                 handler: {
                                     print("More cell tapped")
                                 }),
            ProfileDetailsOption(title: "About Us",
                                 image: UIImage(systemName: "pencil.tip.crop.circle.badge.plus"),
                                 imageBackGroundColor: UIColor.primaryDark,
                                 handler: {
                                     print("About Us cell tapped")
                                 })
        ]))
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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileDetailsTableViewCell.identifier,
            for: indexPath
        ) as? ProfileDetailsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handler()
    }
    
}


 //MARK: - Preview
//import SwiftUI
//struct MainViewPreviews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIHelloWorldView()
//    }
//}
//struct SwiftUIHelloWorldView: UIViewRepresentable {
//    func makeUIView(context: Context) -> UIView {
//        return ProfileViewController().view
//    }
//    func updateUIView(_ view: UIView, context: Context) {}
//}
