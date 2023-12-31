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
// Profile top image section model
struct ProfileHeaderModel {
    let image: UIImage?
    let name: String
    let email: String
    let handler: (() -> Void)
}
// Profile settings menu items section model
struct ProfileSettingsItemModel {
    let title: String
    let image: UIImage?
    let handler: (() -> Void)
}
// Logout section model
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
class ProfileViewController: UIViewController {
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
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .primaryDark
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileHeaderCell.self,
                           forCellReuseIdentifier: ProfileHeaderCell.identifier)
        tableView.register(ProfileSettingsItemCell.self,
                           forCellReuseIdentifier: ProfileSettingsItemCell.identifier)
        tableView.register(ProfileLogOutCell.self,
                           forCellReuseIdentifier: ProfileLogOutCell.identifier)
        return tableView
    }
    // MARK: - UI methods
    private func setupUI() {
        configureModel()
        setupView()
        setupConstraints()
    }
    // MARK: - Configure cell models
    private func configureModel() {
        // Header section
        let header: ProfileHeaderModel =
            .init(image: UIImage(named: "ProfileImageSet/avatar"), name: "Tiffany", email: "Tiffany007@gmail.com") {
                print ("Pass to Edit Profile screen")
            }
        // Settings section items
        // General
        let notification: ProfileSettingsItemModel =
            .init(title: "Notification",
                  image: UIImage(named: "ProfileImageSet/notification")) {
                print("Notification")
            }
        let language: ProfileSettingsItemModel =
            .init(title: "Language",
                  image: UIImage(named: "ProfileImageSet/globe")) {
                print("Language")
            }
        // More
        let legalAndPolicies: ProfileSettingsItemModel =
            .init(title: "Legal and Policies",
                  image: UIImage(named: "ProfileImageSet/shield")) {
                self.navigationController?.pushViewController(PolicyViewController(), animated: true)
                print("Legal and Policies")
            }
        let aboutUs: ProfileSettingsItemModel =
            .init(title: "About Us",
                  image: UIImage(named: "ProfileImageSet/alert")) {
                print("About Us cell")
            }
        // Log out section
        let logOut: ProfileLogOutModel =
            .init(title: "Log Out") {
                print("Log Out")
            }
        // Configure sections
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
    }
    
    private func setupView() {
        title = "Profile"
        view.backgroundColor = .primaryDark
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
// MARK: - TableView
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    // Default settings
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
    // Choose custom UITableViewCell type depending on the model
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
    // Cells custom handlers
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self {
        case .header(let model):
            model.handler()
        case .settingsMenuItem(let model):
            model.handler()
        case .logout(let model):
            model.handler()
        }
    }
    // MARK: - TableView sections appearance
    // Set custom cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self {
        case .header:
            return 100.0
        default:
            return tableView.rowHeight
        }
    }
    // Section merge borders
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cornerRadius: CGFloat = 0.0
        cell.backgroundColor = UIColor.clear
        let layer: CAShapeLayer = CAShapeLayer()
        let pathRef: CGMutablePath = CGMutablePath()
        //dx leading an trailing margins
        let bounds: CGRect = cell.bounds.insetBy(dx: 0, dy: 0)
        var addLine: Bool = false
        
        if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            pathRef.__addRoundedRect(transform: nil, rect: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
        } else if indexPath.row == 0 {
            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.minY),
                           tangent2End: CGPoint(x: bounds.midX, y: bounds.minY),
                           radius: cornerRadius)
            
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.minY),
                           tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY),
                           radius: cornerRadius)
            pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
            addLine = true
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.maxY),
                           tangent2End: CGPoint(x: bounds.midX, y: bounds.maxY),
                           radius: cornerRadius)
            
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.maxY),
                           tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY),
                           radius: cornerRadius)
            pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        } else {
            pathRef.addRect(bounds)
            addLine = true
        }
        
        layer.path = pathRef
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.lineWidth = 0.5
        if let _ = cell as? ProfileLogOutCell {
            layer.fillColor = #colorLiteral(red: 0.3127486737, green: 0, blue: 0.09362361296, alpha: 0.1648082386)
        } else {
            layer.fillColor = UIColor.primaryDark.cgColor
        }
        
        if addLine == true {
            let lineLayer: CALayer = CALayer()
            let lineHeight: CGFloat = 0.2
            lineLayer.frame = CGRect(x: bounds.minX + 20, y: bounds.size.height - lineHeight, width: bounds.size.width - 40, height: lineHeight)
            lineLayer.backgroundColor = UIColor.lightGray.cgColor
            layer.addSublayer(lineLayer)
        }
        
        let backgroundView: UIView = UIView(frame: bounds)
        backgroundView.layer.insertSublayer(layer, at: 0)
        backgroundView.backgroundColor = .primaryDark
        cell.backgroundView = backgroundView
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .montserratSemiBold18()
        header.textLabel?.textColor = .textColorWhite
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
}
