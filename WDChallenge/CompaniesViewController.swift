//
//  CompaniesViewController.swift
//  WDChallenge
//
//  Displays the list of companies from JSON service.
//  The companies are filtered based on selected 
//  departments and search text matched with company name.
//
//  Created by Ravi Shankar on 23/09/15.
//  Copyright © 2015 Ravi Shankar. All rights reserved.
//

import UIKit

class CompaniesViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    private let identifier = "companyIdentfier"
    private let serviceWrapper = ServiceWrapper()
    
    /*
       Three arrays are used for storing data, firt one for
       receiving from webservice (originalData), second one
       filtered companies based on search text (searchCompanies)
       and actual data that will be shown in the tableview (companies)
    */
    
    private var companies = [Company]()
    private var searchCompanies = [Company]()
    private var originalData = [Company]()
    
    private var departments: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serviceWrapper.delegate = self
        searchBar.delegate = self
        
        initialSetup()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        filterByDeparments()
        tableView.reloadData()
        searchBar.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK:- PrepareForSegue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            let controller = segue.destinationViewController as! DetailViewController
            
            let selectedRow = tableView.indexPathForSelectedRow?.row
            let company = companies[selectedRow!]
            
            controller.company = company
        }
        searchBar.text = ""
        if searchBar.isFirstResponder() {
                searchBar.resignFirstResponder()
        }
        
        emptyTitleForBackButton()
    }
    
    
    func emptyTitleForBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    // MARK:- UITableViewDataSource methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        
        let company = companies[indexPath.row]
        
        cell.textLabel?.text = company.name
        cell.detailTextLabel?.text =  "\(company.id) "
        
        cell.contentView.backgroundColor = backgroundColor
        cell.textLabel?.font =  UIFont(name: "HelveticaNeue-Medium", size: 15)
        cell.textLabel?.textColor = textColor
        cell.textLabel?.backgroundColor = backgroundColor
        cell.backgroundColor = backgroundColor
        
        cell.detailTextLabel?.font = UIFont.boldSystemFontOfSize(12)
        cell.detailTextLabel?.textColor = UIColor.grayColor()
        cell.detailTextLabel?.backgroundColor = backgroundColor
        
        return cell
    }
    
    // MARK:- Filter Departments

    func filterByDeparments() {
        departments = Common.loadFilteredDeparments()
        var filteredCompanies = [Company]()
        if let departments = departments{
            for company in originalData {
                for item in departments {
                    if company.department.lowercaseString.containsString(item.lowercaseString) {
                        filteredCompanies.append(company)
                        break
                    }
                }
            }
            companies = filteredCompanies
        }
    }
    
    // MARK:- Initialize
    
    func initialSetup() {
        refresh()
        loadRefreshControl()
    }
    
    // MARK:- Refresh Control
    
    func loadRefreshControl() {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
    }
    
    // MARK:- Load Data
    
    func refresh() {
        searchBar.text = ""
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        serviceWrapper.getCompanies()
    }
    
    // MARK:- hideKeyboard
    
    func hideKeyboard() {
        searchBar.endEditing(true)
    }
    
}

extension CompaniesViewController: UISearchBarDelegate {
    
     // MARK:- SearchBar Delegate Methods
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
            filterCompaniesBasedOnName(searchBar.text!)
        } else if searchText.characters.count == 0 {
            companies = originalData
            filterByDeparments()
            tableView.reloadData()
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        filterCompaniesBasedOnName(searchBar.text!)
        searchBar.resignFirstResponder()
    }
    
    func searchBarResultsListButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // MARK:- Filter Companies
    
    func filterCompaniesBasedOnName(searchText: String) {
        companies = originalData.filter() {
            let company = ($0 as Company)
            if company.name.lowercaseString.containsString(searchText.lowercaseString) {
                return true
            } else {
                return false
            }
        }
        
        tableView.reloadData()
    }
}

extension CompaniesViewController: ServiceWrapperDelegate {

    // MARK:- ServiceWrapper Delegate Methods
    
    func finishedDownloadingCompanies(companies: [Company]) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.originalData = companies
            self.companies = companies
            self.filterByDeparments()
            self.tableView.reloadData()
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            self.refreshControl?.endRefreshing()
        }
    }
    
    func errorDownloadingCompanies(error: NSError?) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            }
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
}