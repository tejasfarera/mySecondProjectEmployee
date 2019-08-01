//
//  EmployeeDataViewController.swift
//  mySecondProjectEmployee
//
//  Created by rails on 17/07/19.
//  Copyright © 2019 rails. All rights reserved.
//

import UIKit

class EmployeeDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SendBackEmployeeDelegate, SendBackEditEmployeeDelegate {
    
    //    MARK: - class properties
    @IBOutlet weak var employeeTableView: UITableView!
    var employeeDataList = Array<Dictionary<String,String>>()
    var tableIndex = Int()
    var showType = String()
    
    //    MARK: - view methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //   MARK: - segue methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToAddEmployee"{
    
            guard let nextVC: EmployeeAddDetailViewController = segue.destination as? EmployeeAddDetailViewController else{
                return
            }
            nextVC.showType = "add"
            nextVC.employeeAddDelegate = self
        }
        if segue.identifier == "segueToViewEmployee" {
            guard let nextVC: EmployeeAddDetailViewController = segue.destination as? EmployeeAddDetailViewController else{
                return
            }
            nextVC.showType = "view"
            nextVC.employeeDataDictionary = employeeDataList[tableIndex]
            nextVC.employeeEditDelegate = self
        }
       
    }
    
    //    MARK: - action methods
    @IBAction func addEmployee(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "segueToAddEmployee", sender: nil)
    }
    
    //    MARK: - Table view delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseEmployeeCell", for: indexPath) as? employeeTableViewCell else{
            return employeeTableViewCell()
        }
        
        cell.nameTextView.text = employeeDataList[indexPath.row]["name"]
        cell.surnameTextView.text = employeeDataList[indexPath.row]["surname"]
        cell.degreeTextView.text = employeeDataList[indexPath.row]["degree"]
        employeeTableView.rowHeight = 150
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableIndex = indexPath.row
        performSegue(withIdentifier: "segueToViewEmployee", sender: nil)
    }
    
    //    MARK: - Delegate methods
    func employeeDetails(name: String, surname: String, degree: String) {
        employeeDataList.append(["name": name, "surname": surname, "degree": degree])
        employeeTableView.reloadData()
    }
    
    func employeeEditDetails(name: String, surname: String, degree: String) {
        employeeDataList.remove(at: tableIndex)
        employeeDataList.insert(["name": name, "surname": surname, "degree": degree], at: tableIndex)
        employeeTableView.reloadData()
    }
    
}
