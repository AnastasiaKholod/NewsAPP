//
//
//
//  FilterView
//	NewsArticle
//

import UIKit

class FilterView: UIView {
    let titleLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = UIColor.Main.almostBlack
        obj.font = UIFont.boldSystemFont(ofSize: 18)
        obj.text = "Filter"
        return obj
    }()
    
    let tableView: UITableView = {
        let obj = UITableView()
        obj.estimatedRowHeight = 50
        obj.rowHeight = UITableView.automaticDimension
        obj.separatorStyle = .none
        obj.backgroundColor = UIColor.Main.background
        return obj
    }()
    
    let applyButton: UIButton = {
        let obj = UIButton().orangeButton(title: "Apply Filter")
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.Main.background
        addSubview(titleLabel)
        addSubview(tableView)
        addSubview(applyButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaInsets.top).offset(17.sizeH)
            make.left.right.equalToSuperview().inset(16.sizeW)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15.sizeH)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(applyButton.snp.top)
        }
        
        applyButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaInsets.bottom).offset(-20.sizeH)
            make.centerX.equalToSuperview()
        }
    }
}
