//
//  NotificationController.swift
//  Vwitter
//
//  Created by macbook on 2023/10/05.
//

import UIKit

class NotificationController: UIViewController {
    
    // 속성
    
    // 라이프사이클

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // 헬퍼
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "알림"
    }
}
