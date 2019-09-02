//
//  ViewController.swift
//  face Ditection
//
//  Created by shalika lahiru on 8/16/19.
//  Copyright © 2019 shalika lahiru. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {
    
    @IBOutlet weak var testImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        testImageView.image = UIImage(named: "sample2")
        
        // Do any additional setup after loading the view.
        let request =  VNDetectFaceRectanglesRequest { (req, err) in
            if let err = err{
                print("face ditection fauil",err)
                return
            }
            print(req)
            
            req.results?.forEach({ (res) in
                print(res)
                guard let faceobservation = res as? VNFaceObservation else {return}
                
                let x = self.view.frame.width * faceobservation.boundingBox.origin.x
                print(faceobservation.boundingBox.origin.x,"xxxx")
                print(faceobservation.boundingBox.origin.y,"yyyy")
                print(testImageView.frame.origin.x)
                
//                let width = self.view.frame.width * faceobservation.boundingBox.width
//                let height =
                let height = self.view.frame.height * faceobservation.boundingBox.height
                let y = self.testImageView.frame.height * faceobservation.boundingBox.origin.y
                
                let redView = UIView()
                redView.backgroundColor = .red
                redView.frame = CGRect(x: x, y: y, width: 100, height: 100)
                self.view.addSubview(redView)
                print(faceobservation.boundingBox)
            })
        }
        guard let cgImage = testImageView.image?.cgImage else{return}
        let handler  = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do{
            try handler.perform([request])
        }catch let reqErr{
            print(reqErr)
        }
        
    }
    
    
}

