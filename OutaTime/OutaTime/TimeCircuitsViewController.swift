//
//  TimeCircuitsViewController.swift
//  OutaTime
//
//  Created by Gerardo Hernandez on 12/10/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import UIKit

class TimeCircuitsViewController: UIViewController {
    
    //Mark: Outlets
    @IBOutlet weak var destinationTimeLabel: UILabel!
    @IBOutlet weak var presentTimeLabel: UILabel!
    @IBOutlet weak var lastTimeDepartedLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    

    
    //Mark: Properties
    
    private var timer: Timer?
    
    var currentSpeed: Int = 0
    
    var dateFormatter: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateFormat = "MMM dd yyyy"
          formatter.timeZone = TimeZone(secondsFromGMT: 0)
          return formatter
      }()

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentTimeLabel.text = dateFormatter.string(from: Date())
        speedLabel.text = String(currentSpeed) + "MPH"
        lastTimeDepartedLabel.text = "--- -- ----"

}
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "ModalDestinationDatePickerSegue" {
               
               guard let dataPickerVC = segue.destination as? DatePickerViewController else {
                   return }
            dataPickerVC.delegate = self
           }
       }
    
     // MARK: - Private
    
    private func startTimer() {
        resetTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: updateSpeed(timer:))
    }
    
    private func resetTimer() {
            timer?.invalidate()
            timer = nil
        }
    
    
    private func showAlert(newDate: String) {
        let alert = UIAlertController(title: "Time Travel Successful", message: "Your new date is \(String(describing: destinationTimeLabel)).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func updateSpeed(timer: Timer) {

    if currentSpeed < 88 {
        speedLabel.text = String(currentSpeed) + "MPH"
        currentSpeed += 1
        } else {
        resetTimer()
            lastTimeDepartedLabel.text = presentTimeLabel.text
            presentTimeLabel.text = destinationTimeLabel.text
            currentSpeed = 0
        
            guard let newDate = self.presentTimeLabel.text else { return }
        
        showAlert(newDate: newDate)
}
      
}
    
    @IBAction func travelBackButton(_ sender: UIButton) {
        startTimer()
    }
    
}


extension TimeCircuitsViewController: DatePickerDelegate {
    
    func destinationDateWasChosen(date: Date) {
        destinationTimeLabel.text = dateFormatter.string(from: date)
    }

}

