//
//  ViewController.swift
//  Exercise4
//
//  Created by Victor Lehr on 7/26/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var boxLabel: UILabel!
    @IBOutlet weak var viewBox: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recognizePanGesture(recognizer: UIPanGestureRecognizer)
        {
            boxLabel.text = "Drag"
            let translate = recognizer.translation(in: self.view)
            recognizer.view!.center = CGPoint(x:recognizer.view!.center.x + translate.x,
                                          y:recognizer.view!.center.y + translate.y)
            recognizer.setTranslation(.zero, in: self.view)
    }
    
    @IBAction func recognizeTapGesture(recognizer: UITapGestureRecognizer)
        {
            boxLabel.text = "Tap"
            let colorRed: CGFloat = CGFloat(arc4random()) / CGFloat(RAND_MAX)
            let colorGreen: CGFloat = CGFloat(arc4random()) / CGFloat(RAND_MAX)
            let colorBlue: CGFloat = CGFloat(arc4random()) / CGFloat(RAND_MAX)
            viewBox.backgroundColor = UIColor(red: colorRed, green: colorGreen, blue: colorBlue, alpha: 1)
    }
    
    @IBAction func recognizeLongPressedGesture (recognizer: UILongPressGestureRecognizer)
        {
            boxLabel.text = "Long Press"
            viewBox.backgroundColor = UIColor.black
    }
    
    @IBAction func recognizeRotateGesture(recognizer: UIRotationGestureRecognizer)
        {
            boxLabel.text = "Rotate"
            recognizer.view!.transform = recognizer.view!.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
    }
    
    @IBAction func recognizePinchGesture(recognizer: UIPinchGestureRecognizer)
        {
            boxLabel.text = "Resize"
            recognizer.view!.transform = recognizer.view!.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
    }


}

