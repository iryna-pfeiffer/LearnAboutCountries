//
//  SearchViewController.swift
//  LearnAboutCountries
//
//  Created by Iryna Pfeiffer on 2/22/19.
//  Copyright © 2019 Iryna Pfeiffer. All rights reserved.
//

import UIKit


class SearchViewController: UITableViewController, UISearchBarDelegate {
    
   
   var presenter: SearchPresenter = SearchPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsLoaded(self)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    //MARK: - Update UI
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryNameCell", for: indexPath)
        cell.textLabel?.text = presenter.getCellText(for: indexPath.row)
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.showDetailedInfo(at: indexPath.row)
         self.title = ""
    }
    

    //MARK: SearchBar Delegate Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.updateSearchedCountries(with: searchText)
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        presenter.updateSearchFlag(with: false)
        searchBar.text = ""
        tableView.reloadData()
    }
    
    
    func showCountryInfoViewController(vc: UITableViewController ) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
        
}

