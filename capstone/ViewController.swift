//
//  ViewController.swift
//  capstone
//
//  Created by Vanessa Tang on 11/10/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    

    @IBOutlet weak var topRatedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topRatedTableView.dataSource=self
        
    }


}

