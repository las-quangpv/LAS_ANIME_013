//
//  HistoryDrawVC.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 28/11/2023.
//

import UIKit

class HistoryDrawVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var tblList: UITableView!
    
    var data:[History] = [];
    let databaseManager = DatabaseManager.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "HistoryCell", bundle: nil)
        tblList.register(nib, forCellReuseIdentifier: "HistoryCell")
        tblList.delegate = self
        tblList.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        data = databaseManager.getAllHistoryItems()
        tblList.reloadData()
        
        if(data.count > 0){
            viewEmpty.isHidden = true
        }else{
            viewEmpty.isHidden = false
        }
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func actionStart(_ sender: Any) {
        let vc = PracticeDrawAnimeVC();
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else { return UITableViewCell() }
        let history: History = data[indexPath.row]
        cell.setData(history: history)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let history: History = data[indexPath.row]
        let vc = PracticeDrawAnimeVC();
        if(history.anime > 0){
            vc.anime = databaseManager.getAnimeDrawByID(id: history.anime)
        }
        vc.history = history
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}
