//
//  ScheduleCellView.swift
//  SalamTak
//
//  Created by wecancity on 05/02/2023.
//

import SwiftUI
struct ScheduleCellView: View {
    var language = LocalizationService.shared.language
    @EnvironmentObject var scheduleVM : ViewModelGetAppointmentInfo
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false){
                
                VStack(spacing:10){
                    ForEach($scheduleVM.AppointmentsArr , id:\.self) { index in
                        ScheduleEachCellView(schedule:index).environmentObject(scheduleVM)
                            .padding(.horizontal)
                    }
                }.padding(.vertical,20)
            }

            if scheduleVM.noschedules == true{
                Text("Sorry,\nNo_Scheduales_Found_🤷‍♂️".localized(language))
                    .multilineTextAlignment(.center)
                    .frame(width:UIScreen.main.bounds.width-40,alignment:.center)
            }
            else if !Helper.userExist() {
                Text("Sorry,\nYou_have_to_login_🤷‍♂️".localized(language))
                    .multilineTextAlignment(.center)
                    .frame(width:UIScreen.main.bounds.width-40,alignment:.center)
            }
            else if scheduleVM.activeAlert == .unauthorized {
                Text("Sorry,\nYou_have_to_login_again_🤷‍♂️".localized(language))
                    .multilineTextAlignment(.center)
                    .frame(width:UIScreen.main.bounds.width-40,alignment:.center)
                
            }
        }
        
    }
}

struct ScheduleCellView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleCellView().environmentObject(ViewModelGetAppointmentInfo())
    }
}
