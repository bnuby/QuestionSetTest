//
//  AccountViewController.swift
//  test
//
//  Created by Gibson Kong on 04/05/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import UIKit
import CoreData

class AccountViewController: UIViewController {

    @IBOutlet var Namelbl: UILabel!
    @IBOutlet var Jobslbl: UILabel!
    @IBInspectable var jsonFileName : String!
    @IBOutlet weak var profileImgView: UIImageView!
    var get_id = ""
    var get_job = ""

    @IBAction func clearHistory(_ sender: Any) {
        let accept = UIAlertAction(title: "Yes", style: .default, handler: {(alert: UIAlertAction!) in
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
            let batchDelete = NSBatchDeleteRequest(fetchRequest: fetch)
            do {
                try context.execute(batchDelete)
            } catch let error as NSError{
                print("Error : \(error)")
            }
        })
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: {(alert: UIAlertAction!) in
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
            let batchDelete = NSBatchDeleteRequest(fetchRequest: fetch)
            do {
                try context.execute(batchDelete)
            } catch let error as NSError{
                print("Error : \(error)")
            }
        })
        let actionController = UIAlertController(title: "Clear Record", message: "Are you sure u wan't fully remove Exam Record?", preferredStyle: .alert)
        actionController.addAction(accept)
        actionController.addAction(cancel)
        present(actionController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func logOut(){
        self.performSegue(withIdentifier: "unwindToLoginPage", sender: self)
        loginViewController().User.removeObject(forKey: "user")
        loginViewController().User.removeObject(forKey: "job")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        readJson(jsonFileName)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        get_id = loginViewController().User.string(forKey: "user")!
        get_job = loginViewController().User.string(forKey: "job")!
        let data = loginViewController().User.object(forKey: "profilePic") as! Data
        let get_img = NSKeyedUnarchiver.unarchiveObject(with: data) as? UIImage
        profileImgView.image = get_img
        Namelbl.text = get_id
        Jobslbl.text = get_job
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func unWindToProfile (for unwindSegue: UIStoryboardSegue) { }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
