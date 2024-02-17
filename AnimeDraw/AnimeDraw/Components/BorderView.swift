//
//  BorderView.swift
//  LastMovie007
//
//  Created by Tran Cuong on 04/10/2023.
//

import UIKit

class BorderView: UIView {
    
    @IBInspectable var topLeft: Bool = false {
        didSet {
            updateCornerMask()
        }
    }
    
    @IBInspectable var topRight: Bool = false {
        didSet {
            updateCornerMask()
        }
    }
    
    @IBInspectable var bottomLeft: Bool = false
    @IBInspectable var bottomRight: Bool = false
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            updateCornerMask()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerMask()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
    }
    
    private func updateCornerMask() {
        let maskPath = UIBezierPath()
        let allCorners: [Bool] = [topLeft, topRight, bottomRight, bottomLeft]
        
        // Case 1: Bo tròn 2 góc trên
        if allCorners.filter({ $0 }).count == 2 && topLeft && topRight {
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            return
        }
        
        // Case 2: Bo tròn tất cả 4 góc
        if allCorners.allSatisfy({ $0 }) {
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            return
        }
        
        // Case 3: Bo tròn 2 góc dưới
        if allCorners.filter({ $0 }).count == 2 && bottomLeft && bottomRight {
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            return
        }
        
        // Case 4: Bo tròn 2 góc trai
        if allCorners.filter({ $0 }).count == 2 && bottomLeft && topLeft {
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            return
        }
        
        // Case 4: Bo tròn 2 góc phai
        if allCorners.filter({ $0 }).count == 2 && bottomRight && topRight {
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            return
        }
        
        // Xử lý trường hợp không có góc nào hoặc các góc riêng lẻ
        layer.cornerRadius = 0
        layer.maskedCorners = []
        
        if topLeft {
            layer.maskedCorners.insert(.layerMinXMinYCorner)
        }
        
        if topRight {
            layer.maskedCorners.insert(.layerMaxXMinYCorner)
        }
        
        if bottomLeft {
            layer.maskedCorners.insert(.layerMinXMaxYCorner)
        }
        
        if bottomRight {
            layer.maskedCorners.insert(.layerMaxXMaxYCorner)
        }
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
    }
}


