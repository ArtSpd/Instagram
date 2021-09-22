//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Артем Волков on 19.09.2021.
//

import UIKit

struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
}

 class EditProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()
    
    private var models = [[EditProfileFormModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        
        tableView.tableHeaderView = createHederView()
        tableView.dataSource = self
        view.addSubview(tableView)
        
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem  = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        
    }
    
    private func configureModels(){
        // name, username, website, bio
        let section1Labels = ["Name", "Username", "Website", "Bio"]
        var section1 = [EditProfileFormModel]()
        for label in section1Labels{
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)", value: nil)
            section1.append(model)
        }
        models.append(section1)
        
        // email, phone, gender
        let section2Labels = ["Email", "Phone", "Gender"]
        var section2 = [EditProfileFormModel]()
        for label in section2Labels{
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)", value: nil)
            section2.append(model)
        }
        models.append(section2)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - TableView
    
    private func createHederView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.heigh / 4.0).integral)
        let size = header.heigh / 1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width - size) / 2, y: (header.heigh - size) / 2, width: size, height: size ))
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size/2
        profilePhotoButton.tintColor = .label
        profilePhotoButton.addTarget(self, action: #selector(didtapProfilePhotoButton), for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return header
    }
    
    @objc private func didtapProfilePhotoButton(){
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        cell.delegate = self
        cell.configure(with: model )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else { return nil }
        return "Private Information"
    }
    
    
    // MARK: - Action
    
    @objc private func didTapSave(){
        dismiss(animated: true)
    }
    @objc private func didTapCancel(){
        dismiss(animated: true)
    }

    @objc func didTapChangeProfilePicture(){
        let actionSheet = UIAlertController(title: "Profile pickcher", message: "Change profile pic", preferredStyle: .actionSheet)
        let takePhoto = UIAlertAction(title: "Take photo", style: .default) { _ in
            
        }
        let chooseLibrary = UIAlertAction(title: "Choose from library", style: .default) { _ in
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(takePhoto)
        actionSheet.addAction(chooseLibrary)
        actionSheet.addAction(cancel)
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionSheet, animated: true)
    }
    
    

}

extension EditProfileViewController: FormTableViewCellDelegate{
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
        print("Model updated ")
    }
    
    
}
