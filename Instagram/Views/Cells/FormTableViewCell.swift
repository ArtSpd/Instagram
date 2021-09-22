//
//  FormTableViewCell.swift
//  Instagram
//
//  Created by Артем Волков on 21.09.2021.
//

import UIKit

protocol FormTableViewCellDelegate: AnyObject  {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel)
}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    static let identifier = "FormTableViewCell"
    var model: EditProfileFormModel?
    public weak var delegate: FormTableViewCellDelegate?
    
    private let formLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let field: UITextField = {
       let field = UITextField()
        field.returnKeyType = .done
        return field
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        field.delegate = self
        selectionStyle = .none
    }
    
    public func configure(with model: EditProfileFormModel){
        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        formLabel.frame = CGRect(x: 5, y: 0, width: contentView.width / 3, height: contentView.heigh)
        field.frame = CGRect(
            x: formLabel.right + 5,
            y: 0,
            width: contentView.width - formLabel.width - 10,
            height: contentView.heigh)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Field
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        guard let model = model else { return true }
        delegate?.formTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }
}
