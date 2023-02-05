//
//  ServicesView.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 04/04/2022.
//

import SwiftUI


struct ServicesView: View {
    @StateObject var medicalType = ViewModelExaminationTypeId()
    @StateObject var OtherMedicalServices = ViewModelOtherMedicalServices()
    @StateObject var searchDoc = VMSearchDoc()
    @EnvironmentObject var AdsVM : ViewModelSlidingAds
    @State private var currentStep = 0
    @State var VideoLink = "https://www.youtube.com/watch?v=tYBZ8AVH0Q0"
    @State private var isActive: Bool = false

    @EnvironmentObject var environments : EnvironmentsVM
    var language = LocalizationService.shared.language
    var vGridLayout = [ GridItem(.adaptive(minimum: 90), spacing: 20) ]
    @State var gotoSpec = false
    @State var gotoOtherMedical = false
    @State var selectedTypeId = 0
    
    var body: some View {
        //        NavigationView {
        ZStack{
            VStack{
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 120, alignment: .center)
                
                ScrollView( showsIndicators: false){
                    //MARK: -- Ads --
                    if AdsVM.publishedAdsModel.count > 0{
                        TabView(selection: $currentStep) {
                            ForEach(0..<AdsVM.publishedAdsModel.count, id:\.self){ ad in
                                ZStack{
                                    if AdsVM.publishedAdsModel[ad].isVideo ?? false{
                                        LinkView(link: "\(AdsVM.publishedAdsModel[ad].videoLink ?? "")")
                                            .disabled(true)
                                            .onAppear(perform: {
                                                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                                                    VideoLink = "\(AdsVM.publishedAdsModel[ad].videoLink ?? "")"
                                                })
                                            })
                                        //                                        YoutubeVideoView(youtubeVideoID:AdsVM.publishedAdsModel[ad].Link?.youtubeID ?? "")
                                    }else{
                                        AsyncImage(url: URL(string: "\(URLs.BaseUrl)\(AdsVM.publishedAdsModel[ad].videoLink ?? "")")) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width-40, height: 150)
                                .cornerRadius(12)
                                .overlay(
                                    HStack{
                                        Button(action: {
                                            currentStep = currentStep < AdsVM.publishedAdsModel.count-1 ? currentStep + 1 : 0
                                        }, label: {
                                            Image("newleft")
                                                .resizable()
                                                .frame(width:15, height:20)
                                                .scaledToFit()
                                        })
                                        Spacer()
                                        Button(action: {
                                            if AdsVM.publishedAdsModel[ad].isVideo ?? false {
                                                //                                                VideoLink = "\(AdsVM.publishedAdsModel[ad].videoLink ?? "")"
//                                                isTimerRunning = false
                                                isActive.toggle()
                                                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                                                    VideoLink = "\(AdsVM.publishedAdsModel[ad].videoLink ?? "")"
                                                })
                                            }else{
                                                //preview image
                                            }
                                        }, label: {
                                            ZStack{
                                                if AdsVM.publishedAdsModel[ad].isVideo ?? false{
                                                    Image("newyoutubelogo")
                                                        .resizable()
                                                        .frame(width:65, height:55)
                                                }
                                            }.frame(width: 200, height: 150, alignment: .center)
                                        })
                                        Spacer()
                                        Button(action: {
                                            currentStep = currentStep < AdsVM.publishedAdsModel.count-1 ? currentStep + 1 : 0
                                        }, label: {
                                            Image("newright")
                                                .resizable()
                                                .frame(width:15, height:20)
                                                .scaledToFit()
                                        })
                                    }
                                        .frame( height:120)
                                        .padding(.horizontal,10)
                                )
                                .padding(.horizontal)
                                .padding(.top,-20)
                                .tag(ad)
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
//                        .padding(.top,-30)
                        .frame( height: 170)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//                        .onReceive(timer, perform: { _ in
//                            if isTimerRunning{
//                                DispatchQueue.main.async(execute: {
//                                    print("selection is",currentStep)
//                                    currentStep = currentStep < AdsVM.publishedAdsModel.count-1 ? currentStep + 1 : 0
//                                })
//                            }
//                        })
                        
                        .onAppear {
                            Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
//                                    currentStep = currentStep < (ad.getAdImagesDtos?.count ?? 0)-1 ? currentStep + 1 : 0
                                
                                currentStep = (currentStep + 1) % (AdsVM.publishedAdsModel.count )
                            }
                        }
                    }else{
                        //No ads
                    }
                    
//                    Spacer().frame(height:20)
                    
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
                            ForEach((OtherMedicalServices.medicalServises).dropLast((OtherMedicalServices.medicalServises).count % 3), id:\.self) { exType in
                                ZStack {
                                    Button(action: {
                                        OtherMedicalServices.medicalServiseName = exType.Name ?? ""
                                        OtherMedicalServices.medicalServiseId = exType.id ?? 0
                                        gotoOtherMedical=true
                                    }, label: {
                                        VStack(spacing:0){
                                            Image(exType.image ?? "")
//                                            remoteAsyncImage(imageUrl: exType.image ?? "")
                                                .resizable()
                                                .frame(width: 100, height: 100)
//                                                .AddBlueBorder()
                                            
                                            Text("\(exType.Name?.localized(language) ?? "")".firstWord ?? "")
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
                            ForEach((OtherMedicalServices.medicalServises).suffix((OtherMedicalServices.medicalServises).count % 3), id:\.self) { exType in
                                ZStack {
                                    Button(action: {
//                                        selectedTypeId = exType.id ?? 11212121212121
                                        OtherMedicalServices.medicalServiseName = exType.Name ?? ""
                                        OtherMedicalServices.medicalServiseId = exType.id ?? 0

                                        gotoOtherMedical=true

                                    }, label: {
                                        VStack(spacing:0){
//                                            remoteAsyncImage(imageUrl: exType.image ?? "")
                                            Image(exType.image ?? "")
                                                .resizable()
                                                .frame(width: 100, height: 100)
//                                                .AddBlueBorder()
                                            
                                            Text("\(exType.Name?.localized(language) ?? "")".firstWord ?? "")
                                                .multilineTextAlignment(.center)
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
            NavigationLink(destination:SpecialityView(isPresented: .constant(false))
                            .environmentObject(searchDoc)
                            .environmentObject(environments)
                            .environmentObject(AdsVM)
                            .navigationBarHidden(true),isActive: $gotoSpec) {
            }
            
            //  go to clinic info
            NavigationLink(destination:OtherMedicalServicesFilter( isPresented: .constant(false))
                            .environmentObject(OtherMedicalServices)
                            .environmentObject(environments)
                            .environmentObject(AdsVM)
                            .navigationBarHidden(true),isActive: $gotoOtherMedical) {
            }
                            .onReceive(navController.popToRoot, perform: {newval in
                                gotoSpec = newval
                                gotoOtherMedical = newval
                            })
            
                        
            
            
        }
        .sheet(isPresented: $isActive, content: {
            LinkView(link: VideoLink)
                .frame(height:200)
                .onDisappear(perform: {
//                    isTimerRunning.toggle()
                })
        })
        
        .frame(width: UIScreen.main.bounds.width)
        .edgesIgnoringSafeArea(.top)
        //            .background(Color("CLVBG"))
        .background(
            newBackImage(backgroundcolor: .white, imageName:.image2)
        )
        
        .onAppear(perform: {
//            medicalType.GetExaminationTypeId()
            AdsVM.PageID = 1
            AdsVM.GetDashboardAds()
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
    var foregroundColor:Color? = .salamtackWelcome

    var body: some View {
        AsyncImage(url: URL(string:   URLs.BaseUrl + "\(imageUrl)" )) { image in
            image.resizable()
                .renderingMode(.template)
                .foregroundColor(foregroundColor)
        } placeholder: {
            Image("logo")
                .resizable()
        }
    }
}



struct BlueBorder: ViewModifier {
    var cornerRadius:CGFloat?
    var lineWidth:CGFloat?
    var lineColor:Color?

    func body(content: Content) -> some View {
        content
//            .padding()
            .background(
                RoundedRectangle(cornerRadius: cornerRadius ?? 15)
                    .stroke( lineColor ?? .salamtackBlue, lineWidth: lineWidth ?? 1.8)
            )
    }
}

extension View{
    func AddBlueBorder(cornerRadius:CGFloat = 15,linewidth:CGFloat = 1.8, linecolor:Color = .salamtackBlue) -> some View {
        modifier(BlueBorder(cornerRadius: cornerRadius, lineWidth: linewidth,lineColor: linecolor))
    }
}
