//
//  Theme.swift
//  WDChallenge
//
//  Created by Ravi Shankar on 24/09/15.
//  Copyright © 2015 Ravi Shankar. All rights reserved.
//

import UIKit

func applyTheme() {
    let sharedApplication = UIApplication.sharedApplication()
    sharedApplication.delegate?.window??.tintColor = mainColor
    sharedApplication.statusBarStyle = UIStatusBarStyle.LightContent
    
    styleForTabBar()
    styleForNavigationBar()
    styleForTableView()
    styleForTableViewCell()
    styleLabel()
    styleSearchBar()
    
}

func styleForTabBar() {
    UITabBar.appearance().barTintColor = barTintColor
    UITabBar.appearance().tintColor = UIColor.whiteColor()
    
    UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor()], forState:.Selected)
    
    UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.blackColor()], forState:.Normal)
}

func styleForNavigationBar() {
    UINavigationBar.appearance().barTintColor = barTintColor
    UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: standardTextFont,  NSForegroundColorAttributeName: UIColor.whiteColor()]
}

func styleForTableView() {
    UITableView.appearance().backgroundColor = backgroundColor
    UITableView.appearance().separatorStyle = .SingleLineEtched
}

func styleForTableViewCell() {
    
    UITableViewCell.appearance().contentView.backgroundColor = backgroundColor
    
    UITableViewCell.appearance().textLabel?.backgroundColor = backgroundColor
    UITableViewCell.appearance().textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
    UITableViewCell.appearance().textLabel?.textColor = UIColor.blackColor()
    
    
    UITableViewCell.appearance().detailTextLabel?.backgroundColor = backgroundColor
    UITableViewCell.appearance().detailTextLabel?.font = UIFont.boldSystemFontOfSize(12)
    UITableViewCell.appearance().detailTextLabel?.textColor = textColor
}

func styleLabel() {
    UILabel.appearance().font = UIFont(name: "HelveticaNeue-Medium", size: 15)
    UILabel.appearance().textColor = UIColor.blackColor()
}

func styleSearchBar() {
    UISearchBar.appearance().barTintColor = backgroundColor
}

var mainColor: UIColor {
    return UIColor(red: 233.0/255.0, green: 81.0/255.0, blue: 106.0/255.0, alpha: 1.0)
}

var barStyle: UIBarStyle {
    return UIBarStyle.BlackOpaque
}

var barTintColor: UIColor {
    return UIColor(red: 233.0/255.0, green: 81.0/255.0, blue: 106.0/255.0, alpha: 1.0)
}

var barTintColorWithAlhpa: UIColor {
    return UIColor(red: 233.0/255.0, green: 81.0/255.0, blue: 106.0/255.0, alpha: 0.85)
}

var backgroundColor: UIColor {
    return UIColor(red: 251.0/255.0, green: 243.0/255.0, blue: 241.0/255.0, alpha: 1.0)
}

var secondaryColor: UIColor {
    return UIColor(red: 233.0/255.0, green: 81.0/255.0, blue: 106.0/255.0, alpha: 1.0)
}

var textColor: UIColor {
    return UIColor(red: 68.0/255.0, green: 67.0/255.0, blue: 63.0/255.0, alpha: 1.0)
}

var standardTextFont: UIFont {
    return UIFont(name: "HelveticaNeue-Light", size: 20)!
}

