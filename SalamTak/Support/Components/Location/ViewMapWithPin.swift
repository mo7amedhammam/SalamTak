//
//  ViewMapWithPin.swift
//  SalamTech-DR
//
//  Created by wecancity on 09/03/2022.
//


import SwiftUI
import MapKit

struct ViewMapWithPin: View {
    
    @Binding var showmap:Bool
    @State var title:String
    @State var subtitle:String
    @Binding var longtude:Double
    @Binding var latitude:Double
//    @StateObject var patientLocation = ViewModelCreatePatientProfile()
    @EnvironmentObject var locationManager1 : LocationViewModel
    var body: some View {
        
        VStack{
            HStack {
                Spacer()
                Text("long press on pin to drag ")
                Spacer()
                Button(action: {
                    showmap = false
                }, label: {
                    Text("OK").font(.title)
                        .foregroundColor(.blue)
                }).frame(width:50)
                
            }.frame(height:40)
            
            
            ZStack(alignment: .bottom){
                GoogleMapsView(long: $longtude, lat: $latitude).environmentObject(locationManager1)
                
                if self.title != "" {
                    HStack(spacing:20){
                        Image(systemName: "info.circle.fill").font(.largeTitle).foregroundColor(.black)
                        VStack(alignment: .leading, spacing: 8){
                            Text(self.title).font(.body)
                            Text(self.subtitle).font(.caption).foregroundColor(.gray)
                        }
                    }.padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(15)
                }
            }
        }
        
    }
}

struct ViewMapWithPin_Previews: PreviewProvider {
    static var previews: some View {
        ViewMapWithPin(showmap: .constant(false), title: "", subtitle: "",longtude: .constant(30.5624707), latitude:.constant(31.1545537))
    }
}
extension Binding where Value == String {
    public func double() -> Binding<Double> {
        return Binding<Double>(get:{ Double(self.wrappedValue) ?? 121.121 },
                               set: { self.wrappedValue = String($0)})
    }
}


import Combine
import CoreLocation
struct MapView: UIViewRepresentable {
    
    @Binding var Title:String
    @Binding var subTitle:String
    @Binding var longtude : Double
    @Binding var latitude : Double
    
    
    func updateUIView(_ uiView:MKMapView , context:UIViewRepresentableContext<MapView> ){
        
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        
        
        // 1
        let map =  MKMapView()
        map.mapType = MKMapType.satellite // (satellite)
        
        // 2
        let mylocation = CLLocationCoordinate2D(latitude: -6.863190,longitude: -79.818250)
        
        // 3
        let coordinate = CLLocationCoordinate2D(
            latitude: -6.864138, longitude: -79.819634)
        
        
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        map.setRegion(region, animated: true)
        
        // 4
        let annotation = MKPointAnnotation()
        annotation.coordinate = mylocation
        
        
        annotation.title = "My Location"
        annotation.subtitle = "Visit us soon"
        
        map.addAnnotation(annotation)
        map.delegate = context.coordinator
        return map
        
    }
    
    
    class coordinator:NSObject,MKMapViewDelegate {
        var parent : MapView
        init(parent1:MapView ) {
            parent = parent1
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            //            let an = mapView.dequeueReusableAnnotationView(withIdentifier: "pin")
            //            an?.image = UIImage(systemName: "mappin.and.ellipse")
            
            pin.isDraggable = true
            pin.pinTintColor = .red
            pin.animatesDrop = true
            return pin
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
            //            print(view.annotation?.coordinate.longitude ?? 54555554)
            //            print(view.annotation?.coordinate.latitude ?? 51655554)
            
            self.parent.longtude = view.annotation?.coordinate.longitude ?? 4545454
            self.parent.latitude = view.annotation?.coordinate.latitude ??  4545445
            
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: view.annotation?.coordinate.latitude ?? 45644545, longitude: view.annotation?.coordinate.longitude ?? 54555554)) { place, err in
                
                if err != nil{
                    print(err?.localizedDescription ?? "")
                }
                
                self.parent.Title = place?.first?.name ?? place?.first?.country ?? "Egypt"
                self.parent.subTitle = place?.first?.country ?? place?.first?.postalCode ?? "postalCode"
                
            }
            
        }
    }
    
    
    func makeCoordinator() -> MapView.coordinator {
        return MapView.coordinator(parent1: self)
    }
    
}




