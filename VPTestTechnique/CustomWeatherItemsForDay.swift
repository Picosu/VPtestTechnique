//
//  CustomWeatherForDay.swift
//  VPWeatherApp
//
//  Created by Maxence DE CUSSAC on 28/09/2016.
//  Copyright © 2016 Maxence DE CUSSAC. All rights reserved.
//

import UIKit

class CustomWeatherItemsForDay: NSObject {
    var weathers :[CustomWeatherItem]
    
    var temperatureMinForCurrentDay:Double {
        var tempMin = 400.0
        for weather in weathers {
            if tempMin > weather.temperatures.temperatureMin {
                tempMin = weather.temperatures.temperatureMin
            }
        }
        return round(tempMin - offsetTemperatureKelvin)
    }
    
    var temperatureMaxForCurrentDay:Double {
        var tempMax = 0.0
        for weather in weathers {
            if tempMax < weather.temperatures.temperatureMax {
                tempMax = weather.temperatures.temperatureMax
            }
        }
        return round(tempMax - offsetTemperatureKelvin)
    }
    
    var temperatureForCurrentDay:Double {
        return round((self.temperatureMaxForCurrentDay + self.temperatureMinForCurrentDay) / 2)
    }
    
    var humidityForCurrentDay:Double! {
        var humidity = 0.0
        for weather in weathers {
            humidity += weather.humidity!
        }
        
        return (humidity/Double(weathers.count))
    }
    
    var humidityString:String {
        return String(format: "%.1f", self.humidityForCurrentDay!)
    }
    
    var customWeatherDescription:String {
        return (weathers.first?.weather!["description"] as! String).capitalized
    }
    
    var dateToDisplay:String {
        return formatDate(date: Date(timeIntervalSince1970: TimeInterval((weathers.first?.dateTime)!)))
    }
    
    var date:Date {
        return Date(timeIntervalSince1970: TimeInterval((weathers.first?.dateTime)!))
    }
    var image:UIImage? {
        return weathers.first?.image
    }
    
    init(withCustomWeathers customWeathers:[CustomWeatherItem]) {
        weathers = customWeathers
    }
}
