    //
    //  DateTableViewCell.swift
    //  NewsArticles
    //
    //  Created by Anastasia Kholod on 31.05.2022.
    //

import UIKit
final class DateTableViewCell: UITableViewCell, Reusable {
    var pickedDateChanged: ((Date) -> Void)?
    
    var pickedDate: Date? {
        didSet {
            guard let pickedDate = pickedDate else {
                return
            }
            pickedDateChanged?(pickedDate)
        }
    }
    
    let titleLabel: UILabel = {
        let obj = UILabel()
        obj.font = UIFont.OpenSans.regular(size: 10)
        obj.textColor = UIColor.Main.orange
        obj.textAlignment = .left
        return obj
    }()
    
    let datePicker: UIDatePicker = {
        let obj = UIDatePicker()
        obj.datePickerMode = .date
        obj.preferredDatePickerStyle = .compact
        obj.backgroundColor = .Main.background
        obj.maximumDate = Date()
        return obj
    }()
    
    let leftIcon: UIImageView = {
        let obj = UIImageView()
        obj.image = UIImage(named:"calendar")
        return obj
    }()
    
    let separator: UIView = {
        let obj = UIView()
        obj.backgroundColor = UIColor.Main.orange
        return obj
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor.Main.background
        contentView.addSubview(titleLabel)
        contentView.addSubview(datePicker)
        contentView.addSubview(leftIcon)
        contentView.addSubview(separator)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20.sizeH)
            make.left.equalToSuperview().offset(16)
        }
        
        datePicker.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10.sizeH)
            make.height.equalTo(40)
            make.left.equalTo(titleLabel.snp.left)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        leftIcon.snp.makeConstraints { (make) in
            make.size.equalTo(16)
            make.centerY.equalTo(datePicker.snp.centerY)
            make.right.equalToSuperview().offset(-19)
        }
        
        separator.snp.makeConstraints { (make) in
            make.top.equalTo(datePicker.snp.bottom).offset(10)
            make.height.equalTo(1)
            make.left.right.equalToSuperview().inset(16)
        }
        
        datePicker.subviews[0].subviews[0].subviews[0].alpha = 0
        datePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
    }
}

    // MARK: - date pickers
    extension DateTableViewCell {
        @objc func datePickerChanged(picker: UIDatePicker) {
            pickedDate = picker.date
        }
    }
