//
//  DetailViewController.swift
//  SwiftyContact
//
//  Created by Mike Henry on 10/27/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var selectedPerson :Persons?
    @IBOutlet weak var  firstNameTextField  :UITextField!
    @IBOutlet weak var  lastNameTextField   :UITextField!
    @IBOutlet weak var  streetTextField     :UITextField!
    @IBOutlet weak var  cityTextField       :UITextField!
    @IBOutlet weak var  stateTextField      :UITextField!
    @IBOutlet weak var  zipTextField        :UITextField!
    @IBOutlet weak var  phoneTextField      :UITextField!
    @IBOutlet weak var  emailTextField      :UITextField!
    
    //MARK: Display Methods

    
    //MARK: Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        firstNameTextField.text = selectedPerson?.personFirstName
        lastNameTextField.text = selectedPerson?.personLastName
        streetTextField.text = selectedPerson?.personStreet
        cityTextField.text = selectedPerson?.personCity
        stateTextField.text = selectedPerson?.personState
        zipTextField.text = selectedPerson?.personZip
        phoneTextField.text = selectedPerson?.personPhone
        emailTextField.text = selectedPerson?.personEmail
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
