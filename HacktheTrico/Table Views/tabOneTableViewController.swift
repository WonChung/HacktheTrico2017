//
//  tabOneTableViewController.swift
//  HacktheTrico
//
//  Created by Cassandra Stone on 3/25/17.
//  Copyright © 2017 Cassandra Stone. All rights reserved.
//

import UIKit
import SwiftyJSON
import Foundation

class tabOneTableViewController: UITableViewController, UISearchResultsUpdating {

    var hospitalData: [Hospitals]!
    
    var filteredHospitals = [Hospitals]()
    
    let searchController = UISearchController(searchResultsController: nil)

    
/*    @IBAction func goBack() {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "VC1"))! as UIViewController
        self.present(vc, animated: false, completion: nil)
    }
*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // backButton.(self, action: #selector(goBack), for: .touchUpInside)
        guard let jsonURL = Bundle.main.url(forResource: "hospitalData", withExtension: "json") else {
            print("Could not find json!")
            return
        }
        
        let jsonData = NSData(contentsOf: jsonURL) as Data?
        //if let jsonData = jsonData {
        //    let json = try! JSONSerialization.jsonObject(with: jsonData) as! Array<Hospitals>
        //}
        var provider_names = [String]()
        var provider_street_addresses = [String]()
        var provider_zip_codes = [String]()
        var average_covered_charges = [String]()
        var average_medicare_payments = [String]()

        
        do {
            if let jsonData = jsonData,
                let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
                let providers = json["providers"] as? [[String: Any]] {
                for provider in providers {
                    if let name = provider["provider_name"] as? String {
                        provider_names.append(name)
                    }
                    if let address = provider["provider_street_address"] as? String {
                        provider_street_addresses.append(address)
                    }
                    if let code = provider["provider_zip_code"] as? String {
                        provider_zip_codes.append(code)
                    }
                    if let charge = provider["average_covered_charge"] as? String {
                        average_covered_charges.append(charge)
                    }
                    if let payment = provider["average_medicare_payment"] as? String {
                        average_medicare_payments.append(payment)
                    }
                }
            }
        } catch {
            print("Error deserializing JSON: \(error)")
        }
        
        print(provider_names)
        print(provider_street_addresses)
        print(provider_zip_codes)
        print(average_covered_charges)
        print(average_medicare_payments)
        
        hospitalData = []
        var  i = 0
        for p in provider_names {
            let currentHospital = Hospitals()
            currentHospital.provider_name = provider_names[i]
            currentHospital.provider_street_address = provider_street_addresses[i]
            currentHospital.provider_zip_code = provider_zip_codes[i]
            currentHospital.average_covered_charge = average_covered_charges[i]
            currentHospital.average_medicare_payment = average_medicare_payments[i]
            hospitalData.append(currentHospital)
            i = i + 1
        }
        
        print(hospitalData!.count)
        tableView.reloadData()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        navigationController?.navigationBar.tintColor = UIColor.white;
        
        searchController.searchBar.barTintColor = UIColor.white
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.placeholder = "Enter Zip Code Here..."
        
        guard let jsonURL = Bundle.main.url(forResource: "hospitalData", withExtension: "json") else {
            print("Could not find json!")
            return
        }
        
        let jsonData = NSData(contentsOf: jsonURL) as Data?
        //if let jsonData = jsonData {
        //    let json = try! JSONSerialization.jsonObject(with: jsonData) as! Array<Hospitals>
        //}
        var provider_names = [String]()
        var provider_street_addresses = [String]()
        var provider_zip_codes = [String]()
        var average_covered_charges = [String]()
        var average_medicare_payments = [String]()
        
        
        do {
            if let jsonData = jsonData,
                let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
                let providers = json["providers"] as? [[String: Any]] {
                for provider in providers {
                    if let name = provider["provider_name"] as? String {
                        provider_names.append(name)
                    }
                    if let address = provider["provider_street_address"] as? String {
                        provider_street_addresses.append(address)
                    }
                    if let code = provider["provider_zip_code"] as? String {
                        provider_zip_codes.append(code)
                    }
                    if let charge = provider["average_covered_charge"] as? String {
                        average_covered_charges.append(charge)
                    }
                    if let payment = provider["average_medicare_payment"] as? String {
                        average_medicare_payments.append(payment)
                    }
                }
            }
        } catch {
            print("Error deserializing JSON: \(error)")
        }
        
        print(provider_names)
        print(provider_street_addresses)
        print(provider_zip_codes)
        print(average_covered_charges)
        print(average_medicare_payments)
        
        hospitalData = []
        var  i = 0
        for p in provider_names {
            let currentHospital = Hospitals()
            currentHospital.provider_name = provider_names[i]
            currentHospital.provider_street_address = provider_street_addresses[i]
            currentHospital.provider_zip_code = provider_zip_codes[i]
            currentHospital.average_covered_charge = average_covered_charges[i]
            currentHospital.average_medicare_payment = average_medicare_payments[i]
            hospitalData.append(currentHospital)
            i = i + 1
        }
        
        print(hospitalData!.count)
        tableView.reloadData()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.hidesNavigationBarDuringPresentation = false
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

    // MARK: - Table view data source

/*    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    } */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredHospitals.count
        }
        return hospitalData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1
        let cell = tableView.dequeueReusableCell(withIdentifier: "tabOneTableViewCell", for: indexPath) as! tabOneTableViewCell
        
        let hospital: Hospitals
        if searchController.isActive && searchController.searchBar.text != "" {
            hospital = filteredHospitals[indexPath.row]
        } else {
            hospital = hospitalData[indexPath.row]
        }
        
        // 2
        cell.hospitalNameLabel.text = hospital.provider_name
        cell.hospitalAddressLabel.text = hospital.provider_street_address + " " + hospital.provider_zip_code
        cell.hospitalChargeLabel.text = "Average Covered Charge: " + hospital.average_covered_charge
        cell.hospitalMedicareLabel.text = "Average Medicare Payment: " + hospital.average_medicare_payment
        
        cell.separatorInset = UIEdgeInsets.zero;
        
        return cell
    }

    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredHospitals = hospitalData.filter { hospital in
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

 /* extension ViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text as! String)
    }
} */
