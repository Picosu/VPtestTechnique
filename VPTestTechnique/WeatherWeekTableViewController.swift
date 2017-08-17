//
//  ViewController.swift
//  VPTestTechnique
//
//  Created by Maxence DE CUSSAC on 17/08/2017.
//  Copyright © 2016 Maxence DE CUSSAC. All rights reserved.
//

import UIKit
import CoreData

class WeatherWeekTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK :- Constantes
    let reuseIdentifierCell = "weather"
    private let cityParisID = "2968815"
    
    /// APP Id pour le site.
    private let appId = "5a480cf3943dd8f6c4b56990ec381dd6"
    
    /// Domaine d'openWeatherMap
    private let apiDomain = "http://api.openweathermap.org/"
    
    /// Domaine des images d'openWeathermap
    public var iconUrlDomain: String {
        return "\(self.apiDomain)img/w/"
    }
    
    /// Nombre d'objet présent par jour. Actuellement toutes les 3h
    private let numberOfItemsPerDay = 8
    
    
    // MARK :- Variables
    var mains: [[String:Double]] = []
    var weathers:[CustomWeatherItem] = []
    var dates: [String] = []
    var datesUnformatted : [Date] = []
    var weathersForDay : [CustomWeatherItemsForDay] = [] {
        didSet {
            DispatchQueue.main.async {
                self.actualiserTableView()
            }
        }
    }
    var refreshControl = UIRefreshControl()
    
    /// Tableau contenant les images des différents temps
    private var images:[UIImage] = []
    
    /// Tableau avec les NSData des images pour CoreData
    private var imagesData:[Data] = []
    
    // MARK :- Outlets
    @IBOutlet weak var weekTableView: UITableView!
    @IBOutlet weak var refreshActivityIndicator: UIActivityIndicatorView!
    
    // MARK :- Lyfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weekTableView.rowHeight = UITableViewAutomaticDimension
        self.weekTableView.estimatedRowHeight = 130
        
        // Add pull to refresh reload
        self.setupTableView()
        self.loadDataForTableView()
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK :- Private methods
    @objc private func loadDataForTableView() {
        NetworkManager.retrieveDataFromApi { (weathers) in
            self.weathersForDay = weathers
            self.actualiserTableView()
        }
    }
    
    private func setupTableView() {
        let refresher = UIRefreshControl()
        refreshControl = refresher
        refresher.addTarget(self, action: #selector(self.loadDataForTableView), for: .valueChanged)
        
        weekTableView.addSubview(refresher)
    }
    
    private func actualiserTableView()
    {
        self.refreshActivityIndicator.startAnimating()
        
        DispatchQueue.main.async(execute: {
            self.weekTableView.reloadData()
            self.refreshActivityIndicator.stopAnimating()
            self.refreshControl.endRefreshing()
            self.refreshActivityIndicator.isHidden = true
            return
        })
    }
    
    // MARK :- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCell) as? CustomTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "default")
        }
        
        if weathersForDay.count > indexPath.row {
            cell.weatherToDisplay = weathersForDay[indexPath.row]
            
            // Ensure to display the image
            let weather = weathersForDay[indexPath.row]
            weather.weathers.first?.callBackImage = {_  in
                cell.imageViewWeather.image = self.weathersForDay[indexPath.row].image  
            }
            
    
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sender = sender as! CustomTableViewCell
        let index = weekTableView.indexPath(for: sender)?.row
        print(weekTableView.indexPath(for: sender) ?? "0")
        
        if segue.identifier == "temp" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.weatherToDisplay = weathersForDay[index!]
        }
        
        // Reset selection cells if needed
        if let indexPathSelect = weekTableView.indexPathForSelectedRow {
            weekTableView.deselectRow(at: indexPathSelect, animated: true)
        }
    }
}
