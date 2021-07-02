//
//  TimeCircuitsViewController.swift
//  OutaTime-II
//
//  Created by Gerardo Hernandez on 6/30/21.
//

import UIKit

enum Alert {
    case invalidDestination
    case complete
}

class TimeCircuitsViewController: UIViewController {
    
    // MARK: - Properties
    private var currentSpeed = 0
    private var timer: Timer? = nil
    
    private(set) var alert: Alert?
    var delegate: DatePickerDelegate?
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat =  "MMM d, yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    // MARK: - Oulets
    @IBOutlet weak var destinationTimeLabel: UILabel!
    @IBOutlet weak var presetTimeLabel: UILabel!
    @IBOutlet weak var lastTimeLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    

    @IBOutlet weak var travelBackButton: UIButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - IBActions
    @IBAction func travelBackButton(_ sender: UIButton) {
        if destinationTimeLabel.text != "--- -- ----" {
            startTimer()
        } else {
            alert = .invalidDestination
            showAlert()
        }
    }
    
    // MARK: - Methods
    private func startTimer() {
        resetTimer()
        travelBackButton.isEnabled = false
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: updateSpeed(timer:))
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateSpeed(timer: Timer) {
        if currentSpeed < 88 {
            currentSpeed += 1
            speedLabel.text = "\(currentSpeed) MPH"
        } else {
            resetTimer()
            travelBackButton.isEnabled = true
            lastTimeLabel.text = presetTimeLabel.text
            presetTimeLabel.text = destinationTimeLabel.text
            destinationTimeLabel.text = "--- -- ----"
            currentSpeed = 0
            speedLabel.text = "\(currentSpeed) MPH"
            alert = .complete
            showAlert()
        }
        
    }
    
    // MARK: - Alerts
    func showAlert() {
        
        switch alert {
        case .complete:
            
            guard let presentTime = presetTimeLabel.text else { return }
            let alertController = UIAlertController(title: "Time Travel Successful", message: "You're new date is \(presentTime) ", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        case .invalidDestination:
            let alert = UIAlertController(title: "No Destination Time", message: "Please set a destination time.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        default:
            break
        }
        
        
    }
    
    // MARK: - Helper Methods
    private func updateViews() {
        destinationTimeLabel.text = "--- -- ----"
        presetTimeLabel.text = dateFormatter.string(from: Date())
        speedLabel.text = "\(currentSpeed) MPH"
        lastTimeLabel.text = "--- -- ----"
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ModalDestinationDatePickerSegue" {
            guard let datePickerVC = segue.destination as? DatePickerViewController else { return }
            datePickerVC.delegate = self
            
        }
    }
}

// MARK: - Extension
extension TimeCircuitsViewController: DatePickerDelegate {
    func destinationDateWasChosen(_ date: Date) {
        let formattedString = dateFormatter.string(from: date)
        destinationTimeLabel.text = formattedString
        
    }
}

extension Int {
    func string() -> String {
        return String(self)
    }
}





