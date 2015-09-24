//
//  DepartmentController.swift
//  WDChallenge
//
//  Provides option to choose departments. The selected departments
//  are stored in NSUserDefaults and the data will be used for filtering
//  companies.
//
//  Created by Ravi Shankar on 23/09/15.
//  Copyright © 2015 Ravi Shankar. All rights reserved.
//

import UIKit

class DepartmentController: UITableViewController {
    
    @IBOutlet weak var toggleAll: UIBarButtonItem!
    
    private final let cellIdentifier = "departmentIdentifier"
    private final let clearAll = "Clear All"
    private final let selectAll = "Select All"
    
    private var selectedDepartments:[String]?
    private var toggleFlag = true
    
    private let departments = ["Accounting","Advertising","Asset Management","Customer Relations","Customer Service","Finances","Human Resources","Legal Department",
        "Media Relations","Payroll","Public Relations","Quality Assurance","Sales and Marketing","Research and Development","Tech Support"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(selectedDepartments, forKey: "departmentsKey")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:- Initial Setup
    
    func initialSetup() {
        loadFilteredDeparments()
        if selectedDepartments?.count == 0 {
            toggleFlag = false
        }
        setToggleTitle()
    }
    
    // MARK:- UITableViewDataSource methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departments.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        cell.selectionStyle = .None
        cell.accessoryType = .None
        
        let departmentName = departments[indexPath.row]
        cell.textLabel?.text = departmentName
        
        let index = selectedDepartments?.indexOf(departmentName)
        
        if index >= 0 {
            cell.accessoryType = .Checkmark
        }
        
        cell.contentView.backgroundColor = backgroundColor
        cell.textLabel?.font =  UIFont(name: "HelveticaNeue-Medium", size: 15)
        cell.textLabel?.textColor = textColor
        cell.textLabel?.backgroundColor = backgroundColor
        cell.backgroundColor = backgroundColor
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let department = cell?.textLabel?.text
        let index = selectedDepartments!.indexOf(department!)
        
        if cell?.accessoryType == .Checkmark {
            cell?.accessoryType = .None
            selectedDepartments?.removeAtIndex(index!)
        } else {
            cell?.accessoryType = .Checkmark
            selectedDepartments?.append(department!)
        }
    }
    
    // MARK:- setToggleTitle
    
    func setToggleTitle() {
        
        toggleAll.title = selectAll
        
        if toggleFlag {
            toggleAll.title = clearAll
        }
    }
    
    // MARK:- filteredDepartments
    
    func loadFilteredDeparments() {
        if let tempDepartments = Common.loadFilteredDeparments() {
            selectedDepartments = tempDepartments
        } else {
            selectedDepartments = departments
        }
    }
    
    // MARK:- updateAccessoryType
    
    func updateAccessoryType(item: Int,accessoryType: UITableViewCellAccessoryType) {
        let indexpath = NSIndexPath(forRow: item.hashValue, inSection: 0)
        tableView.cellForRowAtIndexPath(indexpath)?.accessoryType = accessoryType
    }
    
    // MARK:- toggleAll IBAction
    
    @IBAction func toggleAll(sender: AnyObject) {
        
        for item in departments.indices {
            if toggleFlag {
                updateAccessoryType(item,accessoryType: .None)
                selectedDepartments = [String]()
            } else {
                updateAccessoryType(item,accessoryType: .Checkmark)
                selectedDepartments = departments
            }
        }
        toggleFlag = !toggleFlag
        setToggleTitle()
    }
}