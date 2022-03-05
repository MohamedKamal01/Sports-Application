//
//  Animation.swift
//  Sports
//
//  Created by Mohamed Kamal on 02/03/2022.
//

import UIKit

class Animation: UITabBarController {

    private let imageView: UIImageView = {
       let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "1024-1")
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(imageView)
        imageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute:{
            self.animated()
        })
    }
    func animated()
    {
        UIView.animate(withDuration: 0.5, animations: {
            let size = self.view.frame.size.width * 2
            let diffx = size - self.view.frame.size.width
            let diffy = self.view.frame.size.height - size
            self.imageView.frame = CGRect(x: -(diffx/2), y: diffy/2, width: size, height: size)
            self.imageView.alpha = 0
            
        })
    }


}
