//
//  ViewSummary.swift
//  SalamTech
//
//  Created by wecancity on 17/04/2022.
//


import SwiftUI

struct ViewSummary:View{
    var Doctor:Doc

    var body: some View{
//        NavigationView{

        ZStack{
            VStack{


                

//                        ViewDocCell(Doctor: Doctor,searchDoc: searchDoc,gotodoctorDetails:$gotodoctorDetails,SelectedDoctor:$SelectedDoctor )
                        
                    
                    
                    
                
              
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width)
            .edgesIgnoringSafeArea(.vertical)
            .background(Color("CLVBG"))
            
            
            VStack{
                AppBarView(Title: "Summary")
                    .navigationBarItems(leading: BackButtonView())
                    .navigationBarBackButtonHidden(true)
                Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)
            
        }
            .edgesIgnoringSafeArea(.top)
            .onAppear(perform: {
                setWeekView()
                let now = convertDateToLocalTime(Date())

                let startWeek = convertDateToLocalTime(now.startOfWeek!)
                let endWeek = convertDateToLocalTime(now.endOfWeek!)
                
                
                print("Local time is: \(now)")
                
                print("Start of week is: \(startWeek)")
                print("End of week is: \(endWeek)")
                
                print("Month : \(CalendarHelper().monthString(date: selectedDate))  \(CalendarHelper().yearString(date: selectedDate) )")
                print(" week :")
                for dayyy  in totalSquares{
                    print(dayyy)
                }


            })
        
        
//     }
        
     // go to clinic info
//        NavigationLink(destination:SpecialityView(),isActive: $gotoSpec) {
//             }
//     .navigationBarHidden(true)
//     .navigationBarBackButtonHidden(true)

        
    }
    
    


    
}

struct ViewSummary_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ViewSummary(Doctor: Doc.init())
        }.navigationBarHidden(true)
    }
}

