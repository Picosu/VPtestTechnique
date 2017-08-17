//
//  Utils.swift
//  VPTestTechnique
//
//  Created by Maxence de Cussac on 17/08/2016.
//  Copyright © 2016 Maxence DE CUSSAC. All rights reserved.
//

import Foundation

// MARK :- Constantes globales
public let offsetTemperatureKelvin = 273.15

/// Récupère le jour de la semaine associé à la date
internal func getDayOfWeek(forDate:Date)->String {
    var dayOfWeek:String = "No days matching"
//    let todayDate = Date()
    let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
    let myComponent = myCalendar.component(.weekday, from: forDate)
    switch myComponent {
    case 1:
        dayOfWeek = "Sunday"
        break
    case 2:
        dayOfWeek = "Monday"
        break
    case 3:
        dayOfWeek = "Tuesday"
        break
    case 4:
        dayOfWeek = "Wednesday"
        break
    case 5:
        dayOfWeek = "Thursday"
        break
    case 6:
        dayOfWeek = "Friday"
        break
    case 7:
        dayOfWeek = "Saturday"
        break
    default:
        dayOfWeek = "An error occured"
        break
    }

    return dayOfWeek
}

/// Formatte la date sous la forme dd/MM/yyyy
internal func formatDate(date:Date) -> String {
    var resultDate = ""
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    
    resultDate = dateFormatter.string(from: date)
    return resultDate
}
