//
//  ListPosterVC.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 27/11/2023.
//

import UIKit

class ListPosterVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    @IBOutlet weak var clvPoster: UICollectionView!
    
    
    var data:[Poster] = [];
    let databaseManager = DatabaseManager.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        data = databaseManager.getAllPosters()
        
        clvPoster.register(UINib(nibName: "PosterCell", bundle: nil), forCellWithReuseIdentifier: "PosterCell")
        clvPoster.delegate = self
        clvPoster.dataSource = self
    }

    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func actionFavourite(_ sender: Any) {
        let vc = PosterFavouriteVC();
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        cell.setData(poster: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 48) / 2, height: 128)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DrawPosterVC();
        vc.poster = data[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }

}
