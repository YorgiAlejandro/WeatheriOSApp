import Foundation

//La idea aqui es que todos los parametros queden al mismo nivel y dar un valor por defecto para evitar nils
struct WeatherModel {
    let name: String
    let weather: String
    let description: String
    let iconURL: String
    let currentTemperature: String
    let minTemperature: String
    let maxTemperature: String
    let humidity: String
    let feelsLike: String
    let sunrise: Date
    let sunset: Date
    
    //Para evitar opcionales vamos a dar valores por defecto asi:
    static let empty: WeatherModel = .init(name: "No city", weather: "No weather", description: "No description", iconURL: "", currentTemperature: "0", minTemperature: "0", maxTemperature: "0", humidity: "0", feelsLike: "0", sunrise: .now, sunset: .now)
}
