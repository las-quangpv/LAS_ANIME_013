//
//  BaseViewController.swift
//  ThoiTietVietNam
//
//  Created by Tran Cuong on 05/10/2023.
//

import UIKit
import SwiftSoup

class BaseViewController: UIViewController {
    var loadingView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func removeBlurView() {
        // Loại bỏ blurView
        for subview in view.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }
    
    
    func showLoading() {
        if loadingView == nil {
            loadingView = UIView(frame: view.bounds)
            loadingView?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.center = loadingView!.center
            activityIndicator.startAnimating()
            
            loadingView?.addSubview(activityIndicator)
            view.addSubview(loadingView!)
        }
    }
    
    
    // Hàm ẩn view loading
    func hideLoading() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }

    
    func generateDateArray(from baseDate: String, numberOfDays: Int) -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let startDate = dateFormatter.date(from: baseDate) else {
            return []
        }
        
        var dateArray = [String]()
        let calendar = Calendar.current
        
        for i in 0..<numberOfDays {
            if let nextDate = calendar.date(byAdding: .day, value: i, to: startDate) {
                let formattedDate = dateFormatter.string(from: nextDate)
                dateArray.append(formattedDate)
            }
        }
        
        return dateArray
    }

}
