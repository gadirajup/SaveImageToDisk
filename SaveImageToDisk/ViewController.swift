//
//  ViewController.swift
//  SaveImageToDisk
//
//  Created by Prudhvi Gadiraju on 4/25/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var selectedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addImage(_ sender: Any) {
     
        let ip = UIImagePickerController()
        ip.sourceType = .camera
        ip.delegate = self
        ip.allowsEditing = true
        present(ip, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        selectedImage.image = image
        
        save(image: image)
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func save(image: UIImage) {
        guard var documentsDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let filename = UUID().uuidString
        documentsDirectoryPath.appendPathComponent(filename)
        
        let imageData = image.jpegData(compressionQuality: 0.25)
        
        do {
            try imageData?.write(to: documentsDirectoryPath)
        } catch {
            print("Failed to save image to Disk: ", error.localizedDescription)
        }
        

    }
}

