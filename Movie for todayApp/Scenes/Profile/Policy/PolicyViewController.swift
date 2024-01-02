//
//  PolicyViewController.swift
//  Movie for todayApp
//
//  Created by Andrei Shpartou on 30/12/2023.
//

import UIKit

struct PolicyModel {
    let sectionTitle: String
    let sectionText: String
}

class PolicyViewController: UIViewController {
    // UI components
    private lazy var tableView = createTableView()
    // Internal vars
    private var models = [PolicyModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

// MARK: - SetupUI
extension PolicyViewController {
    
    // UI elements
    private func createTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .primaryDark
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PolicyCell.self,
                           forCellReuseIdentifier: PolicyCell.identifier)
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
        models.append(PolicyModel(
            sectionTitle: "Terms",
            sectionText: """
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit.Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.
                        
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.
                        """
        ))
        models.append(PolicyModel(
            sectionTitle: "Changes to the Service and/or Terms",
            sectionText: """
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit.Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.
                        
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.
                        """
        ))
    }
    
    private func setupView() {
        title = "Privacy Policy"
        view.backgroundColor = .primaryDark
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10.0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PolicyViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return models[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PolicyCell.identifier,
            for: indexPath
        ) as? PolicyCell else {
            return UITableViewCell()
        }
        cell.configure(with: models[indexPath.row].sectionText)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowSize = tableView.frame.size.height / 2.7
        return rowSize
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .montserratSemiBold18()
        header.textLabel?.textColor = .textColorWhite
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
}
