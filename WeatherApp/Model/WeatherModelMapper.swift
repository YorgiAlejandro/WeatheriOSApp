import Foundation

struct WeatherModelMapper{
    
    func mapDataModelToModel (dataModel: ResponseDataModel) -> WeatherModel{
        guard let weather = dataModel.weather.first else {
            return .empty
        }
        let temperature = dataModel.temperature
        let sunsetWithTimeZone = dataModel.sun.sunset.addingTimeInterval(dataModel.timezone - Double(TimeZone.current.secondsFromGMT()))
        let sunriseWithTimeZone = dataModel.sun.sunrise.addingTimeInterval(dataModel.timezone - Double(TimeZone.current.secondsFromGMT()))
        return WeatherModel(name: dataModel.name, weather: weather.main, description: "(\(weather.description))",
                            iconURL: "http://openweathermap.org/img/wn/\(weather.iconURLString)@2x.png",
                            currentTemperature: "\(Int(temperature.currentTemperature)) ºC",
                            minTemperature: "\(Int(temperature.minTemperature)) ºC Min.",
                            maxTemperature: "\(Int(temperature.maxTemperature)) ºC Max.",
                            humidity: "\(temperature.humidity)%",
                            feelsLike: "\(Int(temperature.feelsLike)) ºC",
                            sunrise: sunriseWithTimeZone,
                            sunset: sunsetWithTimeZone)
    }
}

