//
//  DrawAnimePager.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 08/11/2023.
//

import UIKit

class DrawAnimePager: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    var index: Int = 0;
    var imageName: String = "";

    override func viewDidLoad() {
        super.viewDidLoad()

        image.image = UIImage(named: imageName)
    }


 

}
