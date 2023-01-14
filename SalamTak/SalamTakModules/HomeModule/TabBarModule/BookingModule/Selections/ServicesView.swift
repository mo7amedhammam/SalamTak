//
//  ServicesView.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 04/04/2022.
//

import SwiftUI

struct ServicesView: View {
    @StateObject var medicalType = ViewModelExaminationTypeId()
    @StateObject var searchDoc = VMSearchDoc()
    @EnvironmentObject var environments : EnvironmentsVM
    var language = LocalizationService.shared.language
    var vGridLayout = [ GridItem(.adaptive(minimum: 90), spacing: 20) ]
    @State var gotoSpec = false
    @State var selectedTypeId = 0
    
    var body: some View {
        //        NavigationView {
        ZStack{
            VStack{
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 120, alignment: .center)
                
                ScrollView( showsIndicators: false){
                    AsyncImage(url: URL(string:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR05Cf6YGBs9SAvvEwW22wHVjeLTm9HmVJEWd0KjyiSySHuLDQCH5VVc0wvxtHCJvVOKSY&usqp=CAU" )){image in
                        image.resizable()
                    } placeholder: {
                        Image("logo")
                            .resizable()
                    }
                    .foregroundColor(.black)
                    .frame( height: 115)
                    .cornerRadius(8)
                    .scaledToFit()
                    Spacer().frame(height:20)
                    
                    Group {
                        HStack {
                            Text("Our_Services".localized(language))
                                .foregroundColor(.salamtackBlue)
                                .font(.salamtakBold(of: 20))
                            Spacer()
                        }
                        .frame(height:33)
                        
                        LazyVGrid(columns: vGridLayout){
                            ForEach((medicalType.publishedModelExaminationTypeId).dropLast((medicalType.publishedModelExaminationTypeId).count % 3), id:\.self) { exType in
                                ZStack {
                                    Button(action: {
                                        searchDoc.MedicalExaminationTypeId = exType.id ?? 0
                                        selectedTypeId = exType.id ?? 11212121212121
                                        gotoSpec=true
                                    }, label: {
                                        VStack(spacing:0){
                                            remoteAsyncImage(imageUrl: exType.image ?? "")
                                                .frame(width: 60, height: 60)
                                                .padding()
                                                .AddBlueBorder()
                                            
                                            Text(exType.Name?.firstWord ?? "")
                                                .foregroundColor(.salamtackBlue)
                                                .font(.salamtakBold(of: 18))
                                        }
                                    })
                                        .frame(width: (UIScreen.main.bounds.width/3)-20, height: 120)
                                        .disabled(exType.Inactive ?? false)
                                }.overlay(content: {
                                    if  (exType.Inactive ?? false){
                                        Color.white.opacity(0.2)
                                    }
                                })
                            }
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            ForEach((medicalType.publishedModelExaminationTypeId).suffix((medicalType.publishedModelExaminationTypeId).count % 3), id:\.self) { exType in
                                ZStack {
                                    Button(action: {
                                        selectedTypeId = exType.id ?? 11212121212121
                                        searchDoc.MedicalExaminationTypeId = exType.id ?? 0
                                        gotoSpec=true
                                    }, label: {
                                        VStack(spacing:0){
                                            remoteAsyncImage(imageUrl: exType.image ?? "")
                                                .frame(width: 60, height: 60)
                                                .padding()
                                                .AddBlueBorder()
                                            
                                            Text(exType.Name?.firstWord ?? "")
                                                .foregroundColor(.salamtackBlue)
                                                .font(.salamtakBold(of: 18))
                                        }
                                    })
                                        .frame(width: (UIScreen.main.bounds.width/3)-20, height: 120)
                                        .disabled(exType.Inactive ?? false)
                                }.overlay(content: {
                                    if  (exType.Inactive ?? false){
                                        Color.white.opacity(0.2)
                                    }
                                })
                            }
                        }
                    }
                    
                    //MARK:  ---- Medical servises Directory ----
                    Group {
                        HStack {
                            Text("Our_Services_Directory".localized(language))
                                .foregroundColor(.salamtackBlue)
                                .font(.salamtakBold(of: 20))
                            //                                    .frame(alignment: .bottom)
                            Spacer()
                        }
                        .frame(height:33)
                        
                        LazyVGrid(columns: vGridLayout){
                            ForEach((medicalType.publishedModelExaminationTypeId).dropLast((medicalType.publishedModelExaminationTypeId).count % 3), id:\.self) { exType in
                                ZStack {
                                    Button(action: {
//                                        selectedTypeId = exType.id ?? 11212121212121
//                                        gotoSpec=true
                                    }, label: {
                                        VStack(spacing:0){
                                            remoteAsyncImage(imageUrl: exType.image ?? "")
                                                .frame(width: 60, height: 60)
                                                .padding()
                                                .AddBlueBorder()
                                            
                                            Text(exType.Name?.firstWord ?? "")
                                            //                                                    .padding(.vertical,10)
                                                .foregroundColor(.salamtackBlue)
                                                .font(.salamtakBold(of: 18))
                                        }
                                    })
                                        .frame(width: (UIScreen.main.bounds.width/3)-20, height: 120)
                                    //                                            .background(Color.white)
                                    //                                            .cornerRadius(8)
                                    //                                            .shadow(color: .black.opacity(0.099), radius: 5)
                                        .disabled(exType.Inactive ?? false)
                                }.overlay(content: {
                                    if  (exType.Inactive ?? false){
                                        Color.white.opacity(0.2)
                                    }
                                })
                            }
                        }
                        .padding(.horizontal)
                        
                        
                        HStack {
                            ForEach((medicalType.publishedModelExaminationTypeId).suffix((medicalType.publishedModelExaminationTypeId).count % 3), id:\.self) { exType in
                                ZStack {
                                    Button(action: {
//                                        selectedTypeId = exType.id ?? 11212121212121
//                                        gotoSpec=true
                                    }, label: {
                                        VStack(spacing:0){
                                            remoteAsyncImage(imageUrl: exType.image ?? "")
                                                .frame(width: 60, height: 60)
                                                .padding()
                                                .AddBlueBorder()
                                            
                                            Text(exType.Name?.firstWord ?? "")
                                            //                                                    .padding(.vertical,10)
                                                .foregroundColor(.salamtackBlue)
                                                .font(.salamtakBold(of: 18))
                                        }
                                    })
                                        .frame(width: (UIScreen.main.bounds.width/3)-20, height: 120)
                                        .disabled(exType.Inactive ?? false)
                                }.overlay(content: {
                                    if  (exType.Inactive ?? false){
                                        Color.white.opacity(0.2)
                                    }
                                })
                            }
                        }
                    }
                }
                .background(Color.clear)
            }
            .padding(.horizontal)
            
            //MARK: ----- Top View Title -----
            ActivityIndicatorView(isPresented: $medicalType.isLoading)
            
            //  go to clinic info
            NavigationLink(destination:SpecialityView( selectedTypeId: $selectedTypeId)
                            .environmentObject(searchDoc)
                            .environmentObject(environments)
                            .navigationBarHidden(true),isActive: $gotoSpec) {
            }
                            .onReceive(navController.popToRoot, perform: {newval in
                                gotoSpec = newval
                            })
        }
        .frame(width: UIScreen.main.bounds.width)
        .edgesIgnoringSafeArea(.top)
        //            .background(Color("CLVBG"))
        .background(
            newBackImage(backgroundcolor: .white, imageName:.image2)
        )
        
        .onAppear(perform: {
//            medicalType.GetExaminationTypeId()
        })
        .onReceive(navController.popToRoot, perform: {newval in
            gotoSpec = newval
        })
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        
        .alert(isPresented: $medicalType.isAlert, content: {
            Alert(title: Text(medicalType.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                medicalType.isAlert = false
            }))
        })
    }
}

struct ServicesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ServicesView()
                .environmentObject(EnvironmentsVM())
        }.navigationBarHidden(true)
    }
}

struct remoteAsyncImage: View {
    var imageUrl = ""
    var body: some View {
        AsyncImage(url: URL(string:   URLs.BaseUrl + "\(imageUrl)" )) { image in
            image.resizable()
                .renderingMode(.template)
                .foregroundColor(.salamtackWelcome)
        } placeholder: {
            Image("logo")
                .resizable()
        }
    }
}



struct BlueBorder: ViewModifier {
    func body(content: Content) -> some View {
        content
//            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .stroke( Color.salamtackBlue, lineWidth: 1.8)
            )
    }
}

extension View{
    func AddBlueBorder() -> some View {
        modifier(BlueBorder())
    }
}
