//
//  BookingView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//


import SwiftUI

struct BookingView: View {
    @StateObject var dashBoardVM = ViewModelGetDoctorDashboard()
//    @ObservedObject var getDoctorProfileVM = ViewModelGetDoctorProfile()
    @State private var image = UIImage()
    @State private var radius: CGFloat = .zero
    @State var loginAgain = false
    var language = LocalizationService.shared.language

    var columns = Array(repeating: GridItem(.fixed(120), spacing: 40), count: 2)
    var body: some View {
        ZStack{
        Text("Booking")
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .ignoresSafeArea()
        .background(Color("CLVBG"))
    }
}

struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()

        }
}
