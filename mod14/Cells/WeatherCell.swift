//
//  WeatherCell.swift
//  mod13
//
//  Created by Solo Trant on 14/03/2019.
//  Copyright © 2019 Solo Trant. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(weather: DailyWeather) {
        self.dateLabel.text = DateNormalizer.shared.normalize(date: weather.time)
        self.temperatureLabel.text = "\(String(weather.temperatureHigh))° C"
        self.summaryLabel.text = weather.summary
    }
    
}
