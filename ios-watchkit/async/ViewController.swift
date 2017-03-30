//
//  ViewController.swift
//  async
//
//  Created by Jan Stárek on 25/03/2017.
//  Copyright © 2017 Jan Stárek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var tableItems : [String] = []
    let client = WebServiceApi()
    @IBAction func getButtonClicked(_ sender: Any)
    {
        startLoading()
        client.getSupportedLanguages()
        {
            response in
            self.stopLoading()
            if response != nil
            {
                self.showNewData(languages: response!)
            }
            else
            {
                self.showError()
            }
        }
    }
    @IBAction func postButtonClicked(_ sender: Any)
    {
        startLoading()
        client.postSupportedLanguages()
            {
                response in
                self.stopLoading()
                if response != nil
                {
                    self.showNewData(languages: response!)
                }
                else
                {
                    self.showError()
                }
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicatorLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var getButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.stopLoading()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func startLoading()
    {
        DispatchQueue.main.async
        {
            self.getButton.isEnabled = false
            self.postButton.isEnabled = false
            self.activityIndicatorLabel.isHidden = false
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    private func stopLoading()
    {
        DispatchQueue.main.async
        {
            self.getButton.isEnabled = true
            self.postButton.isEnabled = true
            self.activityIndicatorLabel.isHidden = true
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func showNewData(languages: [String])
    {
        DispatchQueue.main.async
        {
            self.tableItems = languages
            self.tableView.reloadData()
            self.statusLabel.text = ""
        }
    }
    
    private func showError()
    {
        DispatchQueue.main.async
        {
            self.statusLabel.text = "Connection failure"
            self.tableItems = [String]()
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.tableItems.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = self.tableItems[indexPath.row]
        return cell
    }
}
