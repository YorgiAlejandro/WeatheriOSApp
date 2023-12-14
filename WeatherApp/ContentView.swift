import SwiftUI

struct ContentView: View {
    @StateObject var locationViewModel = LocationViewModel()
    @StateObject var weatherViewModel = WeatherViewModel()
    @State var ubicacion: String = ""
    
    var body: some View {
        ZStack {
            VStack{
                VStack {
                    HStack {
                        Button {
                            Task{
                                    reverseGeocodeLocation(latitude: locationViewModel.userLocation.center.latitude, longitude: locationViewModel.userLocation.center.longitude){ city in
                                        if let city = city {
                                            print("Ciudad más cercana: \(city)")
                                            ubicacion = city
                                        } else {
                                            print("No se encontró la ciudad más cercana.")
                                        }
                                    }
                                    await weatherViewModel.getWeather(name: "\(ubicacion)")
                            }
                        } label: {
                            Image(systemName: "location.fill").resizable().scaledToFit().frame(width: 35).foregroundColor(.white)
                        }
                        TextField("Inserta una ubicación", text: $ubicacion).textFieldStyle(.roundedBorder).frame(width: 250, height: 50)
                        Button {
                            Task {
                                await weatherViewModel.getWeather(name: "\(ubicacion)")
                            }
                        } label: {
                            Image(systemName: "magnifyingglass.circle.fill").resizable().scaledToFit().frame(width: 35).foregroundColor(.white)
                        }
                    }
                    
                    Text(weatherViewModel.weatherModel.name)
                        .foregroundColor(.white)
                        .font(.system(size: 70))
                    Text(weatherViewModel.weatherModel.description)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.bottom, 8 )
                    HStack{
                        if let iconURL = weatherViewModel.weatherModel.iconURL{
                            AsyncImage(url: URL(string: "\(iconURL)")){ image in
                                image
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        Text("\(weatherViewModel.weatherModel.currentTemperature)")
                            .font(.system(size: 70))
                            .foregroundColor(.white)
                    }.padding(.top, -20)
                    Divider().foregroundColor(.white).padding()
                    HStack{
                        Label("\(weatherViewModel.weatherModel.maxTemperature)", systemImage: "thermometer.sun.fill")
                        Label("\(weatherViewModel.weatherModel.minTemperature)", systemImage: "thermometer.snowflake")
                    }
                    .symbolRenderingMode(.multicolor)
                    .foregroundColor(.white)
                    Divider().foregroundColor(.white).padding()
                    
                    
                }
                VStack{
                    HStack{
                        VStack{
                            Image(systemName: "sunrise.fill").symbolRenderingMode(.multicolor)
                            Text(weatherViewModel.weatherModel.sunset, style: .time).bold().padding().foregroundColor(.white)
                        }
                        VStack{
                            Image(systemName: "sunset.fill").symbolRenderingMode(.multicolor)
                            Text(weatherViewModel.weatherModel.sunset, style: .time).bold().padding().foregroundColor(.white)
                        }
                    }
                    
                    HStack{
                        Label("\(weatherViewModel.weatherModel.humidity)", systemImage: "humidity.fill")
                            .symbolRenderingMode(.multicolor)
                            .foregroundColor(.white).padding()
                        Label("\(weatherViewModel.weatherModel.feelsLike)", systemImage: "thermometer")
                            .symbolRenderingMode(.multicolor)
                            .foregroundColor(.white).padding()
                    }
                    
                    Spacer()
                }
                Text("Created by @YorgiAlej").font(.footnote).foregroundColor(.white)
                
            }
            
        }
        .background(
            LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
