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
        VStack{
            VStack{
                HStack{
                    ScrollView(.vertical){
                        VStack{
                            ForEach(scheduleVM.publishedDoctorCreatedModel){ model in
                                
                                VStack{
//                                    
                                }
                                
                            }
                        }
                    }
                }
            }
            VStack{
                HStack{
                    VStack{
                        // Second Row
                    }
                }
            }
            VStack{
                HStack{
                    // Button Row
                }
            }
        }.onAppear(perform: {
            scheduleVM.startFetchAppointmentInfo(medicalTypeId: medicalTypeId)
        })
    }
}

struct ScheduleCellView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleCellView( medicalTypeId: .constant(1))
    }
}
