//
//  ScheduleCellView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 18/04/2022.
//

import SwiftUI
struct ScheduleCellView: View {
    var language = LocalizationService.shared.language
    @EnvironmentObject var scheduleVM : ViewModelGetAppointmentInfo

    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false){
              
                VStack(spacing:0){
                    ForEach( 0..<(scheduleVM.publishedDoctorCreatedModel.count ), id:\.self) { index in
                        ScheduleEachCellView(schedule: scheduleVM.publishedDoctorCreatedModel[index]).environmentObject(scheduleVM)
                            .padding(.bottom,20)
                            }
                        }
                

                    }
            
            if scheduleVM.noschedules == true{
                Text("Sorry,\nNo_Scheduales_Found_🤷‍♂️".localized(language))
                    .multilineTextAlignment(.center)
                .frame(width:UIScreen.main.bounds.width-40,alignment:.center)
                
            }
            
                    
        }

        }
}

struct ScheduleCellView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleCellView()
    }
}
