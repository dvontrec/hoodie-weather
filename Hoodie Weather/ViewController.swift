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
        locationManager.delegate = self
        // Sets the location data accuracy to be a low degree since we are using it for the city
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        // Asks user for permission to get location data when app is being used
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    //Write the getWeatherData method here:
    func getWeatherData(url: String, parameters: [String : String]){
        // Calls a get request to the provided url with the perameters passed in
        Alamofire.request(url, method: .get, parameters : parameters).responseJSON {
            response in
            // If the response is successful
            if response.result.isSuccess{
                // Prints that the data was pulled to the console
                print("Success, got the weather data")
                
                // Saves the data to a JSON object
                let weatherJSON : JSON = JSON(response.result.value!)
                
                // Calls function for current class
                self.updateWeatherData(json: weatherJSON)
                
            } else {
                print("There is an error: \(response.result.error!)")
                // Sets the city label to show connection issues
                self.weatherLabel.text = "Connection Issues"
            }
        }
    }
    
    func updateWeatherData(json : JSON){
        // saves the values of the json data to variables
        if let tempResult = json["main"]["temp"].double {
            // Sets the temperature for the data model to be the temperature from the json data in farenheight
            weatherLabel.text = weatherInterprater.hoodieCheck(temp: Int(((tempResult - 273.15) * (9/5)) + 32))
            
        } else {
            weatherLabel.text = "There was a problem getting the weather data"
        }
        
    }


    @IBAction func getWeather(_ sender: Any) {
        // Looks for gps location of current iphone in the background (async)
        locationManager.startUpdatingLocation()
    }
    
    
    
    // when location is retrieved
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        // If the horizontal Accuracy is more than zero represents a valid radius for the location
        if location.horizontalAccuracy > 0 {
            // stops the location updating because a valid result is gathered
            locationManager.stopUpdatingLocation()
            // Saves the long and lat to a dictionary
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url : WEATHER_URL, parameters: params)
        }
    }
    
    
    // Tells location manager when location cannot be grabbed
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        // Tells the user location can not be grabbed
    }
}

