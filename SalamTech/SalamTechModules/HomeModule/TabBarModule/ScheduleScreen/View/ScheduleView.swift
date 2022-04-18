//
//  ScheduleView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//

import SwiftUI

struct ScheduleView: View {
    var language = LocalizationService.shared.language
    @StateObject var medicalType = ViewModelExaminationTypeId()
    @State var index = 1
    var body: some View {
        ZStack{
            VStack{
                ZStack {
                    ZStack {
                        Image("underappbar")
                            .resizable()
                            .frame(height: 150)
                            .padding(.bottom, -40)
                        
                       
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack( spacing: 20){
                                ForEach(medicalType.publishedModelExaminationTypeId){ type in
                                    Button(action: {
                                    
                                    withAnimation{
                                        self.index = type.id ?? 1
                                        print(index)
                                    }
                                    }, label: {
                                    HStack(alignment: .center){
                                        Text(type.Name ?? "")
                                            .font(.system(size: 15))
                                            .foregroundColor(self.index == type.id ? Color("blueColor") : Color("lightGray"))
                                        
                                    }
                                    .padding(10)
                                    .padding(.bottom,1)
                                    .frame(width: 110, height: 30)
                                    .background( Color(self.index == type.id ? "tabText" : "lightGray").opacity(self.index == type.id  ? 1 : 0.3)
                                                    .cornerRadius(3))
                                    .clipShape(Rectangle())
                                    })
                                }

                                
                                
                            }.frame( height: 80, alignment: .center)
                                .padding()
                                .offset(y: 25)
                        
                        }
                            
                        
                        
                    }.offset(y: 80)
                    AppBarView(Title:"Schedule")
                        .offset(y:-10)
                }
                Spacer().frame(height: 90)
                TabView (selection: self.$index){
                    ZStack{
                        ScheduleCellView(medicalTypeId: $index)
                    }
                    .padding(15)
                    .tag(1)
                    ZStack{
                        ScheduleCellView(medicalTypeId: $index)
                    }
                    .padding(15)
                    .tag(2)
                    ZStack{
                        ScheduleCellView(medicalTypeId: $index)
                    }
                    .padding(15)
                    .tag(3)
                    ZStack{
                        ScheduleCellView(medicalTypeId: $index)
                    }
                    .padding(15)
                    .tag(4)
                    ZStack{
                        ScheduleCellView(medicalTypeId: $index)
                    }
                    .padding(15)
                    .tag(5)
                    
//                    ZStack{
//                        UpdateMedicalStateView()
//                    }
//                    .padding(15)
//                    .tag(1)
//                    UpdateLegalDocView()
//                        .tag(2)
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
               
            }
            .edgesIgnoringSafeArea(.bottom)
            .ignoresSafeArea()
            .background(Color("CLVBG"))
           
           
        }
       
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:  BackButtonView())
        
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
