//
//  TimeCircuitsViewController.swift
//  OutaTime-II
//
//  Created by Gerardo Hernandez on 6/30/21.
//

import UIKit

class TimeCircuitsViewController: UIViewController {

    // MARK: - Properties
    var currentSpeed = 0
    
   // MARK: - Oulets
    @IBOutlet weak var destinationTimeLabel: UILabel!
    @IBOutlet weak var presetTimeLabel: UILabel!
    @IBOutlet weak var lastTimeLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var setTimeButton: UIButton!
    @IBOutlet weak var travelBackButton: UIButton!
    
    
    private var dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat =  "MMM d, yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    
    // MARK: - IBActions
    @IBAction func travelBackButton(_ sender: UIButton) {
    }
    
    private func updateViews() {
        presetTimeLabel.text = dateFormatter.string(from: Date())
        speedLabel.text = "\(String(currentSpeed)) MPH"
        lastTimeLabel.text = "--- -- ----"

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
