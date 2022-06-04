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
                Spacer().frame(height: 20)

                VStack(spacing:10){
                    ForEach( 0..<(scheduleVM.AppointmentsArr.count ), id:\.self) { index in
                        ScheduleEachCellView(schedule: scheduleVM.AppointmentsArr[index]).environmentObject(scheduleVM)
                            .padding(.horizontal)
                            }
                }
                

            }
            
            if scheduleVM.noschedules == true{
                Text("Sorry,\nNo_Scheduales_Found_🤷‍♂️".localized(language))
                    .multilineTextAlignment(.center)
                .frame(width:UIScreen.main.bounds.width-40,alignment:.center)
            }else if !Helper.userExist() {
                Text("Sorry,\nYou_have_to_login_🤷‍♂️".localized(language))
                    .multilineTextAlignment(.center)
                .frame(width:UIScreen.main.bounds.width-40,alignment:.center)
            } else if scheduleVM.activeAlert == .unauthorized {
                Text("Sorry,\nYou_have_to_Login_again_🤷‍♂️".localized(language))
                    .multilineTextAlignment(.center)
                .frame(width:UIScreen.main.bounds.width-40,alignment:.center)

            }
            
                    
        }
//        .frame(width: UIScreen.main.bounds.width)

        }
}

struct ScheduleCellView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleCellView()
    }
}
