//
//  AreaView.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 09/04/2022.
//
import SwiftUI

struct AreaView: View {
    @StateObject var AreasVM = ViewModelGetAreas()
    
    var language = LocalizationService.shared.language
    @Binding var selectedCityId : Int
    @Binding var selectedCityName : String

    @Binding var SelectedSpeciality : Int
    @Binding var SelectedSpecialityName : String

    @Binding var examinationTypeId : Int
    
    @State var gotoSearchdoctor = false
    @State var selectedAreaId = 0
    @State var selectedAreaName = ""

    var body: some View {
        ZStack{
            VStack{
                ScrollView( showsIndicators: false){
                    Spacer().frame(height:120)
                    HStack {
                        Text("Choose_your_Area".localized(language))
                            .font(Font.SalamtechFonts.Bold18)
                        Spacer()
                    }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    
                    Button(action: {
                        selectedAreaId = 0
                        selectedAreaName = "All_Areas".localized(language)
                        gotoSearchdoctor=true
                    }, label: {
                        ZStack {
                            HStack{
                                Spacer().frame(width:30)
                                Text("All_Areas".localized(language))
                                    .frame(height:35)
                                    .font(Font.SalamtechFonts.Reg18)
                                    .foregroundColor(.black)
                                Spacer()
                            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            
                                .frame(width: (UIScreen.main.bounds.width)-33, height: 50)
                                .background(Color.white)
                                .cornerRadius(25)
                                .shadow(color: .black.opacity(0.099), radius: 5)
                        }
                    }) .frame(width: (UIScreen.main.bounds.width)-10)
                        .background(Color.clear)
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.099), radius: 5)
                    
                    ForEach(AreasVM.publishedAreaModel , id:\.self){ city in
                        Button(action: {
                            selectedAreaId =  city.id ?? 454545454
                            selectedAreaName = city.Name ?? ""
                            gotoSearchdoctor = true
                        }, label: {
                            ZStack {
                                HStack{
                                    Spacer().frame(width:30)
                                    Text(city.Name ?? "")
                                        .frame(height:35)
                                        .font(Font.SalamtechFonts.Reg18)
                                        .foregroundColor(.black)
                                    Spacer()
                                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                
                                    .frame(width: (UIScreen.main.bounds.width)-33, height: 50)
                                    .background(Color.white)
                                    .cornerRadius(25)
                                    .shadow(color: .black.opacity(0.099), radius: 5)
                            }
                        }) .frame(width: (UIScreen.main.bounds.width)-10)
                            .background(Color.clear)
                            .cornerRadius(8)
                            .shadow(color: .black.opacity(0.099), radius: 5)
                    }
                }.background(Color.clear)
                    .padding([.horizontal])
                Spacer()
            }
            
            .frame(width: UIScreen.main.bounds.width)
            .edgesIgnoringSafeArea(.vertical)
            .background(Color("CLVBG"))
            
            VStack{
                AppBarView(Title: "Choose_Area".localized(language))
                    .navigationBarItems(leading: BackButtonView())
                    .navigationBarBackButtonHidden(true)
                Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)
            // showing loading indicator
            ActivityIndicatorView(isPresented: $AreasVM.isLoading)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: {
            AreasVM.cityId = selectedCityId
            AreasVM.startFetchAreas()
        })
        
        //  go to clinic info
        NavigationLink(destination:ViewSearchDoc(ExTpe: $examinationTypeId, SpecialistId: $SelectedSpeciality,SpecialistName:$SelectedSpecialityName, CityId: $selectedCityId,CityName: $selectedCityName, AreaId: $selectedAreaId,AreaName: $selectedAreaName),isActive: $gotoSearchdoctor) {
        }
        
        // Alert with no internet connection
        .alert(isPresented: $AreasVM.isAlert, content: {
            Alert(title: Text(AreasVM.message), message: nil, dismissButton: .cancel())
        })
        
    }
}

struct AreaView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AreaView( selectedCityId: .constant(48455151), selectedCityName: .constant(""), SelectedSpeciality: .constant(48455151),SelectedSpecialityName:.constant(""), examinationTypeId: .constant(48455151),  selectedAreaId: 48455151)
        }.navigationBarHidden(true)
    }
}
