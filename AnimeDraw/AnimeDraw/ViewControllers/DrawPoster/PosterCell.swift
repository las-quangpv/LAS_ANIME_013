//
//  PosterCell.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 27/11/2023.
//

import UIKit
import Alamofire
import AlamofireImage
import Kingfisher

class PosterCell: UICollectionViewCell {

    @IBOutlet weak var imgFavourite: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    
    var poster: Poster!
    let databaseManager = DatabaseManager.getInstance()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(poster: Poster) {
        self.poster = poster;
//        AF.request( poster.image ,method: .get).response{ response in
//
//            switch response.result {
//            case .success(let responseData):
//                self.myImageView.image = UIImage(data: responseData!, scale:1)
//            case .failure(let error):
//                print("error--->",error)
//            }
//        }
        let url = URL(string: poster.image)
        myImageView.kf.setImage(with: url)
        if(self.poster.favourite.isEmpty){
            imgFavourite.image = UIImage.init(named: "star_black")
        }else{
            imgFavourite.image = UIImage.init(named: "star_favourite")
        }
    }
    
    @IBAction func actionAddFavorite(_ sender: Any) {
        if(self.poster.favourite.isEmpty){
            imgFavourite.image = UIImage.init(named: "star_favourite")
            databaseManager.updatePosterFavouriteStatus(forPosterID: self.poster.id, newFavouriteStatus: "1")
        }else{
            imgFavourite.image = UIImage.init(named: "star_black")
            databaseManager.updatePosterFavouriteStatus(forPosterID: self.poster.id, newFavouriteStatus: "")
        }
    }
    
}
