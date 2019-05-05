//
//  TableViewController.swift
//  assignment
//
//  Created by Anıl on 13.12.2018.
//  Copyright © 2018 Anıl. All rights reserved.
//

import UIKit

struct Response : Decodable
{
    let items : [Item]
}

struct Item : Decodable
{
    let title : String?
    let url : String?
}

class TableViewController: UITableViewController {
    
    var items = [Item]()
    let http = "https://storage.googleapis.com/anvato-sample-dataset-nl-au-s1/life-1/"
    
    func fetchData(){
        
        let myUrl = URL(string: "https://storage.googleapis.com/anvato-sample-dataset-nl-au-s1/life-1/data.json")
        let request = URLRequest(url: myUrl!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            var allUrl = ""
            do{
                let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                
                for(key,value) in json {
                    if(key == "items"){
                        if let itemsArray: [[String:Any]] = value as? [[String:Any]]{
                            for dictionary in itemsArray{
                                allUrl = self.http + (dictionary["url"] as! String)
                                let newItem = Item(title:  dictionary["title"] as? String, url: allUrl)
                                self.items.append(newItem)
                            }
                        }
                    }
                }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch let jsonErr{
                
                print("error json",jsonErr)
            }
        }
        task.resume()
    }
    
    func setProfileToNavBar(){
        let button = UIButton(type: .system)
        var navigateimage = UIImage(named: "profile.png")
        navigateimage = navigateimage?.withRenderingMode(.alwaysOriginal)
        button.setImage(navigateimage, for: .normal)
        button.setTitle(" Anıl Ülger", for: .normal)
        button.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    override func viewDidLoad() {
        
       setProfileToNavBar()
       fetchData()
       super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        // Configure the cell...
        cell.item = items[indexPath.item]
        return cell
    }
}
