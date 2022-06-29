//
//  PickLocationView.swift
//  SalamTech-DR
//
//  Created by Mohamed Hammam agency on 1/25/22.
//

import SwiftUI
import CoreLocation

struct PickLocationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    @Binding var longtiude: Double
    @Binding var latitiude: Double

    
        var body: some View {
            switch locationViewModel.authorizationStatus {
            case .notDetermined:
//                AnyView(RequestLocationView(longtiude: $longtiude, latitiude: $latitiude))
//                    .environmentObject(locationViewModel)

                TrackingView(longtiude: $longtiude, latitiude: $latitiude)
                    .environmentObject(locationViewModel)

            case .restricted:
                ErrorView(errorText: "Location use is restricted.")
            case .denied:
                ErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
            case .authorizedAlways, .authorizedWhenInUse:
                TrackingView(longtiude: $longtiude, latitiude: $latitiude)
                    .environmentObject(locationViewModel)
            default:
                Text("Unexpected status")
            }
        }
}
struct PickLocationView_Previews: PreviewProvider {
    static var previews: some View {
        PickLocationView( longtiude: .constant(0.0), latitiude: .constant(0.0))
            .environmentObject(LocationViewModel())

    }
}

struct RequestLocationView_Previews: PreviewProvider {
    static var previews: some View {
        RequestLocationView( longtiude: .constant(0.0), latitiude: .constant(0.0))
            .environmentObject(LocationViewModel())

    }
}
struct RequestLocationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    @Binding var longtiude: Double
    @Binding var latitiude: Double
    var body: some View {
        VStack {
            Button(action: {
                locationViewModel.requestPermission()
                self.longtiude = coordinate?.longitude ?? 0.0
                self.latitiude = coordinate?.latitude ?? 0.0
            }, label: {
                Label("Pick Location", systemImage: "location")
            })
            .padding(10)
            .foregroundColor(.white)
            .background(Color("blueColor"))
            .clipShape(RoundedRectangle(cornerRadius: 8))            
        }
    }
    var coordinate: CLLocationCoordinate2D? {
        locationViewModel.lastSeenLocation?.coordinate
    }
}


struct ErrorView: View {
    var errorText: String
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                    .resizable()
                .frame(width: 100, height: 100, alignment: .center)
            Text(errorText)
        }
        .padding()
        .foregroundColor(.white)
        .background(Color.red)
    }
}

struct TrackingView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    let screenWidth = UIScreen.main.bounds.size.width - 50
    @Binding var longtiude: Double
    @Binding var latitiude: Double
    
    var body: some View {
        VStack{
            HStack{
                Text( Helper.getUserAddress())
                Spacer()
                Image(systemName: "location")
                    .foregroundColor(Color("lightGray"))
            }
            .frame(width: screenWidth, height: 30)
            .font(.system(size: 13))
            .padding(12)
            .disableAutocorrection(true)
            .background(
                Color.white
            ).foregroundColor(Color("blueColor"))
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.099), radius: 3)
        }
        .onChange(of: longtiude){newval in
            getAddressFromLatLon(pdblLatitude: "\(latitiude)", withLongitude: "\(newval)")
        }
        .onChange(of: latitiude){newval in
            getAddressFromLatLon(pdblLatitude: "\(newval)", withLongitude: "\(longtiude)")
        }
    }
    
    var coordinate: CLLocationCoordinate2D? {
        locationViewModel.lastSeenLocation?.coordinate
    }
}
struct PairView: View {
    let leftText: String
    let rightText: String
    
    var body: some View {
        HStack {
            Text(leftText)
            Spacer()
            Text(rightText)
        }
    }
}

func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

    ceo.reverseGeocodeLocation(loc) { placemarks, error in
     
                        if (error != nil)
                        {
                            print("reverse geodcode fail: \(error!.localizedDescription)")
                        }
        
                         let pm = placemarks! as [CLPlacemark]
        
                        if pm.count > 0 {
                            let pm = placemarks![0]
        
                            var addressString : String = ""
                            if pm.subLocality != nil {
                                addressString = addressString + pm.subLocality! + ", "
                            }
                            if pm.thoroughfare != nil {
                                addressString = addressString + pm.thoroughfare! + ", "
                            }
                            if pm.locality != nil {
                                addressString = addressString + pm.locality! + ", "
                            }
                            if pm.country != nil {
                                addressString = addressString + pm.country! + ", "
                            }
                            if pm.postalCode != nil {
                                addressString = addressString + pm.postalCode! + " "
                            }
                            print(addressString)
                            Helper.setUseraddress(CurrentAddress: addressString)
                      }

        
    }

    
    
    
//        ceo.reverseGeocodeLocation(loc, completionHandler:
//            {(placemarks, error) in
//                if (error != nil)
//                {
//                    print("reverse geodcode fail: \(error!.localizedDescription)")
//                }
//
//
//                 let pm = placemarks! as [CLPlacemark]
//
//                if pm.count > 0 {
//                    let pm = placemarks![0]
//
//                    var addressString : String = ""
//                    if pm.subLocality != nil {
//                        addressString = addressString + pm.subLocality! + ", "
//                    }
//                    if pm.thoroughfare != nil {
//                        addressString = addressString + pm.thoroughfare! + ", "
//                    }
//                    if pm.locality != nil {
//                        addressString = addressString + pm.locality! + ", "
//                    }
//                    if pm.country != nil {
//                        addressString = addressString + pm.country! + ", "
//                    }
//                    if pm.postalCode != nil {
//                        addressString = addressString + pm.postalCode! + " "
//                    }
//                    print(addressString)
//                    Helper.setUseraddress(CurrentAddress: addressString)
//              }

//        })
    }
