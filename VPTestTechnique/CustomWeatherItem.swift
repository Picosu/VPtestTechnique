//
//  CustomWeatherItem.swift
//  VPWeatherApp
//
//  Created by Maxence DE CUSSAC on 27/09/2016.
//  Copyright © 2016 Maxence DE CUSSAC. All rights reserved.
//

import UIKit

class CustomWeatherItem: NSObject {
    
    /// La date et heure des infos
    var dateTime:Double?
    
    /// Pour les températures
    var main:[String:Double]?
    
    /// Pour la description et les urls des icones
    var weather:[String:AnyObject]? {
        didSet {
            if let weather = self.weather {
                self.retrieveImages(forWeather: weather)
            }
        }
    }
    
    /// Une image pour le temps
    var image : UIImage?
    
    /// L'humidité du jour
    var humidity : Double?
    
    var callBackImage : ((UIImage) -> Void)?
    
    /// Les différentes températures en tuples. Elles vont donc par 3
    var temperatures:(temperatureMin:Double,temperatureMax:Double,temperature:Double) = (0,0,0)
    
    init(withJson json: GenericJson) {
        super.init()
        
        let tempWeather = json["weather"] as? [GenericJson]
        weather = tempWeather?.first
        retrieveImages(forWeather: weather!)
        
        dateTime = json["dt"] as? Double
        if let currentMain = json["main"] as? [String : Double]! {
            temperatures.temperatureMin = currentMain["temp_min"]!
            temperatures.temperatureMax = currentMain["temp_max"]!
            temperatures.temperature = currentMain["temp"]!
            humidity = currentMain["humidity"]
        }
    }
    
    /// Récupère les images depuis internet en asynchrone.
    private func retrieveImages(forWeather weather:[String:AnyObject]) {
        if let urlString = URL(string: "http://api.openweathermap.org/img/w/\(weather["icon"]!).png") {
            let task = URLSession.shared.dataTask(with: urlString) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)!
                        self.callBackImage?(self.image!)
                    }
                }
            }
            task.resume()
        }
    }
}
