//
//  DatePickerViewController.swift
//  OutaTime
//
//  Created by Gerardo Hernandez on 12/10/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import UIKit


protocol DatePickerDelegate {
    
    func destinationDateWasChosen(date: Date)
}


class DatePickerViewController: UIViewController {
   
 //Mark: Outlets

    @IBOutlet weak var datePicker: UIDatePicker!
    //Mark: Properties
    var delegate: DatePickerDelegate?
   
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.setValue(UIColor.white, forKey: "textColor")
    }

    //Mark: Actions
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
           dismiss(animated: true, completion: nil)
       }
       
       @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        let date = datePicker.date
        delegate?.destinationDateWasChosen(date: date)
        dismiss(animated: true, completion: nil)
        
       }
   
    // MARK: - Navigation
     

}

//alert controllers
//basic persistance reading list
//collection view
