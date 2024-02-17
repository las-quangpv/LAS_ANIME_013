//
//  PosterFavouriteVC.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 27/11/2023.
//

import UIKit

class PosterFavouriteVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tblListAnime: UITableView!
    
    var data:[Poster] = [];
    let databaseManager = DatabaseManager.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        data = databaseManager.getPostersWithFavouriteStatus()

        let nib = UINib(nibName: "PosterFavouriteCell", bundle: nil)
        tblListAnime.register(nib, forCellReuseIdentifier: "PosterFavouriteCell")
        tblListAnime.delegate = self
        tblListAnime.dataSource = self
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PosterFavouriteCell", for: indexPath) as? PosterFavouriteCell else { return UITableViewCell() }
        let poster: Poster = data[indexPath.row]
        cell.setData(poster: poster)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DrawPosterVC();
        vc.poster = data[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }

}
