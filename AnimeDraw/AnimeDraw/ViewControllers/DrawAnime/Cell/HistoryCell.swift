//
//  HistoryCell.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 28/11/2023.
//

import UIKit

class HistoryCell: UITableViewCell {
    @IBOutlet weak var myImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(history: History) {
        myImageView.image = Utils.load(fileName: history.url)
    }
}
