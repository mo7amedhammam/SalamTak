//
//  TitleFilterList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 05/06/2022.
//

import Foundation
import SwiftUI
import Combine

struct TitleFilterList:View{
    @EnvironmentObject var seniorityVM : ViewModelSeniority
    
    @Binding var FilterTag:FilterCases
    @Binding var selectedSeniorityLvlName :String?
    @Binding var selectedSeniorityLvlId :Int?
    @Binding var SenbuttonSelected: Int?
    
    var body : some View{
        VStack{
        Text("Title".localized(language))
            .font(.system(size: 18))
            .fontWeight(.bold)
            .frame(width:UIScreen.main.bounds.width)
            .overlay(HStack{
                Spacer()
                Button(action: {
                    FilterTag = .Menu
                }, label: {
                    Image(systemName: "x.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray.opacity(0.6))
                })
            }
                        .padding()
            )
        ScrollView {
            ForEach(0..<seniorityVM.publishedSeniorityLevelModel.count, id:\.self) { button in
                HStack {
                    Spacer().frame(width:30)
                    Button(action: {
                        self.SenbuttonSelected = button
                        self.selectedSeniorityLvlId = self.seniorityVM.publishedSeniorityLevelModel[button].id ?? 0
                        self.selectedSeniorityLvlName = self.seniorityVM.publishedSeniorityLevelModel[button].Name ?? ""
                    }, label: {
                        HStack{
                            Image(systemName:  self.SenbuttonSelected == button ? "checkmark.circle.fill" :"circle" )
                                .font(.system(size: 20))
                                .foregroundColor(self.SenbuttonSelected == button ? Color("blueColor") : Color("lightGray"))
                            Text(self.seniorityVM.publishedSeniorityLevelModel[button].Name ?? "")  .padding()
                                .foregroundColor(self.SenbuttonSelected == button ? Color("blueColor") : Color("lightGray"))
                            Spacer()


                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    })
                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

            }
        }


        Button(action: {
            // add review
            print("Confirm Title")
            FilterTag = .Menu
        }, label: {
            HStack {
                Text("Confirm".localized(language))
                    .fontWeight(.semibold)
                    .font(.title3)
            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color("blueColor"))
                .cornerRadius(12)
                .padding(.horizontal, 12)
        })

            .frame( height: 60)
            .padding(.horizontal)
            .padding(.bottom,10)

        }.onAppear(perform: {
            seniorityVM.startFetchSenioritylevel()
        })
    }
}

struct TitleFilterList_Previews: PreviewProvider {
    static var previews: some View {
        TitleFilterList(FilterTag: .constant(.Title), selectedSeniorityLvlName: .constant(""), selectedSeniorityLvlId: .constant(1), SenbuttonSelected: .constant(2))
            .environmentObject(ViewModelSeniority())
    }
}
