//
//  SearchHistoryTableViewCell.swift
//  NewsArticles
//
//  Created by Anastasia Kholod on 31.05.2022.
//

import UIKit

final class SearchHistoryTableViewCell: UITableViewCell, Reusable {
    let titleLabel: UILabel = {
        let obj = UILabel()
        obj.font = UIFont.OpenSans.regular(size: 14)
        obj.textColor = UIColor.Text.almostBlack
        obj.textAlignment = .left
        obj.numberOfLines = 1
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
        contentView.backgroundColor = UIColor.Main.backgroundGrey
        contentView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15.sizeH)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-10)
        }
    }
}
