//
//  employeeTableViewCell.swift
//  mySecondProjectEmployee
//
//  Created by rails on 18/07/19.
//  Copyright © 2019 rails. All rights reserved.
//

import UIKit

class employeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var surnameTextView: UITextView!
    @IBOutlet weak var degreeTextView: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // MARK: - action methods
    
    /// Hi
    ///
    /// - Parameters:
    ///   - selected: hi
    ///   - animated: hi
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
