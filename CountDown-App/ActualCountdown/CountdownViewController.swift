//
//  CountdownViewController.swift
//  CountDown-App
//
//  Created by Amin  Bagheri  on 2022-06-15.
//

import UIKit

class CountdownViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var event: Event?
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            self?.setAndUpdateTime()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = "\(event!.name!)"
        
        guard let data = event?.image else { return }
        if CoreDataManager.shared.dataAsImage(data: (data)) != nil {
            backgroundImageView.image = CoreDataManager.shared.dataAsImage(data: (event?.image)!)
        } else {
            print("No data to turn to image(CVC 31)")
        }
        
        
        setAndUpdateTime()
    }
    
    fileprivate func setAndUpdateTime() {
        event?.startDate = .now
        
        let timeLeft = (event!.endDate! - event!.startDate!)
        
        let yearsAsSeconds = (timeLeft.asYears().rounded(.down)) * 31536000
        let days = timeLeft - yearsAsSeconds
        
        let daysAsSeconds = (timeLeft.asDays().rounded(.down)) * 86400
        let hours = timeLeft - daysAsSeconds
        print(hours.asHours().rounded(.down).stringWithoutZeroFraction)
        
        let hoursAsSeconds = (timeLeft.asHours().rounded(.down)) * 3600
        let minutes = timeLeft - hoursAsSeconds
        
        let minutesAsSeconds = (timeLeft.asMinutes().rounded(.down)) * 60
        let seconds = timeLeft - minutesAsSeconds
        
        if timeLeft.asYears().rounded(.down).stringWithoutZeroFraction != "0" {
            descriptionLabel.text =
                    """
                    \(timeLeft.asYears().rounded(.down).stringWithoutZeroFraction) years,
                    \(days.asDays().rounded(.down).stringWithoutZeroFraction) days,
                    \(hours.asHours().rounded(.down).stringWithoutZeroFraction) hours,
                    \(minutes.asMinutes().rounded(.down).stringWithoutZeroFraction) minutes,
                    \(seconds.rounded(.down).stringWithoutZeroFraction) seconds
                    until…
                    """
        } else {
            descriptionLabel.text =
                                            """
                                            \(days.asDays().rounded(.down).stringWithoutZeroFraction) days,
                                            \(hours.asHours().rounded(.down).stringWithoutZeroFraction) hours,
                                            \(minutes.asMinutes().rounded(.down).stringWithoutZeroFraction) minutes,
                                            \(seconds.rounded(.down).stringWithoutZeroFraction) seconds
                                            until…
                                            """
            
        }
    }

}
