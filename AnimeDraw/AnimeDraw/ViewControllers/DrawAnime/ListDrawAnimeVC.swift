//
//  ListDrawAnimeVC.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 08/11/2023.
//

import UIKit

class ListDrawAnimeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblListAnime: UITableView!
    
    var data:[AnimeDraw] = [];
    let databaseManager = DatabaseManager.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        data = databaseManager.getAllAnimeDraws()

        let nib = UINib(nibName: "DrawAnimeCell", bundle: nil)
        tblListAnime.register(nib, forCellReuseIdentifier: "DrawAnimeCell")
        tblListAnime.delegate = self
        tblListAnime.dataSource = self
    }

    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func actionPractice(_ sender: Any) {
        let vc = HistoryDrawVC();
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DrawAnimeCell", for: indexPath) as? DrawAnimeCell else { return UITableViewCell() }
        let anime: AnimeDraw = data[indexPath.row]
        cell.setData(anime: anime)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let anime: AnimeDraw = data[indexPath.row]
        let detail = DrawAnimeVC();
        detail.modalPresentationStyle = .fullScreen
        detail.anime = anime;
        self.present(detail, animated: true)
    }

}
