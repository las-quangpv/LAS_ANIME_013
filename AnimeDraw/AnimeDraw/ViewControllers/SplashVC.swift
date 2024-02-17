//
//  SplashVC.swift
//  ThoiTietVietNam
//
//  Created by Tran Cuong on 14/10/2023.
///Users/trancuong/Desktop/anim_loading.json

import Foundation
import UIKit
import Lottie

class SplashVC: UIViewController  {
    
    @IBOutlet weak var viewLoading: UIView!
    
    private let animationLoading = LottieAnimationView(name: "anim_loading")
    
    private var timer: Timer?
    private var timeLoading = 3
    var isReset = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.countLoading)), userInfo: nil, repeats: true)
    }
    
    @objc func countLoading() {
        if timeLoading == 0 {
            gotoNextVC()
        } else {
            timeLoading = timeLoading - 1
        }
    }
    
    func gotoNextVC(){
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
        }
        
        self.navigationController?.pushViewController(HomeVC(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animationLoading.contentMode = .scaleAspectFit
        viewLoading.addSubview(animationLoading)
        animationLoading.frame = CGRect(x: 0, y: 0, width: viewLoading.frame.width, height: viewLoading.frame.height)
        DispatchQueue.main.async {
            self.animationLoading.play(fromProgress: 0,
                                       toProgress: 1,
                                       loopMode: LottieLoopMode.loop,
                                       completion: { (finished) in})
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.animationLoading.stop()
    }
}
