
//  GeocodificacionInversa: se usa para a traves de una latitud y longitud obtener el nombre de la ubicacion que le corresponde

import Foundation
import MapKit

func reverseGeocodeLocation(latitude: Double, longitude: Double, completion: @escaping (String?) -> Void) {
    let location = CLLocation(latitude: latitude, longitude: longitude)
    let geocoder = CLGeocoder()
    
    geocoder.reverseGeocodeLocation(location) { placemarks, error in
        guard let placemark = placemarks?.first, error == nil else {
            completion(nil)
            return
        }
        
        if let city = placemark.locality {
            completion(city)
        } else {
            completion(placemark.name)
        }
    }
}

