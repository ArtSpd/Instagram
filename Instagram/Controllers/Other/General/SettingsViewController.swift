//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Артем Волков on 19.09.2021.
//

import UIKit
import  SafariServices

struct SettingCellModel {
    let title: String
    let handler: (()->Void)
}

class SettingsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
    }
    
    func configureModels(){
        data.append([
            SettingCellModel(title: "Edite profile", handler: { [weak self] in
                self?.didTapEditProfile()
            }),
            SettingCellModel(title: "Invite friends", handler: { [weak self] in
                self?.didTapInviteFriends()
            }),
            SettingCellModel(title: "Save original post", handler: { [weak self] in
                self?.didTapSaveOriginalPost()
            }),
        ])
        
        data.append([
            SettingCellModel(title: "Terms of Service", handler: { [weak self] in
                self?.openURL(type: .terms)
            }),
            SettingCellModel(title: "Privacy Policy", handler: { [weak self] in
                self?.openURL(type: .privacy)
            }),
            SettingCellModel(title: "Help/Feedback", handler: { [weak self] in
                self?.openURL(type: .help)
            }),
                        ])
        
        data.append([
            SettingCellModel(title: "Log out", handler: { [weak self] in
                self?.didTapLogOut()
            })
        ])
        
        
    }
    enum SettingsURLType{
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsURLType){
        let urlString: String
        switch type {
        case .terms: urlString = "https://www.instagram.com/about/legal/terms/before-january-19-2013/"
        case .privacy: urlString = "https://help.instagram.com/519522125107875)"
        case .help: urlString = "https://help.instagram.com/contact/151081798582137"
    }
        
        guard let url = URL(string: urlString) else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
        
    
    private func didTapEditProfile(){
        let vc = EditProfileViewController()
        vc.title = "Edite profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    private func didTapInviteFriends(){
        // Showe share sheet
    }
    
    private func didTapSaveOriginalPost(){
       
    }
    
    private func didTapLogOut(){
        let alert = UIAlertController(title: "Log out", message: "Are you sure?", preferredStyle: .actionSheet)
        let actioncancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let logoutAction = UIAlertAction(title: "Log Out", style: .default){ _ in
            AuthManager.shared.logOut { result in
                DispatchQueue.main.async {
                    if result {
                        //present login
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: false) {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    } else {
                        fatalError("Could not log out user")
                    }
                }
              
            }
        }
        alert.addAction(actioncancel)
        alert.addAction(logoutAction)
        
        alert.popoverPresentationController?.sourceView = tableView
        alert.popoverPresentationController?.sourceRect = tableView.bounds
        present(alert, animated: true)
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    


}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
    
}
