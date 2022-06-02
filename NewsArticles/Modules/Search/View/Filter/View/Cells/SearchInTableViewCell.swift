//
//  SearchInTableViewCell.swift
//  NewsArticles
//
//  Created by Anastasia Kholod on 31.05.2022.
//

import UIKit

final class SearchInTableViewCell: UITableViewCell, Reusable {
    let titleLabel: UILabel = {
        let obj = UILabel()
        obj.font = UIFont.OpenSans.regular(size: 14)
        obj.textColor = UIColor.Text.almostBlack
        obj.textAlignment = .left
        obj.text = "Search in"
        return obj
    }()
    
    let leftLabel: UILabel = {
        let obj = UILabel()
        obj.font = UIFont.OpenSans.regular(size: 14)
        obj.textColor = UIColor.Text.lightGrey
        obj.textAlignment = .right
        obj.text = "All"
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
        contentView.addSubview(leftLabel)
        contentView.addSubview(separator)

        titleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(24)
            make.top.equalTo(contentView.snp.top).offset(25.sizeH)
            make.left.equalToSuperview().offset(16)
        }
        
        leftLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalToSuperview().offset(-19)
        }
        
        separator.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(22)
            make.bottom.equalTo(contentView.snp.bottom).offset(10)
            make.height.equalTo(1)
            make.left.right.equalToSuperview().inset(16)
        }
    }
}
