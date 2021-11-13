//
//  WeatherManager.swift
//  
//
//  Created by Sarath P on 13/11/21.
//  
//

import Foundation
import UIKit

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=2a9387890d941adc32e6ca1ced987ddf&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //create URL
        
        if let url = URL(string: urlString) {
            
            //create URL Session
            
            let session = URLSession(configuration: .default)
            
            //Give Session Task
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                 
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            //Start the task
            
            task.resume()
            
        }
        
        
    }
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.name)
            print(decodedData.main.temp)
            print(decodedData.weather[0].description)
        } catch {
            print("Error")
        }
        
    }
}
