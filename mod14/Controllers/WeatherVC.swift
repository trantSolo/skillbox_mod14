//
//  WeatherVC.swift
//  mod14
//
//  Created by Solo Trant on 19/03/2019.
//  Copyright © 2019 Solo Trant. All rights reserved.
//

import UIKit
import RealmSwift

class WeatherVC: UIViewController {
    
    let cellId = "WeatherCell"
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = List<DailyWeather>()
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    
    @IBOutlet weak var firstTimeLabel: UILabel!
    @IBOutlet weak var secondTimeLabel: UILabel!
    @IBOutlet weak var thirdTimeLabel: UILabel!
    
    @IBOutlet weak var firstTemperatureLabel: UILabel!
    @IBOutlet weak var secondTemperatureLabel: UILabel!
    @IBOutlet weak var thirdTemperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.allowsSelection = false
        
        getPersistanceWeather()
        
        self.tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        let manager = DataManager()
        manager.getWeatherData { [weak self] weather, error in
            if let error = error {
                print("err \(error)")
            } else if let weather = weather {
                DispatchQueue.main.async {
                    if let firstHour = weather.hourly?.data[1],
                    let secondHour = weather.hourly?.data[2],
                        let thirdHour = weather.hourly?.data[3] {
                    
                        self?.firstTimeLabel.text = DateNormalizer.shared.normalizeWithHours(date: firstHour.time)
                        self?.secondTimeLabel.text = DateNormalizer.shared.normalizeWithHours(date: secondHour.time)
                        self?.thirdTimeLabel.text = DateNormalizer.shared.normalizeWithHours(date: thirdHour.time)
                        
                        self?.firstTemperatureLabel.text = "\(String(firstHour.temperature))° C"
                        self?.secondTemperatureLabel.text = "\(String(secondHour.temperature))° C"
                        self?.thirdTemperatureLabel.text = "\(String(thirdHour.temperature))° C"
                        
                        self?.currentTemperatureLabel.text = "\(String(weather.currently?.temperature ?? 0))° C"
                        self?.currentSummaryLabel.text = weather.currently?.summary
                        if let daileData = weather.daily?.data {
                            self?.dataSource.append(objectsIn: daileData)
                        }
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func getPersistanceWeather() {
        if let weather = RealmService.shared.getWeather() {
            self.dataSource = weather.daily?.data ?? List<DailyWeather>()
            self.tableView.reloadData()
            
            if let firstHour = weather.hourly?.data[1],
            let secondHour = weather.hourly?.data[2],
                let thirdHour = weather.hourly?.data[3] {
            
                self.firstTimeLabel.text = DateNormalizer.shared.normalizeWithHours(date: firstHour.time)
                self.secondTimeLabel.text = DateNormalizer.shared.normalizeWithHours(date: secondHour.time)
                self.thirdTimeLabel.text = DateNormalizer.shared.normalizeWithHours(date: thirdHour.time)
                
                self.firstTemperatureLabel.text = "\(String(firstHour.temperature))° C"
                self.secondTemperatureLabel.text = "\(String(secondHour.temperature))° C"
                self.thirdTemperatureLabel.text = "\(String(thirdHour.temperature))° C"
                
                self.currentTemperatureLabel.text = "\(String(weather.currently?.temperature ?? 0))° C"
                self.currentSummaryLabel.text = weather.currently?.summary
            }
        }
    }
    
}

extension WeatherVC: UITabBarDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as! WeatherCell
        cell.setup(weather: dataSource[indexPath.row])
        
        return cell
    }
    
}
