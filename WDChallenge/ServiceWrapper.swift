//
//  ServiceWrapper.swift
//  WDChallenge
//
//  Created by Ravi Shankar on 23/09/15.
//  Copyright © 2015 Ravi Shankar. All rights reserved.
//

import Foundation

protocol ServiceWrapperDelegate {
    func finishedDownloadingCompanies(companies: [Company])
    func errorDownloadingCompanies(error: NSError?)
}

class ServiceWrapper {
    
    var delegate:ServiceWrapperDelegate?
    
     func getCompanies() {
        let serviceURL = "https://api.myjson.com/bins/2ggcs"
        let url = NSURL(string: serviceURL)
        let request = NSURLRequest(URL: url!)
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                self.processResults(data)
            } else {
                print("Error in getCompanies() while calling the service " + error!.localizedDescription)
                self.delegate?.errorDownloadingCompanies(error)
            }
        }.resume()
    }
    
    func processResults(data: NSData?) {
        do {
            let results = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
            
            var companies = [Company]()
            
            for item in results {
                
                let id = item["companyID"] as! Int
                let name = item["comapnyName"] as! String
                let owner = item["companyOwner"] as! String
                let startDate = item["companyStartDate"] as! String
                let description = item["companyDescription"] as! String
                let department = item["companyDepartments"] as! String
                
                let company = Company(id: id,name: name, owner: owner, startDate: startDate, description: description , department: department)
                companies.append(company)
                
            }
            self.delegate?.finishedDownloadingCompanies(companies)
        } catch let error as NSError {
            print("Error in getCompanies() when parsing data ", error.localizedDescription)
            self.delegate?.errorDownloadingCompanies(error)
        }
    }
}