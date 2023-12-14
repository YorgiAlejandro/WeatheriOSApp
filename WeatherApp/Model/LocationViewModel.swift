//
//  LocationViewModel.swift
//  SwiftUIIntermediate
//
//  Created by Yorgi Del Rio on 10/18/23.
//  Aqui vamos a obtener los datos de longitud y latitud del usuario

import Foundation
import CoreLocation //Framework de geolocalizacion
import MapKit



final class LocationViewModel : NSObject, ObservableObject{
    private struct DefaultRegion { //Struct de la ubicacion por defecto
        static let latitude = 9.9333
        static let longitude = -84.0833
    }
    private struct Span { //Struct del Span del mapa
        static let delta = 0.1
    }
    
    //Variables publicas:
    @Published var userHasLocation: Bool = false
    @Published var userLocation: MKCoordinateRegion = .init()
    
    //Variable de manejador de localizacion
    private let locationManager: CLLocationManager = .init()
    
    //Aqui vamos a sobreescribir caracteristias de locationManager
    override init() {
        super.init() //Es para poder inicializar propiedades desde uns subclase
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //Aqui le decimos que tenga la mejor precision
        locationManager.requestWhenInUseAuthorization() //Pedir la localizacion mientras la app esta en uso
        locationManager.startUpdatingLocation() //Empezar a recibir actualizaciones de la localizacion
        locationManager.delegate = self  //Esto es para que el LocationViewModel se encargue de las actualizaciones de localizacion
        userLocation = .init(center: .init(latitude: DefaultRegion.latitude, longitude: DefaultRegion.longitude), span: .init(latitudeDelta: Span.delta, longitudeDelta: Span.delta)) //Aqui estamos inicializando la localizacino con esta que es por default, si el usuario da su permiso esta location es actualizada con la mas reciente
    }
    
    //Vamos a chequear si el usuario da permiso a la ubicacion o no
    func checkUserAuthorization () {
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined, .restricted, .denied:
            userHasLocation = false
        case .authorizedAlways, .authorizedWhenInUse:
            userHasLocation = true
        @unknown default :
            print("Unhandled state")
        }
    }
}

extension LocationViewModel: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return} //Aqui le decimos que actualice la variable location con la ultima actualizacion siempre
        userLocation = .init(center: location.coordinate, span: .init(latitudeDelta: Span.delta, longitudeDelta: Span.delta)) //Aqui estamos diciendo que la locaization que se va a mostrar es la que se guardo como ultima ubicacion y que el span es el de la clase Span
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) { //Aqui obtenemos los cambios en el permiso de la ubicacion, si se detecta entonces llama a la funcion que va a configurar en true o false a userHasLocation
        checkUserAuthorization()
    }
    
    
}

