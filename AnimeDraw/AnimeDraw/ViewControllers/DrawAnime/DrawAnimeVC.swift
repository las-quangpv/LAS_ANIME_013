//
//  DrawAnimeVC.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 08/11/2023.
//

import UIKit
import Parchment

class DrawAnimeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var clvThubnail: UICollectionView!
    @IBOutlet weak var viewInfo: UIView!
    
    var listController = [DrawAnimePager]()
    var pagingViewController: PagingViewController = PagingViewController()
    let databaseManager = DatabaseManager.getInstance()
    var anime: AnimeDraw!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clvThubnail.register(UINib(nibName: "DrawThumbnailCell", bundle: nil), forCellWithReuseIdentifier: "DrawThumbnailCell")
        clvThubnail.delegate = self
        clvThubnail.dataSource = self
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.async {
            if self.anime.currentIndex != 0 {
                let indexPath = IndexPath(item: self.anime.currentIndex, section: 0)
                self.clvThubnail.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }
    }

    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func actionPractice(_ sender: Any) {
        let vc = PracticeDrawAnimeVC();
        vc.anime = anime
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.anime.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrawThumbnailCell", for: indexPath) as! DrawThumbnailCell
        cell.setData(image: "\(anime.image)\(indexPath.row + 1)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pagingViewController.select(index: indexPath.row, animated: true)
    }

}

extension DrawAnimeVC: PagingViewControllerDelegate {
    func pagingViewController(_ pagingViewController: PagingViewController, didScrollToItem pagingItem: PagingItem, startingViewController: UIViewController?, destinationViewController: UIViewController, transitionSuccessful: Bool) {
        guard let destinationViewController = destinationViewController as? DrawAnimePager else { return }
        if(transitionSuccessful){
            let toIndex = destinationViewController.index;
            databaseManager.updateCurrentIndex(forAnimeDrawID: anime.id, newIndex: toIndex)
            
            let indexPath = IndexPath(item: toIndex, section: 0)
            clvThubnail.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }

}
