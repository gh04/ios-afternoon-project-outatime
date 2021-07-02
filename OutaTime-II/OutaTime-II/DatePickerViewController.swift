//
//  DatePickerViewController.swift
//  OutaTime-II
//
//  Created by Gerardo Hernandez on 6/30/21.
//

import UIKit
// MARK: - Protocols
protocol DatePickerDelegate: AnyObject {
    func destinationDateWasChosen(_ date: Date)
}

class DatePickerViewController: UIViewController {

    // MARK: - Properties
    weak var delegate: DatePickerDelegate?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    // MARK: - Actions
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        guard datePicker.date < Date() else { return showAlert() }
        delegate?.destinationDateWasChosen(datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIAlert
    private func showAlert() {
        let alert = UIAlertController(title: "Invalid date", message: "Pick a date in the past.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

}

