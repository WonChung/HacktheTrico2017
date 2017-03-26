//
//  tabTwoTableViewController.swift
//  HacktheTrico
//
//  Created by Cassandra Stone on 3/25/17.
//  Copyright © 2017 Cassandra Stone. All rights reserved.
//

import UIKit

class tabTwoTableViewController: UITableViewController, UISearchResultsUpdating {

    var plannedParenthoodData: [PlannedParenthood]!
    
    var filteredPlannedParenthood = [PlannedParenthood]()
    
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // backButton.(self, action: #selector(goBack), for: .touchUpInside)
        guard let jsonURL = Bundle.main.url(forResource: "plannedparenthoodData", withExtension: "json") else {
            print("Could not find json!")
            return
        }
        
        let jsonData = NSData(contentsOf: jsonURL) as Data?
        //if let jsonData = jsonData {
        //    let json = try! JSONSerialization.jsonObject(with: jsonData) as! Array<Hospitals>
        //}
        var provider_name = [String]()
        var provider_street_address = [String]()
        var provider_zip_code = [String]()
        var telephone = [String]()
        
        do {
            if let jsonData = jsonData,
                let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
                let providers = json["providers"] as? [[String: Any]] {
                for provider in providers {
                    if let name = provider["provider_name"] as? String {
                        provider_name.append(name)
                    }
                    if let address = provider["provider_street_address"] as? String {
                        provider_street_address.append(address)
                    }
                    if let code = provider["provider_zip_code"] as? String {
                        provider_zip_code.append(code)
                    }
                    if let charge = provider["telephone"] as? String {
                        telephone.append(charge)
                    }
                }
            }
        } catch {
            print("Error deserializing JSON: \(error)")
        }
        
        plannedParenthoodData = []
        var i = 0
        for p in provider_name {
            let currentPlan = PlannedParenthood()
            currentPlan.provider_name = provider_name[i]
            currentPlan.provider_street_address = provider_street_address[i]
            currentPlan.provider_zip_code = provider_zip_code[i]
            currentPlan.telephone = telephone[i]
            i = i + 1
        }
        
        print(plannedParenthoodData!.count)
        tableView.reloadData()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        navigationController?.navigationBar.tintColor = UIColor.white;
        
        searchController.searchBar.barTintColor = UIColor.white
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.placeholder = "Enter Zip Code Here..."
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let searchBar:UISearchBar = searchController.searchBar
        var searchBarFrame:CGRect = searchBar.frame
        if searchController.isActive {
            searchBarFrame.origin.y = 10
        }
        else {
            searchBarFrame.origin.y = max(0, scrollView.contentOffset.y + scrollView.contentInset.top)
            
        }
        searchController.searchBar.frame = searchBarFrame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredPlannedParenthood.count
            print(filteredPlannedParenthood.count)
        }
        return plannedParenthoodData.count
        print(plannedParenthoodData.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1
        let cell = tableView.dequeueReusableCell(withIdentifier: "tabTwoTableViewCell", for: indexPath) as! tabTwoTableViewCell
        
        let plannedParenthood: PlannedParenthood
        if searchController.isActive && searchController.searchBar.text != "" {
            plannedParenthood = filteredPlannedParenthood[indexPath.row]
        } else {
            plannedParenthood = plannedParenthoodData[indexPath.row]
        }
        
        // 2
        cell.planNameLabel.text = plannedParenthood.provider_name
        
        cell.separatorInset = UIEdgeInsets.zero;
        
        return cell
    }

    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredPlannedParenthood = plannedParenthoodData.filter { hospital in
            return (hospital.provider_zip_code.range(of: searchText) != nil)
        }
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        func updateSearchResultsForSearchController(searchController: UISearchController) {
            filterContentForSearchText(searchText: searchController.searchBar.text as String!)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
