//
//  CountryInfoViewController.swift
//  LearnAboutCountries
//
//  Created by Iryna Pfeiffer on 2/22/19.
//  Copyright © 2019 Iryna Pfeiffer. All rights reserved.
//

import UIKit
import WebKit

class CountryInfoViewController: UITableViewController {
    
    var presenter: CountryInfoPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.register(UINib(nibName: "MapCell", bundle: nil), forCellReuseIdentifier: "mapCell")
        self.tableView.register(UINib(nibName: "CommonCell", bundle: nil), forCellReuseIdentifier: "commonCell")
        self.tableView.register(UINib(nibName: "FlagCell", bundle: nil), forCellReuseIdentifier: "flagCell")
        presenter.viewIsLoaded(self)
    }
    
    
    func reload() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    
    //MARK: - TableView DataSource Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapCell", for: indexPath) as! MapCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "flagCell", for: indexPath) as! FlagCell
            cell.showSVG(url: presenter.getFlagURL())
            
            return cell
        case 2...18:
            let cell = tableView.dequeueReusableCell(withIdentifier: "commonCell", for: indexPath) as! CommonCell
            let data = presenter.getCellData(at: indexPath.row)
            cell.propertyName.text = data.0
            cell.propertyValue.text = data.1
            return cell
        default: let cell = UITableViewCell()
        return cell
        }
  
    }
    
    //Mark: TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {presenter.showMap()}
    }
    
    func showMapViewController(vc: UIViewController ) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

}


