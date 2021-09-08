//
//  Level1ViewController.swift
//  XMinoNC1
//
//  Created by Pieter Yonathan on 01/05/21.
//

import UIKit

class Level1ViewController: UIViewController {
    
    @IBOutlet weak var youwintext: UILabel!
    var hp = 1.0
    override func viewDidLoad() {
        
        super.viewDidLoad()
        continuebtn.isHidden = true
        continuebtn.layer.cornerRadius = 10
        youwintext.isHidden = true
        hp = 1.0
        hpbar.progress = Float(hp)
        
        //Animating Mino Idle
        let nameminoidle = ["MinoIdle1","MinoIdle2", "MinoIdle3", "MinoIdle4", "MinoIdle5"]
        var images = [UIImage] ()
        for i in 0..<nameminoidle.count{
            images.append(UIImage(named: nameminoidle[i])!)
        }
        
       mino.animationImages = images
       mino.animationDuration = 1.0
       mino.startAnimating()
      
        //Animating Skeleton Idle
        let skeletonidle = ["SkeletonIdle1","SkeletonIdle2", "SkeletonIdle3", "SkeletonIdle4",]
        var skeletonimg = [UIImage] ()
        for i in 0..<skeletonidle.count{
            skeletonimg.append(UIImage(named: skeletonidle[i])!)
        }
        
       skeleton.animationImages = skeletonimg
       skeleton.animationDuration = 1.0
       skeleton.startAnimating()
        
        // Animating Text Tap
        let taptext = ["Tap1","Tap2", "Tap3", "Tap4", "Tap5", "Tap6"]
        var textimg = [UIImage] ()
        for i in 0..<taptext.count{
            textimg.append(UIImage(named: taptext[i])!)
        }
        
       texttap.animationImages = textimg
       texttap.animationDuration = 1.0
        texttap.startAnimating()
        
        if hpbar.progress == 0.0{
            texttap.isHidden = true
            mino.startAnimating()
            skeleton.startAnimating()
        }
    }
    @IBOutlet weak var continuebtn: UIButton!
    @IBOutlet weak var hptext: UILabel!
    @IBOutlet weak var texttap: UIImageView!
    @IBOutlet weak var skeleton: UIImageView!
    @IBOutlet weak var tapicon: UIImageView!
    @IBOutlet weak var mino: UIImageView!
    @IBOutlet weak var hpbar: UIProgressView!
    @IBAction func didtap(_ sender: UIButton) {

        tapicon.isHidden = true
        
        hp -= 0.07
        hpbar.progress = Float(hp)

        let minoatt = ["MinoAtt-1","MinoAtt-2", "MinoAtt-3", "MinoAtt-4", "MinoAtt-5", "MinoAtt-6", "MinoAtt-7", "MinoAtt-8", "MinoAtt-9"]
        
        var imagesatt = [UIImage] ()
        for i in 0..<minoatt.count{
            imagesatt.append(UIImage(named: minoatt[i])!)
        }
        
        let minowin = ["MinoWin1","MinoWin2", "MinoWin4", "MinoWin5", "MinoWin6", "MinoAtt-6"]
        
        var imagewin = [UIImage] ()
        for i in 0..<minowin.count{
            imagewin.append(UIImage(named: minowin[i])!)
        }
        
        mino.animationImages = imagesatt
        mino.animationDuration = 0.5
        mino.animationRepeatCount = 1
        mino.startAnimating()
        mino.image = imagesatt[8]
        
        let skeletonhit = ["SkeletonHit1","SkeletonHit2", "SkeletonHit3"]
        var skeletonimg = [UIImage] ()
        for i in 0..<skeletonhit.count{
            skeletonimg.append(UIImage(named: skeletonhit[i])!)
        }
        
        let skeldeath = ["SkeletonDeath","SkeletonDeath2", "SkeletonDeath3", "SkeletonDeath4"]
        var imgdeath = [UIImage] ()
        for i in 0..<skeldeath.count{
            imgdeath.append(UIImage(named: skeldeath[i])!)
        }
        
       skeleton.animationImages = skeletonimg
        skeleton.animationDuration = 0.3
        skeleton.animationRepeatCount = 1
       skeleton.startAnimating()
        skeleton.image = skeletonimg[2]
        
        
        if hpbar.progress == 0.0{
            hptext.isHidden = true
            youwintext.isHidden = false
            youwintext.text = "YOU WIN"
            continuebtn.isHidden = false
            sender.isEnabled = false
            texttap.stopAnimating()
        
            skeleton.image = imgdeath[3]
            
            mino.image = UIImage(named: "MinoWin1")
            
            
            
        }
    }
}

