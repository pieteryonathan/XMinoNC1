//
//  Level3ViewController.swift
//  XMinoNC1
//
//  Created by Pieter Yonathan on 04/05/21.
//

import UIKit
import Speech

class Level3ViewController: UIViewController, SFSpeechRecognizerDelegate {

    @IBOutlet weak var continuebtn: UIButton!
    @IBOutlet weak var hptext: UILabel!
    @IBOutlet weak var screamanimation: UIImageView!
    @IBOutlet weak var micicon: UIImageView!
    @IBOutlet weak var youwintext: UILabel!
    @IBOutlet weak var fymonster: UIImageView!
    @IBOutlet weak var mino: UIImageView!
    @IBOutlet weak var btn_start: UIButton!
    @IBOutlet weak var hpbar: UIProgressView!
    var hp = 1.0
    let audioEngine = AVAudioEngine()
    let speechRecognizer : SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var task : SFSpeechRecognitionTask!
    var isStart: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continuebtn.isHidden = true
        continuebtn.layer.cornerRadius = 10
        youwintext.isHidden = true
        btn_start.layer.cornerRadius = 10
        btn_start.backgroundColor = .systemOrange
        requestPermission()
        hp = 1.0
        hpbar.progress = Float(hp)
        
        let nameminoidle = ["MinoIdle1","MinoIdle2", "MinoIdle3", "MinoIdle4", "MinoIdle5"]
        var images = [UIImage] ()
        for i in 0..<nameminoidle.count{
            images.append(UIImage(named: nameminoidle[i])!)
        }
        
       mino.animationImages = images
       mino.animationDuration = 1.0
       mino.startAnimating()
        
        let flyidle = ["fly1","fly2", "fly3", "fly4", "fly5", "fly6", "fly7","fly8"]
        var imagesfly = [UIImage] ()
        for i in 0..<flyidle.count{
            imagesfly.append(UIImage(named: flyidle[i])!)
        }
        
       fymonster.animationImages = imagesfly
       fymonster.animationDuration = 1.0
       fymonster.startAnimating()
        
        let screamatext = ["Scream1","Scream2", "Scream3", "Scream4", "Scream5", "Scream6"]
        var screamimg = [UIImage] ()
        for i in 0..<screamatext.count{
            screamimg.append(UIImage(named: screamatext[i])!)
        }
        
