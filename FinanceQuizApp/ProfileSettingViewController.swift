//
//  ProfileSettingViewController.swift
//  FinanceQuizApp
//
//  Created by D0515211 on 2017/6/24.
//  Copyright © 2017年 訪客使用者. All rights reserved.
//

import UIKit

class ProfileSettingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func BackButton(){
        self.performSegue(withIdentifier: "unWindToProfile", sender: self)
    }
    
    @IBOutlet weak var profileImgView: UIImageView!
    
    @IBOutlet weak var Namelbl: UITextField!
    @IBOutlet weak var Joblbl: UITextField!
    @IBOutlet var navigation: UINavigationBar!

  
    override func viewDidLoad() {
        super.viewDidLoad()
        navigation.frame.origin.y = 0
        navigation.frame.size.height = 60
        navigation.frame.size.width = view.frame.width
        view.addSubview(navigation)
        let fetch = loginViewController().User
        Namelbl.text = fetch.string(forKey: "user")!
        Joblbl.text = fetch.string(forKey: "job")!
        var data : () -> (UIImage) = {
            UIImage in
            let temp = fetch.object(forKey: "profilePic") as! Data
            return NSKeyedUnarchiver.unarchiveObject(with: temp) as! UIImage
        }
        profileImgView.image = data()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func UIImageTap(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = .photoLibrary
            imgPicker.allowsEditing = false
            self.present(imgPicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let selectedImg = info[UIImagePickerControllerOriginalImage] as? UIImage{
            profileImgView.image = selectedImg
            profileImgView.contentMode = .scaleAspectFit
            profileImgView.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ApplyAction(_ sender: Any) {
        let fetch = loginViewController().User
        let data = NSKeyedArchiver.archivedData(withRootObject: profileImgView.image!) 
        fetch.set(data, forKey: "profilePic")
        fetch.set(Namelbl.text, forKey: "user")
        fetch.set(Joblbl.text, forKey: "job")
        let action = UIAlertAction(title: "OK", style: .default, handler: { (_) -> Void in self.performSegue(withIdentifier: "unWindToProfile", sender: self)})
        let alert = UIAlertController(title: "", message: "Your Profile has been Updated", preferredStyle: .alert)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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
