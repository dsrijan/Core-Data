//
//  ViewController.swift
//  CoreDataSample
//
//  Created by Srijan on 13/04/18.
//  Copyright © 2018 Srijan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var studentData = [Student]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        CoreDataObject().deleteAllObject()
        fetchFromCoreData()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func fetchFromCoreData() {
        self.studentData = CoreDataObject().fetchFromCoreData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        let currentData = self.studentData[indexPath.row]
        cell.textLabel?.text = currentData.name!
        cell.imageView?.image = UIImage(data: currentData.photo!)
        cell.detailTextLabel?.text = "\(currentData.roll)"
        return cell
    }
}

