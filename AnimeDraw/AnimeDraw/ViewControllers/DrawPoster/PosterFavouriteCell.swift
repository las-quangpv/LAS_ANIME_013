//
//  PosterFavouriteCell.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 27/11/2023.
//

import UIKit
import Alamofire
import AlamofireImage

class PosterFavouriteCell: UITableViewCell {
    @IBOutlet weak var myImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(poster: Poster) {
        let url = URL(string: poster.image)
        myImageView.kf.setImage(with: url)
    }
}
