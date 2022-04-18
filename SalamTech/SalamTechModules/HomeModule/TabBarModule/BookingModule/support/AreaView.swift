//
//  AreaView.swift
//  SalamTech
//
//  Created by wecancity on 09/04/2022.
//
import SwiftUI


struct AreaView: View {
    @StateObject var AreasVM = ViewModelGetAreas()
    @StateObject var searchDoc = VMSearchDoc()

    @State private var image = UIImage()
    @State var loginAgain = false
    var language = LocalizationService.shared.language
    @Binding var CityId : Int
    @Binding var SelectedSpeciality : Int
    @Binding var extype : Int
    
    @State var gotoSearchdoctor = false
    @State var selectedAreaId = 0

    
    
    var body: some View {
        ZStack{
        VStack{
            ScrollView( showsIndicators: false){
                Spacer().frame(height:120)
                HStack {
                    Text("Choose your Area")
                        .font(Font.SalamtechFonts.Bold18)
                    Spacer()
                }

                Button(action: {
                    selectedAreaId = 0
                    gotoSearchdoctor=true
                }, label: {
                    
                    ZStack {

                        HStack{
                            Spacer().frame(width:30)
                                Text("All Areas")
                                    .frame(height:35)
                                    .font(Font.SalamtechFonts.Reg18)
                                    .foregroundColor(.black)
                            Spacer()
                            }
                            
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
//                                searchDoc.CityId = city.id ?? 5455454545
                                selectedAreaId =  city.id ?? 454545454
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
                                        }
                                        
                                        .frame(width: (UIScreen.main.bounds.width)-33, height: 50)
                                        .background(Color.white)
                                        .cornerRadius(25)
                                        .shadow(color: .black.opacity(0.099), radius: 5)

                                    
//                                    HStack {
//                                        AsyncImage(url: URL(string:   URLs.BaseUrl + "\(specialityvm.publishedSpecialistModel?[speciality].image ?? "")" )) { image in
//
//                                            image.resizable()
//
//                                        } placeholder: {
//                                            Image("heart")
//                                                .resizable()
//                                        }
//                                        .clipShape(Circle())
//                                        .frame(width: 60, height: 60)
//                                        Spacer()
//                                    }.padding(.leading,5)


                                    
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
        .onAppear(perform: {

        })
        
            VStack{
                AppBarView(Title: "Choose Area")
                    .navigationBarItems(leading: BackButtonView())
                    .navigationBarBackButtonHidden(true)
                    Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)

        }.onAppear(perform: {
            AreasVM.startFetchAreas(cityId: CityId )
        })

        
        //  go to clinic info
        NavigationLink(destination:ViewSearchDoc(ExTpe: $extype, SpecialistId: $SelectedSpeciality, CityId: $CityId, AreaId: $selectedAreaId),isActive: $gotoSearchdoctor) {
              }
    }
    

    
}

struct AreaView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AreaView( CityId: .constant(48455151), SelectedSpeciality: .constant(48455151), extype: .constant(48455151),  selectedAreaId: 48455151)
                
                }.navigationBarHidden(true)
    }
}
