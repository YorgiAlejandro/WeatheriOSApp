import Foundation

//Estructura para datos de Api (Aqui agarramos los bloques de la API que necesitamos)
struct ResponseDataModel: Decodable{
    let name: String
    let weather: [WeatherDataModel]
    let temperature: TemperatureDataModel
    let sun: SunModel
    let timezone: Double
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case weather = "weather"
        case temperature = "main"
        case sun = "sys"
        case timezone
    }
}

//Estructura para la hora que sale y se esconde el sol
struct SunModel: Decodable{
    let sunrise: Date
    let sunset: Date
}

//Estructura de la weather info
struct WeatherDataModel: Decodable {
    //caracteristicas que vamos a leer del JSON dentro de weather
    let main: String
    let description: String
    let iconURLString: String //Aqui no coincide los nomobres, hay que asignarlo en un Enum a continuacion
    
    enum CodingKeys: String, CodingKey{//El enum conforma a CodingKey y String
        case main
        case description
        case iconURLString = "icon" //aqui igualamos al nomobre real de el JSON para que no haya conflictos
    }
    
}

//Estructura de la Temperature info
struct  TemperatureDataModel: Decodable {
    let currentTemperature: Double
    let feelsLike: Double
    let minTemperature: Double
    let maxTemperature: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case currentTemperature = "temp"
        case feelsLike = "feels_like"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case humidity
    }
    
}

/*
 {
   "coord": {
     "lon": -76.3036,
     "lat": 3.5394
   },
   "weather": [
     {
       "id": 803,
       "main": "Clouds",
       "description": "muy nuboso",
       "icon": "04d"
     }
   ],
   "base": "stations",
   "main": {
     "temp": 31.71,
     "feels_like": 32.78,
     "temp_min": 28.73,
     "temp_max": 31.71,
     "pressure": 1010,
     "humidity": 45
   },
   "visibility": 10000,
   "wind": {
     "speed": 2.57,
     "deg": 0
   },
   "clouds": {
     "all": 75
   },
   "dt": 1702151843,
   "sys": {
     "type": 1,
     "id": 8590,
     "country": "CO",
     "sunrise": 1702119598,
     "sunset": 1702162516
   },
   "timezone": -18000,
   "id": 3673164,
   "name": "Palmira",
   "cod": 200
 }
 */
