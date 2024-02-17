//
//  DrawThumbnailCell.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 27/11/2023.
//

import UIKit

class DrawThumbnailCell: UICollectionViewCell {

    @IBOutlet weak var imgThumb: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(image: String) {
        imgThumb.image = UIImage.init(named: image)
    }
}
