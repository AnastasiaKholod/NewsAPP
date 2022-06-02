//
//  UITableViewCell+animation.swift
//

import UIKit

class AnimatedTableViewCell: UITableViewCell {
    var touchesBegan:Bool = false
    
    let cellMainView: UIView = {
        let obj = UIView()
        return obj
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchesBegan = true
        UIView.animate(withDuration: 0.2) {
            self.updateCellState()
        } completion: { _ in
            if !self.touchesBegan {
                UIView.animate(withDuration: 0.2) {
                    self.updateCellState()
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        touchesBegan = false

        UIView.animate(withDuration: 0.2) {
            if !self.cellMainView.isViewAnimating {
                UIView.animate(withDuration: 0.2) {
                    self.updateCellState()
                }
            }
        }
    }
}

 //    MARK: - Helpers and handlers
extension AnimatedTableViewCell {
    private func updateCellState() {
        cellMainView.transform =  touchesBegan ?  CGAffineTransform(scaleX: 0.97, y: 0.97) : .identity
    }
}

extension UIView {
    var isViewAnimating: Bool {
        return (layer.animationKeys()?.count ?? 0) > 0
    }
}
