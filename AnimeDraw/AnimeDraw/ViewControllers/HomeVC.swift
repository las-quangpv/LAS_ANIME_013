//
//  HomeVC.swift
//  ThoiTietVietNam
//
//  Created by Tran Cuong on 29/10/2023.
//

import UIKit
import Lottie

class HomeVC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func actionShowMenu(_ sender: Any) {
    }
    
    
    @IBAction func actionDrawAnime(_ sender: Any) {
        let vc = ListDrawAnimeVC();
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func actionDrawPoster(_ sender: Any) {
        let vc = ListPosterVC();
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}
