//
//  ScheduleCellView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 18/04/2022.
//

import SwiftUI

struct ScheduleCellView: View {
    var language = LocalizationService.shared.language

    @StateObject var scheduleVM = ViewModelGetAppointmentInfo()
    @Binding var medicalTypeId:Int
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false){
              
                VStack(spacing:0){
                    ForEach( 0..<(scheduleVM.publishedDoctorCreatedModel.count ), id:\.self) { index in
                        ScheduleEachCellView(schedule: scheduleVM.publishedDoctorCreatedModel[index])
                            .padding(.bottom,20)
                            }
                        }.onAppear(perform: {
                            scheduleVM.isLoading=true
                            scheduleVM.startFetchAppointmentInfo(medicalTypeId: medicalTypeId)
                            print("MOdellll")
                            print(scheduleVM.publishedDoctorCreatedModel)
                        })
                

                    }
            
            if scheduleVM.noschedules == true{
                Text("Sorry,\nNo_Scheduales_Found_🤷‍♂️".localized(language))
                    .multilineTextAlignment(.center)
                .frame(width:UIScreen.main.bounds.width-40,alignment:.center)
                
            }
            
            
            // showing loading indicator
            ActivityIndicatorView(isPresented: $scheduleVM.isLoading)

            // Alert with no internet connection
                .alert(isPresented: $scheduleVM.isNetworkError, content: {
                    Alert(title: Text("Check_Your_Internet_Connection".localized(language)), message: nil, dismissButton: .cancel())
            })
        }
        
        }
}

struct ScheduleCellView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleCellView( medicalTypeId: .constant(1))
    }
}
