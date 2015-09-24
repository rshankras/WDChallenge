//
//  DetailViewController.swift
//  WDChallenge
//  
//  Displays details about the selected company
//
//  Created by Ravi Shankar on 23/09/15.
//  Copyright © 2015 Ravi Shankar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!

    var company: Company?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let company = company {
            idLabel.text = "\(company.id)"
            dateLabel.text = company.startDate
            ownerLabel.text = company.owner
            departmentLabel.text = company.department
            descriptionTextView.text = company.description
            
            navigationItem.title = company.name
        }
        
        view.backgroundColor = backgroundColor

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
