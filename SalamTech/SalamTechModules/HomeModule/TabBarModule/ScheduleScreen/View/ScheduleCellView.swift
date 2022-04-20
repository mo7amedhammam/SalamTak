//
//  ScheduleCellView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 18/04/2022.
//

import SwiftUI

struct ScheduleCellView: View {
    @StateObject var scheduleVM = ViewModelGetAppointmentInfo()
    @Binding var medicalTypeId:Int
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                        ForEach( 0..<(scheduleVM.publishedDoctorCreatedModel.count ?? 0 ), id:\.self) { index in
                            ScheduleEachCellView(schedule: scheduleVM.publishedDoctorCreatedModel[index])
                        }
                    }.onAppear(perform: {
                        scheduleVM.startFetchAppointmentInfo(medicalTypeId: medicalTypeId)
                        print("MOdellll")
                        print(scheduleVM.publishedDoctorCreatedModel)
                    })
                }
        }
}

struct ScheduleCellView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleCellView( medicalTypeId: .constant(1))
    }
}
