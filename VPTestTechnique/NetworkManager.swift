//
//  NetworkManager.swift
//  VPTestTechnique
//
//  Created by Maxence de Cussac on 17/08/2017.
//  Copyright © 2017 Maxence de Cussac. All rights reserved.
//

import UIKit

/// Alias for Jsons
typealias GenericJson = [String:AnyObject]

/// APP Id from the site.
private let appId = "5a480cf3943dd8f6c4b56990ec381dd6"

/// Domaine d'openWeatherMap
private let apiDomain = "http://api.openweathermap.org/"

/// Domaine des images d'openWeathermap
public var iconUrlDomain: String {
    return "\(apiDomain)img/w/"
}

private let cityParisID = "2968815"


/// Api's URL
public let apiUrl = "https://bigburger.useradgents.com/catalog"

class NetworkManager: NSObject {
    
    class func retrieveDataFromUrl(fromUrl url:URL, callBack: @escaping (UIImage) -> ()) {
        
        let req = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let data = data {
                if let image = UIImage(data: data) {
                    callBack(image)
                }
            } else {
                print("Error while retrieving data from url :\(url)")
            }
        }
        
        task.resume()
    }
    // MARK :- Public methods
    
    class func retrieveDataFromApi(callBack: @escaping ([CustomWeatherItemsForDay]) -> ()) {
        guard let url = URL(string: "\(apiDomain)data/2.5/forecast?id=\(cityParisID)&APPID=\(appId)") else {
            return;
        }
        
        let req = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let data = data {
                if data.isEmpty {
                    callBack([CustomWeatherItemsForDay]())
                    print(response ?? "")
                }
                callBack(DataParser.parse(productData: data))
            } else {
                print("Error while retrieving data from url :\(url)")
            }
        }
        
        task.resume()
    }
}
