//
//  ViewController.swift
//  CDCamera
//
//  Created by Victor Lehr on 7/25/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.delegate = self
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // "info" contains a dictionary of information about the selected media, including metadata and a user-edited image, IF the .allowsEditing property is set to true
        
        let chosenImage = info[.originalImage] as! UIImage
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = chosenImage
        
        dismiss(animated: true)
        
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    @IBAction func libraryButtonSelected(_ sender: Any) {
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        present(picker, animated:true)
    }
    
    @IBAction func cameraButtonSelected(_ sender: Any) {
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) {
                    accessGranted in
                    guard accessGranted == true else {
                        return
                    }
                }
            case .authorized:
                break
            default:
                print("💀 You are done for. 💀")
                return
            }
            
            picker.sourceType = .camera
            picker.allowsEditing = false
            picker.cameraCaptureMode = .photo
            present(picker, animated:true)
        }
    }
}

