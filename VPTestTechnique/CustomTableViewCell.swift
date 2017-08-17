//
//  CustomTableViewCell.swift
//  VPWeatherApp
//
//  Created by Maxence DE CUSSAC on 21/09/2016.
//  Copyright © 2016 Maxence DE CUSSAC. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    // MARK :- Outlets
    @IBOutlet weak var labelWeatherDescription: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var imageViewWeather: UIImageView!
    @IBOutlet weak var labelTemperatures: UILabel!
    
    // MARK :- Variables
    var weatherToDisplay:CustomWeatherItemsForDay? {
        didSet{
            if let weatherToDisplay = self.weatherToDisplay {
                self.labelTemperatures.text = "Tmin : \(weatherToDisplay.temperatureMinForCurrentDay)°C  \tTmax : \(weatherToDisplay.temperatureMaxForCurrentDay)°C"
                self.labelWeatherDescription.text = weatherToDisplay.customWeatherDescription
                self.labelDate.text = weatherToDisplay.dateToDisplay
                self.imageViewWeather.image = weatherToDisplay.image
            }
        }
    }
    
    // MARK :- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
