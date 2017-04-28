//
//  ViewController.swift
//  TestAlamofire
//
//  Created by CN320 on 4/19/17.
//  Copyright © 2017 CN320. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    var newsDataArray : NSMutableArray?
    var didUpdateConstraints : Bool!
    
    lazy var newsTableView : UITableView = {
        var newsTableView : UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.backgroundColor = .clear
        newsTableView.bounces = false
        newsTableView.estimatedRowHeight = 44//UITableViewAutomaticDimension
        newsTableView.rowHeight = UITableViewAutomaticDimension
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        return newsTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        
        self.view.addSubview(self.newsTableView)
        
        self.didUpdateConstraints = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.fetchAndPopulateData()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        if !self.didUpdateConstraints
        {
            self.view.addConstraint(NSLayoutConstraint(item:newsTableView,
                                                       attribute:NSLayoutAttribute.top,
                                                       relatedBy:NSLayoutRelation.equal,
                                                       toItem:self.view,
                                                       attribute:NSLayoutAttribute.top,
                                                       multiplier:1,
                                                       constant:10))
            
            self.view.addConstraint(NSLayoutConstraint(item:newsTableView,
                                                       attribute:NSLayoutAttribute.bottom,
                                                       relatedBy:NSLayoutRelation.equal,
                                                       toItem:self.view,
                                                       attribute:NSLayoutAttribute.bottom,
                                                       multiplier:1,
                                                       constant:-10))
            
            self.view.addConstraint(NSLayoutConstraint(item:newsTableView,
                                                       attribute:NSLayoutAttribute.leading,
                                                       relatedBy:NSLayoutRelation.equal,
                                                       toItem:self.view,
                                                       attribute:NSLayoutAttribute.leading,
                                                       multiplier:1,
                                                       constant:20))
            
            self.view.addConstraint(NSLayoutConstraint(item:newsTableView,
                                                       attribute:NSLayoutAttribute.trailing,
                                                       relatedBy:NSLayoutRelation.equal,
                                                       toItem:self.view,
                                                       attribute:NSLayoutAttribute.trailing,
                                                       multiplier:1,
                                                       constant:-20))
            
            self.didUpdateConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let viewRect = self.view.frame
        let tableRect = viewRect.insetBy(dx:10,dy:100)
        
        if !self.newsTableView.frame.equalTo(tableRect)
        {
            self.newsTableView.frame = tableRect
        }
        
    }*/
    
    
    func fetchAndPopulateData() -> Void
    {
        var dataArray : Array<NewsData>? = nil
        
        ConnectionManager.fetchNews { (result : Any?, error :Error?) in
            
            defer
            {
                DispatchQueue.main.async {
                    
                    self.reloadData(dataTableArray : dataArray)
                }
            }
            
            guard result != nil else { return }
            
            guard error == nil else { return }
            
            dataArray = NewsData.prepareNewsDataArray(rawDataArrray: result as? Array<Any>) as? Array<NewsData>
        }
    }
    
    func reloadData(dataTableArray : Array<NewsData>?)-> Void{
        
        guard dataTableArray != nil else {
            return
        }
        
        guard dataTableArray?.count != 0 else{
            return
        }
        
        if newsDataArray == nil || newsDataArray?.count == 0
        {
            newsDataArray = NSMutableArray.init(array: dataTableArray!)
        }
        
        self.newsTableView.reloadData()
    }

    
    //MARK:- TABLEVIEW_DATASOURCE_METHODS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return newsDataArray?.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let tableCellString = "NewsTableViewCell"
        
        var tableViewCell : NewsTableViewCell? = tableView.dequeueReusableCell(withIdentifier: tableCellString) as? NewsTableViewCell
        
        if tableViewCell == nil
        {
            tableViewCell = NewsTableViewCell.init(style:.default, reuseIdentifier:tableCellString)
        }
        tableViewCell?.newsData = newsDataArray?.object(at: indexPath.row) as? NewsData
        
        tableViewCell?.updateUI()
        
        return tableViewCell!
    }
}

