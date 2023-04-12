//
//  CameraViewController.swift
//  Student Voice
//
//  Created by 8h on 3/30/23.
//

import UIKit

class CameraViewController1: UIViewController{
    
 
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.backgroundColor = .secondarySystemFill
        
        button1.backgroundColor = .systemBlue
        button1.setTitle("Take Picture", for: .normal)
        button1.setTitleColor(.white, for: .normal)
        // Do any additional setup after loading the view.
    }

    @IBAction func didTap(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
}
    
    extension CameraViewController1: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: nil)
            
            guard let image =  info[UIImagePickerController.InfoKey.originalImage] as?
                    UIImage else{
                return
            }
            imageView.image = image
        }
    }


