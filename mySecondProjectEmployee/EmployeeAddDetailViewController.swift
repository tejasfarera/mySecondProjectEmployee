//
//  EmployeeAddDetailViewController.swift
//  mySecondProjectEmployee
//
//  Created by rails on 18/07/19.
//  Copyright © 2019 rails. All rights reserved.
//

import UIKit

protocol SendBackEmployeeDelegate {
    func employeeDetails(name: String, surname: String, degree: String)
}

protocol SendBackEditEmployeeDelegate{
    func employeeEditDetails(name: String, surname: String, degree: String)
}

class EmployeeAddDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var employeeAddDelegate: SendBackEmployeeDelegate!
    var employeeEditDelegate: SendBackEditEmployeeDelegate!
    
    @IBOutlet weak var degreeTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var saveWithClosureButton: UIButton!
    
    var employeeData = Dictionary<String,String>()
    var showType : String!
    var employeeDataDictionary = Dictionary<String,String>()
    var degreeList = ["Bachelor of Architecture",
                      "Bachelor of Biomedical Science",
                      "Bachelor of Business Administration",
                      "Bachelor of Clinical Science",
                      "Bachelor of Commerce",
                      "Bachelor of Computer Applications",
                      "Bachelor of Community Health",
                      "Bachelor of Computer Information Systems",
                      "Bachelor of Science in Construction Technology",
                      "Bachelor of Criminal Justice",
                      "Bachelor of Divinity",
                      "Bachelor of Economics",
                      "Bachelor of Education",
                      "Bachelor of Engineering",
                      "Bachelor of Fine Arts",
                      "Bachelor of Letters",
                      "Bachelor of Information Systems",
                      "Bachelor of Management",
                      "Bachelor of Music",
                      "Bachelor of Pharmacy",
                      "Bachelor of Philosophy",
                      "Bachelor of Social Work",
                      "Bachelor of Technology",
                      "Bachelor of Accountancy",
                      "Bachelor of Arts in American Studies",
                      "Bachelor of Arts in American Indian Studies",
                      "Bachelor of Arts in Applied Psychology",
                      "Bachelor of Arts in Biology",
                      "Bachelor of Arts in Anthropology",
                      "Bachelor of Arts in Child Advocacy",
                      "Bachelor of Arts in Clinical Psychology",
                      "Bachelor of Arts in Forensic Psychology",
                      "Bachelor of Arts in Organizational Psychology",
                      "Bachelor of Science in Aerospace Engineering",
                      "Bachelor of Science in Actuarial",
                      "Bachelor of Science in Agriculture",
                      "Bachelor of Science in Architecture"]
    
    // MARK: - view methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIAccordingShowType()
    }
    
    //    MARK: - UI set methods
    func setUIAccordingShowType(){
        switch showType {
        case "add":
            activateAddMode()
            createPicker()
            dismissPicker()
        case "view":
            activateViewMode()
            setDataToUI()
        default:
            print("the show type is null")
        }
    }
    
    func activateAddMode(){
        editBarButton.isEnabled = false
        editBarButton.tintColor = UIColor.clear
    }
    
    func activateViewMode(){
        saveButton.isHidden = true
        nameTextField.isUserInteractionEnabled = false
        surnameTextField.isUserInteractionEnabled = false
        degreeTextField.isUserInteractionEnabled = false
    }
    
    func setDataToUI(){
        nameTextField.text = employeeDataDictionary["name"]
        surnameTextField.text = employeeDataDictionary["surname"]
        degreeTextField.text = employeeDataDictionary["degree"]
    }
    
    func dismissCurrentViewController(){
        navigationController?.popViewController(animated: true)
        self.dismiss(animated:true, completion: nil)
    }
    
    func formIncompleteAlert(){
        let alert = UIAlertController(title: "Incomplete data", message: "Every field is mandatory to fill", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //    MARK: - segue methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as? AddEmployeeWithClosureViewController
        if let nextVC = nextVC{
            nextVC.closureFunc1 = {
                (name, surname, degree) in
                
                self.nameTextField.text = name
                self.surnameTextField.text = surname
                self.degreeTextField.text = degree
            }
        }
    }
    
    //    MARK: - action methods
    @IBAction func saveDetail(_ sender: UIButton) {
        if (validateUI()){
            setUserInputToDelegate()
            dismissCurrentViewController()
        }
        else{
            formIncompleteAlert()
        }
    }
    @IBAction func enterWithClosureAction(_ sender: UIButton) {
        performSegue(withIdentifier: "segueToAddWithClosure", sender: nil)
    }
    
    @IBAction func editDetail(_ sender: UIBarButtonItem) {
        activateEditMode()
        createPicker()
        dismissPicker()
    }
    
    func activateEditMode(){
        editBarButton.isEnabled = false
        editBarButton.tintColor = UIColor.clear
        saveButton.isHidden = false
        nameTextField.isUserInteractionEnabled = true
        surnameTextField.isUserInteractionEnabled = true
        degreeTextField.isUserInteractionEnabled = true
    }
    
    func validateUI() -> Bool{
        if(nameTextField.hasText && surnameTextField.hasText && degreeTextField.hasText){
            return true
        }
        return false
    }
    
    func setUserInputToDelegate(){
        switch showType {
        case "add":
            if (employeeAddDelegate != nil) {
                employeeAddDelegate!.employeeDetails(name: nameTextField.text!, surname: surnameTextField.text!,
                                                     degree: degreeTextField.text!)
            }
        case "view":
            if (employeeEditDelegate != nil) {
                employeeEditDelegate!.employeeEditDetails(name: nameTextField.text!, surname: surnameTextField.text!,
                                                          degree: degreeTextField.text!)
            }
        default:
            print("the show type is null")
        }
    }
    
    func createPicker (){
        let degreePickerView = UIPickerView()
        degreePickerView.delegate = self
        degreeTextField.inputView = degreePickerView
    }
    
    func dismissPicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action:
            #selector(self.dismissKeyboard))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        degreeTextField.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return degreeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        degreeTextField.text = degreeList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return degreeList[row]
    }
}
