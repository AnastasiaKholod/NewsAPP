    //
    //  SearchInOptionTableViewSell.swift
    //  NewsArticles
    //
    //  Created by Anastasia Kholod on 31.05.2022.
    //

import UIKit

final class SearchInOptionTableViewCell: UITableViewCell, Reusable {
    var switchChanged: ((Int)->())?
    let titleLabel: UILabel = {
        let obj = UILabel()
        obj.font = UIFont.OpenSans.regular(size: 14)
        obj.textColor = UIColor.Text.almostBlack
        obj.textAlignment = .left
        return obj
    }()
    
    let searchSwitch: UISwitch = {
        let obj = UISwitch()
        obj.isOn = true
        obj.setOn(true, animated: false)
        obj.onTintColor = .Main.orange
        obj.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        return obj
    }()
    
    let separator: UIView = {
        let obj = UIView()
        obj.backgroundColor = UIColor.Main.backgroundGrey
        return obj
    }()
    
        // MARK: - Initializators
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        contentView.backgroundColor = UIColor.Main.background
        contentView.addSubview(titleLabel)
        contentView.addSubview(searchSwitch)
        contentView.addSubview(separator)
        
        titleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.top.equalTo(contentView.snp.top).offset(20.sizeH)
            make.left.equalToSuperview().offset(10)
        }
        
        searchSwitch.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalToSuperview().offset(-19)
        }
        
        separator.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(22)
            make.bottom.equalTo(contentView.snp.bottom).offset(5)
            make.height.equalTo(1)
            make.left.right.equalToSuperview().inset(16)
        }
        
        searchSwitch.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
    }
}

    // MARK: - UISwitch
extension SearchInOptionTableViewCell {
    @objc func switchValueDidChange(_ sender: UISwitch!) {
        switchChanged?(sender.tag)
        if sender.isOn == true{
        }
        else{
        }
    }
}
