//
//  ShadowView.swift
//  TranslateByCamera
//
//  Created by Tran Cuong on 26/10/2023.
//

import UIKit

@IBDesignable
class ShadowView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateProperties()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            updateProperties()
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            updateProperties()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            updateProperties()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            updateProperties()
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            updateProperties()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            updateProperties()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = false
        updateProperties()
        updateShadowPath()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateProperties()
        updateShadowPath()
    }
    
    func updateProperties() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    func updateShadowPath() {
        let bezierPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: cornerRadius)
        layer.shadowPath = bezierPath.cgPath
    }
}

