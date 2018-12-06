//
//  ViewController.swift
//  Hoodie Weather
//
//  Created by Dvontre Coleman on 12/6/18.
//  Copyright © 2018 Dvontre A Coleman. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // Variables for the api url and key
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "13692807f1ddf9f5148d4b360e1d0039"
    
    // Variable for location manager
    let locationManager = CLLocationManager()
    // variable to hold the weather interperater
    let weatherInterprater = WeatherInterpreter()
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // sets the location manager to delegate to equal the view controller to
        locationManager.delegate = self
        // Sets the location data accuracy to be a low degree since we are using it for the city
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        // Asks user for permission to get location data when app is being used
        locationManager.requestWhenInUseAuthorization()
        // Looks for gps location of current iphone in the background (async)
        locationManager.startUpdatingLocation()
    }


    @IBAction func getWeather(_ sender: Any) {
        weatherLabel.text = weatherInterprater.hoodieCheck(temp: 43)
    }
}

