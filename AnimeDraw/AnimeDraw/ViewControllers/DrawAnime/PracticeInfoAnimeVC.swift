//
//  PracticeInfoAnimeVC.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 08/11/2023.
//

import UIKit
import Parchment

class PracticeInfoAnimeVC: UIViewController {
    @IBOutlet weak var viewInfo: UIView!
    
    var listController = [DrawAnimePager]()
    var pagingViewController: PagingViewController = PagingViewController()
    let databaseManager = DatabaseManager.getInstance()
    var anime: AnimeDraw!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1..<self.anime.count + 1 {
            let controller = DrawAnimePager()
            controller.index = i - 1;
            controller.imageName = "\(anime.image)\(i)"
            
            listController.append(controller)
        }
        
        pagingViewController = PagingViewController(viewControllers: listController)
        pagingViewController.delegate = self
        pagingViewController.borderOptions = .hidden
        pagingViewController.menuBackgroundColor = .clear
        pagingViewController.indicatorColor = UIColor(white: 0, alpha: 0.4)
        pagingViewController.textColor = UIColor(white: 1, alpha: 0.6)
        pagingViewController.selectedTextColor = .white
        pagingViewController.indicatorColor = .white
        
        pagingViewController.select(index: self.anime.currentIndex, animated: true)
        
        addChild(pagingViewController)
        viewInfo.addSubview(pagingViewController.view)
        viewInfo.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)

    }

    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true)
    }

}

extension PracticeInfoAnimeVC: PagingViewControllerDelegate {
    func pagingViewController(_ pagingViewController: PagingViewController, didScrollToItem pagingItem: PagingItem, startingViewController: UIViewController?, destinationViewController: UIViewController, transitionSuccessful: Bool) {
        guard let destinationViewController = destinationViewController as? DrawAnimePager else { return }
        if(transitionSuccessful){
            let toIndex = destinationViewController.index;

        }
    }

}