       screamanimation.animationImages = screamimg
       screamanimation.animationDuration = 1.0
       screamanimation.startAnimating()
    }
    
    @IBAction func btn_start_stop(_ sender: Any) {
        isStart = !isStart
                if isStart {
                    startSpeechRecognization()
                    micicon.isHidden = true
                    btn_start.setTitle("SCREAM", for: .normal)
                    btn_start.backgroundColor = .systemGreen
                }
        
    }
    
    func cancelSpeechRecognization() {
            btn_start.isHidden = true
            task.finish()
            task.cancel()
            task = nil
            
            request.endAudio()
            audioEngine.stop()
            //audioEngine.inputNode.removeTap(onBus: 0)
            
            //MARK: UPDATED
            if audioEngine.inputNode.numberOfInputs > 0 {
                audioEngine.inputNode.removeTap(onBus: 0)
            }
        }
    
    func requestPermission(){
        btn_start.isEnabled = false
        SFSpeechRecognizer.requestAuthorization{ (authState) in OperationQueue.main.addOperation {
            if authState == .authorized{
                print("Acc")
                self.btn_start.isEnabled = true
            }
            else if authState == .denied{
                self.alertview(message: "User denied the permssion")
            }
            else if authState == .notDetermined{
                self.alertview(message: "User phone there is no speech recognition")
            }
            else if authState == .restricted{
                self.alertview(message: "User has been restricted for using speech recognition")
            }
        }
            
        }
}
    func alertview(message: String){
        let controller = UIAlertController.init(title: "Error", message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in controller.dismiss(animated: true, completion: nil)}))
        self.present(controller, animated: true, completion: nil)
    }
    
    func startSpeechRecognization(){
        let minoatt = ["MinoTusuk1","MinoTusuk2", "MinoTusuk3", "MinoTusuk4", "MinoTusuk5"]
        
        var imagesatt = [UIImage] ()
        for i in 0..<minoatt.count{
            imagesatt.append(UIImage(named: minoatt[i])!)
        }
        
        let flyhit = ["flyhit1","flyhit2", "flyhit3"]
        
        var imageshit = [UIImage] ()
        for i in 0..<flyhit.count{
            imageshit.append(UIImage(named: flyhit[i])!)
        }
        
            hp = 1.0
            hpbar.progress = Float(hp)
            let node = audioEngine.inputNode
            let recordingFormat = node.outputFormat(forBus: 0)
            
            node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
                self.request.append(buffer)
            }
            
            audioEngine.prepare()
            do {
                try audioEngine.start()
            } catch let error {
                alertview(message: "Error comes here for starting the audio listner =\(error.localizedDescription)")
            }
            
            guard let myRecognization = SFSpeechRecognizer() else {
                self.alertview(message: "Recognization is not allow on your local")
                return
            }
            
            if !myRecognization.isAvailable {
                self.alertview(message: "Recognization is free right now, Please try again after some time.")
            }
            
            task = speechRecognizer?.recognitionTask(with: request, resultHandler: { (response, error) in
                guard let response = response else {
                    if error != nil {
                        self.alertview(message: error.debugDescription)
                    }else {
                        self.alertview(message: "Problem in giving the response")
                    }
                    return
                }
                
                let message = response.bestTranscription.formattedString
                
                var lastString: String = ""
                      for segment in response.bestTranscription.segments {
                          let indexTo = message.index(message.startIndex, offsetBy: segment.substringRange.location)
                          lastString = String(message[indexTo...])
                      }
                      
                      if lastString == "hah" {
                          self.hp -= 0.15
                        self.mino.animationImages = imagesatt
                        self.mino.animationDuration = 0.5
                        self.mino.animationRepeatCount = 1
                        self.mino.startAnimating()
                        self.mino.image = imagesatt[0]
                        self.hpbar.progress = Float(self.hp)
                        
                        self.fymonster.animationImages = imageshit
                        self.fymonster.animationDuration = 1.0
                        self.fymonster.animationRepeatCount = 1
                        self.fymonster.startAnimating()
                        self.fymonster.image = imageshit[0]
                        
                      } else if lastString.elementsEqual("Hah") {
                          self.hp -= 0.15
                        self.mino.animationImages = imagesatt
                        self.mino.animationDuration = 0.5
                        self.mino.animationRepeatCount = 1
                        self.mino.startAnimating()
                        self.mino.image = imagesatt[0]
                        
                        self.fymonster.animationImages = imageshit
                        self.fymonster.animationDuration = 1.0
                        self.fymonster.animationRepeatCount = 1
                        self.fymonster.startAnimating()
                        self.fymonster.image = imageshit[0]
                        
                        self.hpbar.progress = Float(self.hp)
                        
                      } else if lastString.elementsEqual("Ha") {
                        self.hp -= 0.15
                        self.mino.animationImages = imagesatt
                        self.mino.animationDuration = 0.5
                        self.mino.animationRepeatCount = 1
                        self.mino.startAnimating()
                        self.mino.image = imagesatt[0]
                        
                        self.fymonster.animationImages = imageshit
                        self.fymonster.animationDuration = 1.0
                        self.fymonster.animationRepeatCount = 1
                        self.fymonster.startAnimating()
                        self.fymonster.image = imageshit[0]
                        
                      self.hpbar.progress = Float(self.hp)
                        
                    } else if lastString.elementsEqual("ha") {
                        self.hp -= 0.15
                        self.mino.animationImages = imagesatt
                        self.mino.animationDuration = 0.5
                        self.mino.animationRepeatCount = 1
                        self.mino.startAnimating()
                        self.mino.image = imagesatt[0]
                        
                        self.fymonster.animationImages = imageshit
                        self.fymonster.animationDuration = 1.0
                        self.fymonster.animationRepeatCount = 1
                        self.fymonster.startAnimating()
                        self.fymonster.image = imageshit[0]
                        
                      self.hpbar.progress = Float(self.hp)
                    }
                if self.hpbar.progress == 0.0{
                    self.continuebtn.isHidden = false
                    self.hptext.isHidden = true
                    self.youwintext.isHidden = false
                    self.screamanimation.isHidden = true
                    self.cancelSpeechRecognization()
                    self.mino.image = UIImage(named: "MinoWin1")
                    self.fymonster.image = UIImage(named: "flydeath")
                    
                }
            })
    }
}
