//
//  Level2ViewController.swift
//  XMinoNC1
//
//  Created by Pieter Yonathan on 03/05/21.
//

import UIKit
import AVFoundation
import CoreAudio

class Level2ViewController: UIViewController {
    

    @IBOutlet weak var continuebtn: UIButton!
    @IBOutlet weak var buttonexit: UIButton!
    @IBOutlet weak var hptext: UILabel!
    @IBOutlet weak var shakeimage: UIImageView!
    @IBOutlet weak var youwin: UILabel!
    @IBOutlet weak var shakeAnimation: UIImageView!
    @IBOutlet weak var goblin: UIImageView!
    @IBOutlet weak var hpBar: UIProgressView!
    @IBOutlet weak var mino: UIImageView!
    var hp = 1.0
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        continuebtn.isHidden = true
        continuebtn.layer.cornerRadius = 10
        shakeimage.transform = shakeimage.transform.rotated(by: CGFloat(Double.pi / 4))

        youwin.isHidden = true
        hp = 1.0
        hpBar.progress = Float(hp)
        
        //Animation idle minotour
        let nameminoidle = ["MinoIdle1","MinoIdle2", "MinoIdle3", "MinoIdle4", "MinoIdle5"]
        var images = [UIImage] ()
        for i in 0..<nameminoidle.count{
            images.append(UIImage(named: nameminoidle[i])!)
        }
        
       mino.animationImages = images
       mino.animationDuration = 1.0
       mino.startAnimating()
        
        //Animation idle goblin
        let goblinidle = ["GoblinIdle1","GoblinIdle2", "GoblinIdle3", "GoblinIdle4", "GoblinIdle5", "GoblinIdle6"]
        var goblinimages = [UIImage] ()
        for i in 0..<goblinidle.count{
            goblinimages.append(UIImage(named: goblinidle[i])!)
        }
        
       goblin.animationImages = goblinimages
       goblin.animationDuration = 1.0
       goblin.startAnimating()
        
        // Animating Text Shake
        let shaketext = ["Shake1","Shake2", "Shake3", "Shake4", "Shake5", "gone", "Shake6", "Shake7", "Shake8"]
        var textimg = [UIImage] ()
        for i in 0..<shaketext.count{
            textimg.append(UIImage(named: shaketext[i])!)
        }
        
       shakeAnimation.animationImages = textimg
       shakeAnimation.animationDuration = 1.0
        shakeAnimation.startAnimating()
    }

    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake
        {
            shakeimage.isHidden = true
            hp -= 0.3
            hpBar.progress = Float(hp)
            
            let minoatt = ["AttSpin1","AttSpin2", "AttSpin3", "AttSpin4", "AttSpin5", "AttSpin6"]
            
            var imagesatt = [UIImage] ()
            for i in 0..<minoatt.count{
                imagesatt.append(UIImage(named: minoatt[i])!)
            }
            
            mino.animationImages = imagesatt
            mino.animationDuration = 0.5
            mino.animationRepeatCount = 1
            mino.startAnimating()
            mino.image = imagesatt[0]
            
            let goblinhit = ["GoblinTakeHit1","GoblinTakeHit2", "GoblinTakeHit3"]
            var goblinhitimages = [UIImage] ()
            for i in 0..<goblinhit.count{
                goblinhitimages.append(UIImage(named: goblinhit[i])!)
            }
            
           goblin.animationImages = goblinhitimages
            goblin.animationDuration = 1.3
            goblin.animationRepeatCount = 1
           goblin.startAnimating()
            goblin.image = goblinhitimages[0]
            
            if hpBar.progress == 0.0{
                continuebtn.isHidden = false
                hptext.isHidden = true
                youwin.isHidden = false
                shakeAnimation.stopAnimating()
                mino.image = UIImage(named: "MinoWin1")
                goblin.image = UIImage(named: "goblindeath")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
