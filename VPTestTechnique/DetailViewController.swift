//
//  DetailViewController.swift
//  VPTestTechnique
//
//  Created by Maxence de Cussac on 18/08/2017.
//  Copyright © 2017 Maxence DE CUSSAC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelWeatherDescription: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelTemperatureMin: UILabel!
    @IBOutlet weak var labelTemperatureMax: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var labelCurrentTemperature: UILabel!
    
    var temperatures:(tmin:Double,tmax:Double) = (0,0)
    var humidity: String = ""
    var image :UIImage?
    var weatherDescription: String = ""
    var date:String?
    var currentDate:Date?
    
    var weatherToDisplay: CustomWeatherItemsForDay?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Paris"
        self.navigationItem.hidesBackButton = false
        
        if let temperatureMinForCurrentDay = weatherToDisplay?.temperatureMinForCurrentDay,
            let temperatureMaxForCurrentDay = weatherToDisplay?.temperatureMaxForCurrentDay {
            let temperatureMin = String(format: "%.1f", temperatureMinForCurrentDay)
            let temperatureMax = String(format: "%.1f", temperatureMaxForCurrentDay)
            
            labelTemperatureMin.text = "Minimal temperature :\(temperatureMin) °C" //"Minimal temperature :\(floor(temperatures.tmin-273.15)) °C"
            labelTemperatureMax.text = "Maximal temperature :\(temperatureMax) °C"

        }
        
        labelHumidity.text = "Humidity : \((weatherToDisplay?.humidityString)!)%"
        imageWeather.image = weatherToDisplay?.image
        labelWeatherDescription.text = weatherToDisplay?.customWeatherDescription
        
        
        labelCurrentTemperature.text = "\((weatherToDisplay?.temperatureForCurrentDay)!) °C"
        labelDate.text = "\(getDayOfWeek(forDate: (weatherToDisplay?.date)!)), \((weatherToDisplay?.dateToDisplay)!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
