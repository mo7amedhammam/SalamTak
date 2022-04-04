//
//  GoogleMapsView.swift
//  SalamTech-DR
//
//  Created by wecancity on 14/03/2022.
//

import GoogleMaps
import MapKit
import SwiftUI
import Foundation
import CoreLocation

struct GoogleMapsView: UIViewRepresentable {
    
//    @StateObject var locationManager = LocationManager()
     @Binding var long:Double
    @Binding var lat:Double
    @StateObject var locationManager1 = LocationManager1()
   
//    var coordinateRegion: MKCoordinateRegion
//    var coordinateRegion: CLLocationCoordinate

    let marker : GMSMarker = GMSMarker()

    /// Creates a `UIView` instance to be presented.
    func makeUIView(context: Self.Context) -> GMSMapView {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
//        let camera = GMSCameraPosition.camera(withLatitude: 12.830700372413512, longitude: 1.9390798732638361, zoom: 8.0)
        let camera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude : lat    , longitude : long  ), zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.animate(to: camera)
        mapView.mapType = .normal
        mapView.delegate = context.coordinator
        
   
        let marker = GMSMarker()
//                    marker.position = CLLocationCoordinate2D(latitude: coordinateRegion.center.latitude , longitude: coordinateRegion.center.longitude )
        marker.position = CLLocationCoordinate2D(latitude:lat  , longitude: long   )
//        marker.appearAnimation = .pop
                    marker.isDraggable = true
                    marker.map = mapView
        
        
        return mapView
    }

   
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        // Creates a marker in the center of the map.
       
    
    }
    
    
    class coordinator:NSObject,GMSMapViewDelegate {
        

        
        var parent : GoogleMapsView
        init(parent1:GoogleMapsView ) {
            parent = parent1
        }
        
            func mapView (_ mapView: GMSMapView, didEndDragging didEndDraggingMarker: GMSMarker) {
                print("Drag ended!")
                print("Update Marker data if stored somewhere.")
                print(didEndDraggingMarker.position.longitude)
                print(didEndDraggingMarker.position.latitude)
                parent.long = didEndDraggingMarker.position.longitude
                parent.lat = didEndDraggingMarker.position.latitude
            
//              print(  getAddressFromLatLon(pdblLatitude: "\(String(didEndDraggingMarker.position.latitude))", withLongitude: "\(String( didEndDraggingMarker.position.longitude))") )
                CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: didEndDraggingMarker.position.longitude  , longitude: didEndDraggingMarker.position.longitude )) { place, err in
                    if err != nil{
                        print(err?.localizedDescription ?? "")
                    }
                    print( place?.first?.name  ?? "Egypt" )
                    print( place?.first?.country  ?? "postalCode")
                    print( place?.first?.subAdministrativeArea  ?? "postalCode")
                    print( place?.first?.locality  ?? "postalCode")
                    print( place?.first?.subLocality  ?? "postalCode")
                    print( place?.first?.thoroughfare  ?? "postalCode")
                    print( place?.first?.subThoroughfare  ?? "postalCode")

                    Helper.removeUserLocation()
                    Helper.setUseraddress(CurrentAddress:"\(place?.first?.subLocality ?? "area" ) , \( place?.first?.country ?? "Egypt")" )
                    Helper.setUserLocation(CurrentLatitude: String(didEndDraggingMarker.position.latitude), CurrentLongtude: String(didEndDraggingMarker.position.longitude))
                }
               

            }
        
        func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
//            print(location.latitude)
//            print(location.longitude)
//            print("helper ended!")
//            print(Helper.getUserLatitude())
//            print(Helper.getUserLongtude())

//            parent.long = location.longitude
//            parent.lat = location.latitude
        }
        
        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//            marker.position = position
//            GMSCameraPosition = position
        }
        
        func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
            
//            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: position.target.latitude  , longitude: position.target.longitude )) { place, err in
//
//                if err != nil{
//                    print(err?.localizedDescription ?? "")
//                }
//
//                print( place?.first?.name ?? place?.first?.country ?? "Egypt" )
//                print( place?.first?.country ?? place?.first?.postalCode ?? "postalCode")
//
//            }
//            parent.lat =  position.target.latitude
//            parent.long = position.target.longitude
        
        }
    }
    
    func makeCoordinator() -> GoogleMapsView.coordinator {
        return GoogleMapsView.coordinator(parent1: self)
    }

}

extension GoogleMapsView{
 func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
 marker.position = coordinate
 }
}


class LocationManager1: NSObject,CLLocationManagerDelegate, ObservableObject {
//code here
    
    @Published var region = MKCoordinateRegion()
    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    
    @Published var longtude :Double?
    @Published var latitude :Double?
    private let manager = CLLocationManager()
    override init() {
            super.init()
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            locations.last.map {
                
                region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
                    span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                )
//                print("current location : \(locations.first?.coordinate.longitude ?? 00012)")
//                print("current location : \($0.coordinate.latitude)")
//                latitude = $0.coordinate.latitude
//                longtude = $0.coordinate.longitude
//                Helper.setUserLocation(CurrentLatitude: String($0.coordinate.latitude), CurrentLongtude: String($0.coordinate.longitude))
            }
        }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        print(#function, statusString)
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        lastLocation = location
//        print(#function, location)
//    }
    
}


//func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String)->String {
//
//  var newaddress = ""
//        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
//        let lat: Double = Double("\(pdblLatitude)")!
//        //21.228124
//        let lon: Double = Double("\(pdblLongitude)")!
//        //72.833770
//        let ceo: CLGeocoder = CLGeocoder()
//        center.latitude = lat
//        center.longitude = lon
//        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
//        ceo.reverseGeocodeLocation(loc, completionHandler:
//                                    {(placemarks, error) in
//            if (error != nil)
//            {
//                print("reverse geodcode fail: \(error!.localizedDescription)")
//            }
//            let pm = placemarks! as [CLPlacemark]
//            if pm.count > 0 {
//                let pm = placemarks![0]
//                var addressString : String = ""
//                if pm.subLocality != nil {
//                    addressString = addressString + pm.subLocality! + ", "
//                }
//                if pm.thoroughfare != nil {
//                    addressString = addressString + pm.thoroughfare! + ", "
//                }
//                if pm.locality != nil {
//                    addressString = addressString + pm.locality! + ", "
//                }
//
//                if pm.postalCode != nil {
//                    addressString = addressString + pm.postalCode! + " "
//                }
//                if pm.country != nil {
//                    addressString = addressString + pm.country! + ", "
//                }
//                if pm.administrativeArea != nil {
//                    addressString = addressString + pm.administrativeArea! + " "
//                }
//                print(addressString)
//                newaddress = addressString
////                self.add = "\(addressString)"
////                self.addressNameLbl.text = addressString
//            }
//        })
//
//    return newaddress
//    }
