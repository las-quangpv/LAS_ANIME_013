//
//  DrawPosterVC.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 08/11/2023.
//

import UIKit
import Alamofire
import AlamofireImage
import PencilKit

class DrawPosterVC: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    var canvasView: PKCanvasView!
    let toolPicker = PKToolPicker()
    
    var poster: Poster!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AF.request(poster.image ,method: .get).response{ response in
            
            switch response.result {
            case .success(let responseData):
                self.myImageView.image = UIImage(data: responseData!, scale:1)
            case .failure(let error):
                print("error--->",error)
            }
        }
        
        canvasView = PKCanvasView(frame: myImageView.frame) // Sử dụng frame thay vì bounds
        canvasView.delegate = self
        canvasView.isOpaque = false
        canvasView.backgroundColor = .clear
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 5)
        
        // Thêm canvasView không phải như một subview của imageView, mà là một view riêng biệt
        view.addSubview(canvasView)
        view.bringSubviewToFront(canvasView) // Đảm bảo canvasView nằm trên cùng
        
        // Cấu hình toolPicker
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func actionSave(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(myImageView.bounds.size, false, UIScreen.main.scale)
        myImageView.image?.draw(in: myImageView.bounds)
        canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func actionShare(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(myImageView.bounds.size, false, UIScreen.main.scale)
        myImageView.image?.draw(in: myImageView.bounds)
        canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Kiểm tra xem hình ảnh đã được tạo thành công hay không
        if let imageToShare = combinedImage {
            let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
            
            // Trên iPad, bạn cần cung cấp anchor cho popover
            if let popoverController = activityViewController.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
            
            // Hiển thị view controller chia sẻ
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
}
