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
//    @StateObject var clinicLocation = ViewModelCreatePatientProfile()
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
//    @EnvironmentObject var clinicLocation : ViewModelCreatePatientProfile
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

