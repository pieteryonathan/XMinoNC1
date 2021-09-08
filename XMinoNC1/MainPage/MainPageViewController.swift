//
//  MainPageViewController.swift
//  XMinoNC1
//
//  Created by Pieter Yonathan on 30/04/21.
//

import UIKit

class MainPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameminoidle = ["MinoIdle1","MinoIdle2", "MinoIdle3", "MinoIdle4", "MinoIdle5"]
        var images = [UIImage] ()
        for i in 0..<nameminoidle.count{
            images.append(UIImage(named: nameminoidle[i])!)
        }
        
        gifview.animationImages = images
        gifview.animationDuration = 1.0
        gifview.startAnimating()
        
        startbox.backgroundColor = UIColor(red: 0.65, green: 0.21, blue: 0.21, alpha: 1)
        let layer = UIView()
        startbox.layer.cornerRadius = 10
        view.addSubview(layer)
    }
    
    @IBOutlet weak var xminotitle: UILabel!
    @IBOutlet weak var startbox: UIView!
    @IBAction func startbutton(_ sender: Any) {
    }
    @IBOutlet weak var gifview: UIImageView!
}
