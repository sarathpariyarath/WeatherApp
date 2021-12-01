

import UIKit

class WeatherViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchTextField.delegate = self
    }

    @IBAction func searchPressed(_ sender: Any) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //use textfield.text to get weather of the city
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            searchTextField.placeholder = "Enter city name"
            return false
        }
    }
    
}

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel) {
        print(weather.cityName)
        let icon = weather.conditionName
        print(icon)
        DispatchQueue.main.async {
            self.cityLabel.text = "📍 \(weather.cityName)"
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: icon)
        }
    }
    func errorHappened(error: Bool) {
        if error {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Alert", message: "City not found", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            
        }
    }
    
    
}
