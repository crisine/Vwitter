//
//  FeedController.swift
//  Vwitter
//
//  Created by macbook on 2023/10/05.
//

import UIKit

class FeedController: UIViewController {
    
    // 속성
    
    // 라이프사이클

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // 헬퍼
    
    func configureUI() {
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named:"twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
    }
}
