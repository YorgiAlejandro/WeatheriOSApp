import Foundation

final class WeatherViewModel: ObservableObject {
    
    @Published var weatherModel: WeatherModel = .empty
    private let weatherModelMapper: WeatherModelMapper = WeatherModelMapper()
    
    //Funcion de obtener la info de la API
    func getWeather(name: String) async {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=69b4376555355a4b2aeb144680e23ce0&units=metric&lang=es")!
        
        do{
            //Aqui obtenemos la data de la API
            async let (data, _) = try await URLSession.shared.data(from: url)
            //Aqui mapeamos la data de la Api solicitando solo la que se pide en ResponseDataModel
            let dataModel = try await JSONDecoder().decode(ResponseDataModel.self, from: data)
            
            //Esta funcion cambia del hilo de ejecucion de la Funcion al hilo main que es el principal o sea ejecuta la class
            DispatchQueue.main.async {
                self.weatherModel = self.weatherModelMapper.mapDataModelToModel(dataModel: dataModel) //Aqui estamos rellenando weatherModel(que es una instancia de WeatherModel) ya con los datos mapeados de ResponseDataModel
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
