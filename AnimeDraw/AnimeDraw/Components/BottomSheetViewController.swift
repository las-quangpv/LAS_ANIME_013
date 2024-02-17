//
//  BottomSheetViewController.swift
//  TranslateByCamera
//
//  Created by Tran Cuong on 10/11/2023.
//

import UIKit

class BottomSheetViewController: UIViewController {
    // Khai báo một property cho height của bottom sheet
    var bottomSheetHeight: CGFloat = 300
    
    // Khai báo một property cho dimming view
    private let dimmingView = UIView()
    
    init(height: CGFloat) {
        super.init(nibName: nil, bundle: nil)
        self.bottomSheetHeight = height
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cấu hình dimming view
        dimmingView.frame = self.view.bounds
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        dimmingView.alpha = 0 // Bắt đầu ẩn dimming view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped))
        dimmingView.addGestureRecognizer(tapGesture)
        self.view.addSubview(dimmingView)
        
        // Cấu hình view của bottom sheet
        self.view.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Hiển thị dimming view
        UIView.animate(withDuration: 0.3) {
            self.dimmingView.alpha = 1
        }
    }
    
    func presentBottomSheet(_ viewController: UIViewController, on parentViewController: UIViewController) {
        // Đặt chiều cao cho viewController cần hiển thị
        viewController.view.frame = CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: bottomSheetHeight)
        viewController.view.clipsToBounds = true
        
        // Thêm viewController vào child và view của nó vào bottomSheet
        self.addChild(viewController)
        self.view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        
        // Present bottomSheet viewController
        parentViewController.present(self, animated: false) {
            // Bắt đầu hiển thị dimming view cùng lúc với việc animate bottom sheet view
            UIView.animate(withDuration: 0.3) {
                self.dimmingView.alpha = 1
                viewController.view.frame.origin.y = self.view.bounds.height - self.bottomSheetHeight
            }
        }
    }

    
    @objc private func dimmingViewTapped() {
        // Khi dimming view được tap, animate và dismiss bottom sheet
        if let presentedVC = self.children.first {
            UIView.animate(withDuration: 0.3, animations: {
                presentedVC.view.frame.origin.y = self.view.bounds.height
                self.dimmingView.alpha = 0
            }) { _ in
                // Sau khi animate xong, dismiss bottom sheet
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
}

