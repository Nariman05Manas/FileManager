//
//  ParametrsViewController.swift
//  FileManagerI_Ios-18
//
//  Created by qwerty on 14.07.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 100
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        initialLayout()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ParametrsViewCell.self, forCellReuseIdentifier: "parametrsCell")
        
    }
    
    func initialLayout() {
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                                    ])
    }
    
    func tapEditPassword() {
        DispatchQueue.main.async {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .automatic
            self.navigationController?.present(loginVC, animated: true)
        }
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Settings"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            tapEditPassword()
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "parametrsCell", for: indexPath) as? ParametrsViewCell else { return UITableViewCell()}
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            var label: UIListContentConfiguration = cell.defaultContentConfiguration()
            label.text = "Изменить пароль"
            cell.contentConfiguration = label
            return cell
        }
        return UITableViewCell()
    }
    
    
}
