//
//  PickLocationView.swift
//  SalamTech-DR
//
//  Created by Mohamed Hammam agency on 1/25/22.
//

import SwiftUI
import CoreLocation

struct PickLocationView: View {
    @StateObject var locationViewModel = LocationViewModel()
        
        var body: some View {
            switch locationViewModel.authorizationStatus {
            case .notDetermined:
                AnyView(RequestLocationView())
                    .environmentObject(locationViewModel)
            case .restricted:
                ErrorView(errorText: "Location use is restricted.")
            case .denied:
                ErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
            case .authorizedAlways, .authorizedWhenInUse:
                TrackingView()
                    .environmentObject(locationViewModel)
            default:
                Text("Unexpected status")
            }
        }
}
struct RequestLocationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    @StateObject var clinicLocation = ViewModelCreatePatientProfile()
//    @Binding var longtiude: String
//    @Binding var latitiude: String
    var body: some View {
        VStack {
            Button(action: {
                locationViewModel.requestPermission()
                self.clinicLocation.Longitude = coordinate?.longitude ?? 0.0
                self.clinicLocation.Latitude = coordinate?.latitude ?? 0.0
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
    @ObservedObject var clinicLocation = ViewModelCreatePatientProfile()
    let screenWidth = UIScreen.main.bounds.size.width - 50
    
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


struct PickLocationView_Previews: PreviewProvider {
    static var previews: some View {
        PickLocationView()
    }
}

