//
//  ViewSearchDoc.swift
//  SalamTech
//
//  Created by wecancity on 05/04/2022.
//

import SwiftUI
import Kingfisher

struct ViewSearchDoc: View {
    @StateObject var medicalType = ViewModelExaminationTypeId()
    @StateObject var searchDoc = VMSearchDoc()
    @Binding var ExTpe:Int
    @Binding var SpecialistId:Int
    @Binding var CityId:Int
    @Binding var AreaId:Int
    
    @State  var isSearch = false
    @State  var searchTxt = ""

    @State private var image = UIImage()
    @State var loginAgain = false
    var language = LocalizationService.shared.language
    //    var CountryId : Int
    @State var index = 1
    
    @State var gotodoctorDetails = false
    @State var selectedCityId = 0
    @State var imgs : [Img] = []
    @State var SelectedDoctor = Doc()

    
    init(ExTpe: Binding<Int>,SpecialistId: Binding<Int> ,CityId: Binding<Int>,AreaId: Binding<Int> ) {
        UITableView.appearance().showsVerticalScrollIndicator = false
        self._ExTpe = ExTpe
        self._SpecialistId = SpecialistId
        self._CityId = CityId
        self._AreaId = AreaId


    }
    func getAllDoctors(){
        
        searchDoc.DoctorName = searchTxt
        searchDoc.SkipCount = 0
        searchDoc.FetchDoctors()
    }
    
    var body: some View {
        ZStack{
            VStack{
                            
                    Spacer().frame(height:100)
                    ZStack {
                        Image("WhiteCurve")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width, height: 120)
                            .padding(.top,-20)
                        
                        SearchBar(PlaceHolder:"Search a doctor... ",text: $searchTxt, isSearch: $isSearch){
                       getAllDoctors()
                        }
                            .shadow(color: .black.opacity(0.2), radius: 15)
                        
                    }
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack( spacing: 10) {
                        // Swipe TabView
                        ForEach(medicalType.publishedModelExaminationTypeId){ type in
                            
                            if type.id==0{ }else{
                                
                                Button(action: {
                                    withAnimation(.default) {
                                        
                                        
                                        self.index = type.id ?? 1
                                        //                                    SchedualVM.serviceId = index
                                        
                                    }
                                    
                                }, label: {
                                    HStack(alignment: .center){
                                        Text(type.Name ?? "")
                                            .font(Font.SalamtechFonts.Reg14)
                                            .foregroundColor(self.index == type.id ? Color("blueColor") : Color("lightGray"))
                                        
                                    }.frame(minWidth: 100, maxWidth: 350)
                                        .padding(10)
                                        .padding(.bottom,1)
                                        .background( Color(self.index == type.id ? "tabText" : "lightGray").opacity(self.index == type.id ? 1 : 0.3)
                                                        .cornerRadius(3))
                                        .clipShape(Rectangle())
                                    
                                    
                                })
                                
                                
                                
                            }
                        }
                    }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    //                        .padding(.top,5)
                        .padding(.horizontal)
                }
                
                List( ){

                    //                LazyVStack(spacing:15){
                    ForEach(searchDoc.publishedModelSearchDoc , id:\.self){ Doctor in
                        ViewDocCell(Doctor: Doctor,searchDoc: searchDoc,gotodoctorDetails:$gotodoctorDetails,SelectedDoctor:$SelectedDoctor )
                    }
                        Image("Line")
                            .resizable()
                            .renderingMode(.original)
                            .tint(.black)
                            .frame( maxHeight: 2)
                            .foregroundColor(.black)
                            .onAppear(perform: {
                                searchDoc.SkipCount += searchDoc.publishedModelSearchDoc.count
                            searchDoc.FetchMoreDoctors()
                        })
                    
                    
                }.refreshable(action: {
                    getAllDoctors()
                })
                .listStyle(.plain)
                .padding(.vertical,0)
                //            .background(Color.red)
//                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width)
            .edgesIgnoringSafeArea(.vertical)
            .background(Color("CLVBG"))
            
            
            VStack{
                AppBarView(Title: "Search a Doctor")
                    .navigationBarItems(leading: BackButtonView())
                    .navigationBarBackButtonHidden(true)
                Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)
            
        }
        .onAppear(perform: {
            searchDoc.MaxResultCount = 3
            index =  ExTpe
            searchDoc.MedicalExaminationTypeId = ExTpe
            searchDoc.SpecialistId = SpecialistId
            getAllDoctors()

        })
        .onChange(of: index){newval in
            self.ExTpe = newval
            searchDoc.MedicalExaminationTypeId = newval
            searchDoc.publishedModelSearchDoc.removeAll()
            getAllDoctors()

        }

