//
//  DataParser.swift
//  VPTestTechnique
//
//  Created by Maxence de Cussac on 17/08/2017.
//  Copyright © 2017 Maxence de Cussac. All rights reserved.
//

import Foundation
import UIKit

private let numberOfItemsPerDay = 8

class DataParser {
    
    
    class func parse(productData data: Data) -> [CustomWeatherItemsForDay] {

        /*
         Dev
         */
        // Always return the same array, for more clarity
        var resultFromParsing = [CustomWeatherItemsForDay]()

        do {
            let jsonReceived = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            guard let weathers = jsonReceived as? GenericJson else {
                print("An error occured while parsing data")
                return resultFromParsing
            }
            
            var countItemList = weathers["cnt"] as! Int
            var numberOfItemsToAdd = countItemList%numberOfItemsPerDay == 0 ? numberOfItemsPerDay : countItemList%numberOfItemsPerDay

            let allListsFromApi = weathers["list"]! as! [[String:AnyObject]]
            var firstIndex = 0
            while countItemList > 0 {
                numberOfItemsToAdd = countItemList%numberOfItemsPerDay == 0 ? numberOfItemsPerDay : countItemList%numberOfItemsPerDay
                var tempArray = [CustomWeatherItem]()
                for index in firstIndex ..< numberOfItemsToAdd+firstIndex {
                    let currentList = allListsFromApi[index]
                    
                    let myWeather : CustomWeatherItem = CustomWeatherItem(withJson: currentList)
                    tempArray.append(myWeather)
                }
                let weatherForADay = CustomWeatherItemsForDay(withCustomWeathers: tempArray)
                resultFromParsing.append(weatherForADay)
                firstIndex += numberOfItemsToAdd
                countItemList -= numberOfItemsToAdd
            }
        } catch {
            print("\terror parsing\(error)")
        }
        
        return resultFromParsing
    }
}
