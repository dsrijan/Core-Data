//
//  AddStudentViewControler.swift
//  CoreDataSample
//
//  Created by DRISHTI-IT on 13/04/18.
//  Copyright © 2018 Srijan. All rights reserved.
//

import UIKit

class AddStudentViewControler: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var rollTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var uploadingImage: UIImage? = nil
    
    var picker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapImage))
        imageView.addGestureRecognizer(tapGesture)

        picker.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @objc
    private func tapImage() {
        
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageView.image = image
        self.uploadingImage = image
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveData(_ sender: UIBarButtonItem) {
        
        DispatchQueue.global(qos: .background).async {
            CoreDataObject().saveData(name: self.nameTextField.text!, roll: Int(self.rollTextField.text!)!, photo: self.uploadingImage!)
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class SingletonClass : NSObject {
    static let shared = SingletonClass()
    let volume = 50
}