        //        }
        //  go to clinic info
        NavigationLink(destination:ViewDocDetails(Doctor:SelectedDoctor, ExType: $ExTpe),isActive: $gotodoctorDetails) {
              }
 
    }
    
}

struct ViewSearchDoc_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ViewSearchDoc(ExTpe: .constant(2), SpecialistId: .constant(2), CityId: .constant(2), AreaId: .constant(2))
        }.navigationBarHidden(true)
    }
}


struct SearchBar: View {
    var PlaceHolder = ""
    @Binding var text: String
    
    @State private var isEditing = false
    @Binding  var isSearch : Bool
    var action: () -> Void

    var body: some View {
        HStack {
            
            TextField(PlaceHolder, text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
                .submitLabel(.search)
                .onSubmit {
                    action()
//                    isSearch = true
//                    isEditing = false
                }
            
//            if text != "" || !text.isEmpty{
//                            Button(action: {
//                                self.isEditing = false
//                                self.text = ""
//                   self.isSearch = false
//            action()

//                     UIApplication.shared.dismissKeyboard()
//                            }) {
//                                Text("Cancel")
//                            }
//                            .padding(.trailing, 10)
//                            .transition(.move(edge: .trailing))
//                            .animation(.default)
//                        }
        }
        
        .overlay(
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 15)
                
                if  text != "" || !text.isEmpty{
                    Button(action: {
                        self.text = ""
                        self.isEditing = false
                        action()

                        UIApplication.shared.dismissKeyboard()
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 15)
                    }
                }
            }
        )
    }
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}


struct ViewTopSection: View {
    
    var Doctor:Doc
    var body: some View {
        HStack{
            
            
            AsyncImage(url: URL(string:   URLs.BaseUrl + "\(Doctor.Image ?? "")" )) { image in

                image.resizable()

            } placeholder: {
                Image("logo")
                    .resizable()
            }
//            .clipShape(Circle())
//            .frame(width: 60, height: 60)
                .scaledToFill()
                .frame(width:70)
                .background(Color.gray)
                .cornerRadius(9)
            
            VStack(alignment:.leading){
                //MARK:  --- Name ---
                HStack{
                    Text("Dr/ ")
                        .foregroundColor(.black.opacity(0.7))
                    Text(Doctor.DoctorName ?? "")
                        .font(Font.SalamtechFonts.Bold18)
                    
                }
                
                //MARK:  --- Seniority  ---
                HStack{
                    Text(Doctor.SeniortyLevelName ?? "")
                        .foregroundColor(.gray.opacity(0.7))
                        .font(Font.SalamtechFonts.Reg14)
                    //                                    Text(".")
                    //                                        .foregroundColor(.gray.opacity(0.8))
                    //                                        .font(Font.system(size:30, design: .serif))
                    //                                        .fontWeight(.bold).offset(y:-8)
                    //                                    Text("Fellow of Surgeons R...")
                    //                                        .foregroundColor(.gray.opacity(0.7))
                    //                                        .font(Font.SalamtechFonts.Reg14)
                }
                
                //MARK:  --- Rate ---
                HStack{
//                    ForEach(0..<5){_ in
//                        Image(systemName: "star.fill") // Imagenames: star || star.fill || star.leadinghalf.filled
//                            .foregroundColor(.yellow)
//                    }
                    StarsView(rating: Float( Doctor.Rate ?? 0))
                    
                    Text("( \(Doctor.NumVisites ?? 0)"+" Patients )")
                        .foregroundColor(.black.opacity(0.7))
                        .font(Font.SalamtechFonts.Reg14)
                }
            }
            
            
            Spacer()
            
        }
        .padding(10)
        .frame(height:115)
    }
}

