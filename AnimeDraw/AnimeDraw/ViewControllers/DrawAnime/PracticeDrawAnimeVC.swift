//
//  PracticeDrawAnimeVC.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 28/11/2023.
//

import UIKit
import PencilKit

class PracticeDrawAnimeVC: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var heighcollection: NSLayoutConstraint!
    @IBOutlet weak var viewDraw: UIView!
    @IBOutlet weak var clvThubnail: UICollectionView!
    
    let databaseManager = DatabaseManager.getInstance()
    
    var canvasView: PKCanvasView!
    let toolPicker = PKToolPicker()
    var history: History?
    var anime: AnimeDraw?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCanvasView()
        
        
        if let history = history{
            print("history imageUrl: \(history.url)")
            if let data = Data(base64Encoded: history.drawingData),
               let drawing = try? PKDrawing(data: data) {
                canvasView.drawing = drawing
            }
        }
        
        if let anime = anime{
            clvThubnail.register(UINib(nibName: "DrawThumbnailCell", bundle: nil), forCellWithReuseIdentifier: "DrawThumbnailCell")
            clvThubnail.delegate = self
            clvThubnail.dataSource = self
        }else{
            heighcollection.constant = 0
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        canvasView.frame = viewDraw.bounds
    }
    
    func setupCanvasView() {
        canvasView = PKCanvasView(frame: viewDraw.bounds)
        canvasView.delegate = self
        canvasView.isOpaque = false
        canvasView.backgroundColor = .clear
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 5)

        viewDraw.addSubview(canvasView)

        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let anime = anime{
            return anime.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrawThumbnailCell", for: indexPath) as! DrawThumbnailCell
        if let anime = anime{
            cell.setData(image: "\(anime.image)\(indexPath.row + 1)")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func actionSave(_ sender: Any) {
        // Chuyển đổi PKCanvasView thành UIImage
        let image = canvasView.drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
        
        // Lưu UIImage vào hệ thống file và lấy URL
        let imageUrl = Utils.save(image: image)
        
        print("imageUrl: \(imageUrl)")
        
        if let drawingData = try? canvasView.drawing.dataRepresentation() {
            // Chuyển đổi Data thành chuỗi base64
            let drawingDataString = drawingData.base64EncodedString()
            
            if let history = history{
                databaseManager.updateHistoryItem(id: history.id, newURL: imageUrl, newDrawingData: drawingDataString)
            }else{
                if let anime = anime{
                    databaseManager.insertHistoryItem(url: imageUrl, drawingData: drawingDataString, anime: anime.id)
                }else{
                    databaseManager.insertHistoryItem(url: imageUrl, drawingData: drawingDataString, anime: 0)
                }
                
            }
        }
        self.dismiss(animated: true)
    }

}
