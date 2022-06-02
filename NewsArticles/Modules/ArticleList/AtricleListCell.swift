//
//  AtriclesCell.swift
//

import UIKit

final class ArticlesTableViewCell: AnimatedTableViewCell, Reusable {
    var item: Article? {
        didSet {
            setupCell()
        }
    }
    
    let atricleImageView: UIImageView = {
        let obj = UIImageView()
        obj.contentMode = .scaleToFill
        return obj
    }()
    
    let titleLabel: UILabel = {
        let obj = UILabel()
        obj.font = UIFont.boldSystemFont(ofSize: 15)
        obj.textColor = UIColor.Text.almostBlack
        obj.textAlignment = .left
        obj.numberOfLines = 1
        return obj
    }()
    
    let subTitleLabel: UILabel = {
        let obj = UILabel()
        obj.font = UIFont.systemFont(ofSize: 12)
        obj.textColor = UIColor.Text.almostBlack
        obj.textAlignment = .left
        obj.numberOfLines = 3
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
        
        cellMainView.backgroundColor = UIColor.Main.background
        cellMainView.addShadow()
        
        contentView.addSubview(cellMainView)
        cellMainView.addSubview(atricleImageView)
        cellMainView.addSubview(titleLabel)
        cellMainView.addSubview(subTitleLabel)

        cellMainView.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview().inset(SizeHelper.sizeW(5))
            make.right.left.equalToSuperview().inset(14.sizeW)
        }
        
        atricleImageView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(124)
            make.height.equalTo(108)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15.sizeH)
            make.left.equalTo(atricleImageView.snp.right).offset(19.sizeW)
            make.right.equalToSuperview().offset(-10)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(4.sizeH)
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-10)
        }
    }
}

    // MARK: - Helpers and handlers
extension ArticlesTableViewCell {
    private func setupCell() {
        guard let item = item else { return }
        atricleImageView.loadFrom(URLAddress: item.image)
        titleLabel.text = item.title
        subTitleLabel.text = item.description
    }
}
