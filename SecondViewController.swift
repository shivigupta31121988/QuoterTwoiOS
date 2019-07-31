//
//  SecondViewController.swift
//  Quoter2
//
//  Created by Shivi Gupta on 09/06/19.
//  Copyright © 2019 Shivi Gupta. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
  
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // let vc = segue.destination as! UITabBarController
       // vc.categorySelected = self.category
    }
    private let myArray: NSArray = ["All","Philosophy","Humour","Motivation","Shivi Gupta","Friends","13 Reasons Why","House M.D."]
    var category:String! = ""
    private var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")
        
        category = self.myArray[indexPath.row] as? String
        DispatchQueue.main.async(execute: {
            let alertController = UIAlertController(title: "Quoter Two", message: "You have selected : \(self.myArray[indexPath.row]) ", preferredStyle: UIAlertController.Style.alert)
            self.present(alertController, animated: true, completion: nil)
            let delay = DispatchTime.now() + 3 // change 1 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                // Your code with delay
                alertController.dismiss(animated: true, completion: nil)
            }
        });
       //self.performSegue(withIdentifier: "HomeScreenSegue", sender: self)
        let secondTab = self.tabBarController?.viewControllers![0] as! FirstViewController
        secondTab.categorySelected = category
        tabBarController?.selectedIndex = 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(myArray[indexPath.row])"
        return cell
    }
    
}

