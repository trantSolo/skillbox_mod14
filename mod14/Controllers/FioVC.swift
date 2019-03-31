//
//  FioVC.swift
//  mod14
//
//  Created by Solo Trant on 19/03/2019.
//  Copyright © 2019 Solo Trant. All rights reserved.
//

import UIKit

class FioVC: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.text = UserDefaultsService.shared.name
        surnameTextField.text = UserDefaultsService.shared.surname
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        UserDefaultsService.shared.name = nameTextField.text
        UserDefaultsService.shared.surname = surnameTextField.text
    }
    
}
