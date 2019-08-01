//
//  AddEmployeeWithClosureViewController.swift
//  mySecondProjectEmployee
//
//  Created by rails on 25/07/19.
//  Copyright © 2019 rails. All rights reserved.
//

import UIKit

class AddEmployeeWithClosureViewController: UIViewController {
    
    typealias closureFunc = (String, String, String) -> Void
    var closureFunc1: closureFunc?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var degreeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
   
    @IBAction func saveWithClosureFunc(_ sender: UIButton) {
        let name = nameTextField.text
        let surname = surnameTextField.text
        let degree = degreeTextField.text
        guard let closureFunc2 = closureFunc1 else{ return }
        if let name = name, let surname = surname, let degree = degree {
            closureFunc2(name, surname, degree)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}
