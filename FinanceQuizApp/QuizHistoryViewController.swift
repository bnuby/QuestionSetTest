//
//  QuizHistoryViewController.swift
//  FinanceQuizApp
//
//  Created by Gibson Kong on 05/05/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import UIKit

class QuizHistoryViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource {
    @IBOutlet var navigation: UINavigationBar!

    @IBAction func BackButton(){
        self.performSegue(withIdentifier: "unWindToProfile", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigation.frame.origin.y = 20
        navigation.frame.size.width = view.frame.width
        view.addSubview(navigation)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.tabBarController?.tabBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "No Record"
        
        return cell
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
