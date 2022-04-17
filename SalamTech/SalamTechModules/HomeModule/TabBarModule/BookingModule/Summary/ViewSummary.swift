//
//  ViewSummary.swift
//  SalamTech
//
//  Created by wecancity on 17/04/2022.
//


import SwiftUI

struct ViewSummary:View{
    var Doctor:Doc
    @State var showQuickLogin = false

    var body: some View{
//        NavigationView{

        ZStack{
            VStack{


                

//                        ViewDocCell(Doctor: Doctor,searchDoc: searchDoc,gotodoctorDetails:$gotodoctorDetails,SelectedDoctor:$SelectedDoctor )
                        Spacer()
                    
                ButtonView(text:"Sign in", action: {
                    withAnimation(.easeIn(duration: 0.3)) {
                        showQuickLogin =  true
                    }
                })
                    
             
              
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
            
            
//            if showQuickLogin{
            ConfirmBooking(IsPresented: $showQuickLogin, content: {
                    HStack{
                        VStack() {
                            Text("230")                                .font(.system(size: 18))
//                                .padding(.top)

                            Text("\nEGP")
                                .font(.system(size: 15))
                                .foregroundColor(.black.opacity(0.5))
//                                .padding(.bottom,-10)

                        }.padding(.leading)
                            .padding(.top)
                        Button(action: {
                            // add review
                            showQuickLogin =  true
                        }, label: {
                            HStack {
                                Text("Confirm")
                                    .fontWeight(.semibold)
                                    .font(.title2)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("blueColor"))
            //                .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(12)
                            .padding(.horizontal, 20)
                        })
                    }.padding(.horizontal)
                    
                })
    
//            }
  
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





struct ConfirmBooking <Content: View>: View {

    let content: Content
    var language : Language
      var IsPresented: Binding<Bool>

    init(  IsPresented:Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.language = LocalizationService.shared.language
        self.IsPresented = IsPresented
        self.content = content()
    }

    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                
              
                
                VStack {
                        Capsule()
                            .frame(width: 50, height: 4)
                            .foregroundColor(.gray)
                            .padding(.top ,10)
                            .padding(.bottom,20)
                    
                    VStack {
                        self.content
                    }

                }.background(
                    RoundedRectangle(cornerRadius: 40.0)
                        .foregroundColor(.white)
                        .ignoresSafeArea()
                        .opacity(1.5)
                        .shadow(radius: 15)
                        .frame(width: UIScreen.main.bounds.width)

)

            }

        }
        .frame(width: UIScreen.main.bounds.width)
//        .background(
//            Color.black.opacity(0.3)
//                .blur(radius: 12)
//        )
        .onTapGesture(perform: {
            IsPresented.wrappedValue.toggle()

        })
        
    }
}
