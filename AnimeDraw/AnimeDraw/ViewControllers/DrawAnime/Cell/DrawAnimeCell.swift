//
//  DrawAnimeCell.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 08/11/2023.
//

import UIKit

class DrawAnimeCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(anime: AnimeDraw) {
        img.image = UIImage.init(named: anime.image)
        lbTitle.text = anime.image
    }
}