struct ViewMiddelSection: View {
    var Doctor:Doc
    @State var multiline = true
    var body: some View {
        VStack(spacing:0){
            
            //MARK: --- Speciality & Sub speciality ---
            HStack{
                Image("doc1")
                Text(Doctor.SpecialistName ?? "")
                    .foregroundColor(Color("darkGreen"))
                    .font(Font.SalamtechFonts.Reg14)
                Text(" Specialized in ")
                    .foregroundColor(.secondary)
                    .font(Font.SalamtechFonts.Reg14)
                Text(Doctor.SubSpecialistName?.joined(separator: ", ") ?? "")
                    .foregroundColor(Color("darkGreen"))
                    .font(Font.SalamtechFonts.Reg14)
                    .lineLimit(multiline ? 0:1)
                    .onTapGesture {
                        multiline.toggle()
                    }
                Spacer()
            }.padding(.leading)
            
            
            //MARK: --- Clinic Name & address ---
            HStack{
                Image("doc2")
                Text("\(Doctor.ClinicName  ?? ""): ")
                    .foregroundColor(Color("darkGreen"))
                    .font(Font.SalamtechFonts.Reg14)
                Text("\n        \(Doctor.ClinicAddress ?? "")")
                    .foregroundColor(.secondary)
                    .font(Font.SalamtechFonts.Reg14)
                Spacer()
            }.padding(.leading)
            
            //MARK: --- Fees ---
            HStack{
                Image("doc3")
                Text("Fees:")
                    .foregroundColor(Color("darkGreen"))
                    .font(Font.SalamtechFonts.Reg14)
                Text("\( String( Doctor.FeesFrom ?? 0.0)) to \( String( Doctor.FeesTo ?? 0.0)) EGP (Upon time & date)")
                    .foregroundColor(.secondary)
                    .font(Font.SalamtechFonts.Reg14)
                
                Spacer()
            }.padding(.leading)
            
            //MARK: --- Waiting Time ---
            HStack{
                Image("doc4")
                Text("Waiting Time:")
                    .foregroundColor(Color("darkGreen"))
                    .font(Font.SalamtechFonts.Reg14)
                Text("\(Doctor.WaitingTime ?? 0)" + " Minutes")
                    .foregroundColor(.secondary)
                    .font(Font.SalamtechFonts.Reg14)
                
                Spacer()
            }.padding(.leading)

        
        }
    }
}


struct ViewDocCell: View {
    var Doctor : Doc
    var searchDoc : VMSearchDoc
    @Binding var gotodoctorDetails : Bool
    @Binding var SelectedDoctor : Doc
    
    var body: some View {
        VStack(alignment:.leading){
            
            //MARK: ****** Doc Main info ******
            ViewTopSection(Doctor: Doctor)
            // ******                    ******
            
            
            //MARK: ******* Middel Section ********
            ViewMiddelSection(Doctor: Doctor)
            //MARK: *******       ********
            
            
            Text(" Available \(getAVFDateString(inp:Doctor.AvailableFrom ?? "") ) From \(getAVFTimeString(inp:Doctor.AvailableFrom ?? "")) PM ")
                .frame(width: UIScreen.main.bounds.width - 40, height: 35, alignment: .center)
                .background(Color.gray.opacity(0.3))
                .foregroundColor(.black.opacity(0.7))
                .font(Font.SalamtechFonts.Reg14)
            
            //MARK: --- TypeImage Name & Book bu ---
            HStack{
                Spacer()
                
                ForEach(Doctor.MedicalExamationTypeImage ?? [], id:\.self ){ imge2 in
                    
                    KFImage(URL(string: URLs.BaseUrl + "\(imge2.Image ?? "")"))
                        .resizable()
                    //                                            .clipShape(Circle())
                        .frame(width: 25,height: 25 )
                        .scaledToFit()
                        .cornerRadius(5)
                        .shadow(radius: 4)
                    
                }
                Spacer()
                
                Button(action: {
                    SelectedDoctor = Doctor
                    gotodoctorDetails = true
                }, label: {
                    HStack{
                        Text("Book")
                            .foregroundColor(.white)
                            .font(Font.SalamtechFonts.Bold14)
                    }
                             .padding(.horizontal, 40)
                }
                )
                    .buttonStyle(PlainButtonStyle())

                    .padding(.horizontal,15)
                    .frame( height: 40 )
                    .background(Color("blueColor"))
                    .cornerRadius(8)
                
                Spacer()
                
                
            }
            .padding(.bottom,10)
            
        }
        
        .background(Color.white)
        .cornerRadius(9)
        .shadow(color: .black.opacity(0.1), radius: 9)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}



struct StarsView: View {
  private static let MAX_RATING: Float = 5 // Defines upper limit of the rating
  private static let COLOR = Color.orange // The color of the stars

  let rating: Float
  private let fullCount: Int
  private let emptyCount: Int
  private let halfFullCount: Int

  init(rating: Float) {
    self.rating = rating
    fullCount = Int(rating)
    emptyCount = Int(StarsView.MAX_RATING - rating)
    halfFullCount = (Float(fullCount + emptyCount) < StarsView.MAX_RATING) ? 1 : 0
  }

  var body: some View {
    HStack {
      ForEach(0..<fullCount) { _ in
         self.fullStar
       }
       ForEach(0..<halfFullCount) { _ in
         self.halfFullStar
       }
       ForEach(0..<emptyCount) { _ in
         self.emptyStar
       }
     }
  }

  private var fullStar: some View {
    Image(systemName: "star.fill").foregroundColor(StarsView.COLOR)
  }

  private var halfFullStar: some View {
    Image(systemName: "star.lefthalf.fill").foregroundColor(StarsView.COLOR)
  }

  private var emptyStar: some View {
    Image(systemName: "star").foregroundColor(StarsView.COLOR)
  }
}
