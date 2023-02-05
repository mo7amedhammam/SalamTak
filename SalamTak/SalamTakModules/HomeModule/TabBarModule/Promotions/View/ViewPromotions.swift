//
//  ViewPromotions.swift
//  SalamTak
//
//  Created by wecancity on 05/02/2023.
//

import SwiftUI
import Foundation

struct ViewPromotions: View {
    @StateObject var AdsVM = ViewModelPromotions()
    
    @State var index:Int?
//    @State var ShowActivityIndicator:Bool?
    @State var loginAgain = false
    @State var VideoLink = "https://www.youtube.com/watch?v=tYBZ8AVH0Q0"
    @State private var isActive: Bool = false
    
//    @EnvironmentObject var getDoctorProfileVM : ViewModelGetDoctorProfile
    @State private var currentStep = 0
//    public let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    
//    @State private var player: AVPlayer = AVPlayer(url: URL(string: "https://www.example.com/welcome.mp4")!)
    
    var language = LocalizationService.shared.language
    var body: some View {
        ZStack {
            VStack(spacing:0){
                Text("Promotions_".localized(language))
                    .foregroundColor(Color("blueColor"))
                    .font(Font.system(size: 42))
                    .bold()
//                    .padding(.top,50)
//                HStack{
//                    Spacer()
//                    Text("\("Home_Hello_Dr".localized(language))")
//                        .foregroundColor(Color("newWelcome"))
//                        .font(Font.SalamtakFonts.Bold24)
//
//                    Text("Dr.".localized(language)+"\(language.rawValue == "en" ? getDoctorProfileVM.FirstName:getDoctorProfileVM.FirstNameAr + " " + language.rawValue == "en" ? getDoctorProfileVM.LastName:getDoctorProfileVM.LastNameAr)")
//                        .foregroundColor(Color("blueColor"))
//                        .font(Font.SalamtakFonts.Bold22)
//                    Spacer()
//                }
//                .frame(width:UIScreen.main.bounds.width )
//                Spacer()
//            }
//
//            VStack(spacing:10) {
//                ScrollView{
                    List(AdsVM.publishedAdsModel, id:\.self){ ad in
                        if ad.isVideo == true{
                            VStack(spacing:0){
                                HStack{
                                    Text(ad.compName ?? "Salamtak")
                                        .padding(.horizontal,15)
                                        .font(.salamtakBold(of: 24))
                                    Spacer()
                                }
                                .padding(.horizontal)
                                ZStack{
//                                    YoutubeVideoUrlView(youtubeVideoID: "\(getVideoID(from: ad.videoLink ?? "") ?? "")")
//                                    VideoPlayer(player:AVPlayer(url:URL(string: "https://m.youtube.com/embed/\(getVideoID(from: ad.videoLink ?? "") ?? "")")!))
                                    LinkView(link: "\(ad.videoLink ?? "")")
                                        .onAppear(perform: {
                                            VideoLink = "\(ad.videoLink ?? "")"
                                        })
                                }
                                .cornerRadius(8)
                                .frame(height:150)
                                .padding(.vertical,10)
                                .padding(.horizontal,20)

                                VStack{
                                    Text(ad.discription ?? "")
                                        .font(Font.system(size: 12))
                                        .multilineTextAlignment(.center)
                                        .lineLimit(4)
                                        .padding(.horizontal,15)

                                    Link("More...".localized(language), destination: URL(string: ad.url ?? "\(ad.videoLink ?? "")")!)
                                        .foregroundColor(.salamtackWelcome)
                                        .padding(.top,1)
                                }
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke( Color.salamtackBlue, lineWidth: 1.5)
                            )
                            .foregroundColor( .salamtackBlue)
                                .padding(.horizontal,8)
                        }else{
                            TabView(selection: $currentStep) {
                                ForEach(0..<(ad.getAdImagesDtos?.count ?? 0), id:\.self){ img in
                                    VStack(spacing:0){
                                        HStack{
                                            Text(ad.compName ?? "Salamtak")
                                                .padding(.horizontal,15)
                                                .font(.salamtakBold(of: 24))
                                            Spacer()
                                        }
                                        .padding(.horizontal)
                                        .padding(.bottom,-15)
                                        Spacer()

                                        HStack{
                                            Button(action: {
                                                currentStep = currentStep < (ad.getAdImagesDtos?.count ?? 0)-1 ? currentStep + 1 : 0
                                            }, label: {
                                                Image("newleft")
                                                    .resizable()
                                                    .frame(width:15, height:20)
                                                    .scaledToFit()
                                            })
                                            ZStack{
                                                AsyncImage(url: URL(string: "\(URLs.BaseUrl)\(ad.getAdImagesDtos?[img].imageURL ?? "")")) { image in
                                                    image
                                                        .resizable()
                                                } placeholder: {
                                                    ProgressView()
                                                        .frame(width:65, height:55)
                                                }

                                            }
                                            .scaledToFit()

                                            .cornerRadius(8)
                                            Button(action: {
                                                currentStep = currentStep < (ad.getAdImagesDtos?.count ?? 0)-1 ? currentStep + 1 : 0
                                            }, label: {
                                                Image("newright")
                                                    .resizable()
                                                    .frame(width:15, height:20)
                                                    .scaledToFit()
                                            })
                                        }
                                        .frame(height:130)
                                        .padding(.vertical, 10)

                                        Spacer()

                                        VStack{
                                            Text(ad.discription ?? "")
                                                .font(Font.system(size: 12))
                                                .multilineTextAlignment(.center)
                                                .lineLimit(4)
                                                .padding(.horizontal,15)

                                            Link("More...".localized(language), destination: URL(string: ad.url ?? "\(URLs.BaseUrl)\(ad.getAdImagesDtos?[img].imageURL ?? "")")!)
                                                .foregroundColor(.salamtackBlue)
                                                .padding(.top,1)
                                        }
                                    }
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke( Color.salamtackBlue, lineWidth: 1.5)
                                    )
                                    .foregroundColor( .salamtackBlue)
                                        .padding(.horizontal,8)
                                }
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .frame( height: 240)
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            
                            .onAppear {
                                Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
//                                    currentStep = currentStep < (ad.getAdImagesDtos?.count ?? 0)-1 ? currentStep + 1 : 0
                                    
                                    currentStep = (currentStep + 1) % (ad.getAdImagesDtos?.count ?? 0)

                                }
                            }
                            
//                            .onReceive(timer, perform: { _ in
//                                    DispatchQueue.main.async(execute: {
//                                    print("selection is",currentStep)
//                                    currentStep = currentStep < (ad.getAdImagesDtos?.count ?? 0)-1 ? currentStep + 1 : 0
//                                    })
//                            })
                        }
                    }
                    .listStyle(.plain)
//                }
                    .padding(.horizontal,-20)
//                .padding(.top,140)
                .padding(.bottom,-30)
            Spacer()
            }
            .padding(.top)
            ActivityIndicatorView(isPresented: $AdsVM.isLoading )
            NavigationLink( destination: ViewLogin( ispresented: .constant(false)) , isActive: $loginAgain){
            }
        }
        .popover(isPresented: $isActive, content: {
            LinkView(link: VideoLink)
                .frame(height:200)
                .background(Color.clear)
        })
        .background(
            newBackImage(backgroundcolor: .white,imageName: .whatsupback)
        )
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
//        .ignoresSafeArea()
        .onAppear(perform: {
//            AdsVM.PageID = 3
            AdsVM.GetPromotions()
        })
//        .onDisappear(perform: {
//            self.timer.upstream.connect().cancel()
//        })
    }
}

struct ViewPromotions_Previews: PreviewProvider {
    static var previews: some View {
        ViewPromotions( index: 2)
    }
}

func getVideoID(from urlString: String) -> String? {
    guard let url = urlString.removingPercentEncoding else { return nil }
    do {
        let regex = try NSRegularExpression.init(pattern: "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)", options: .caseInsensitive)
        let range = NSRange(location: 0, length: url.count)
        if let matchRange = regex.firstMatch(in: url, options: .reportCompletion, range: range)?.range {
            let matchLength = (matchRange.lowerBound + matchRange.length) - 1
            if range.contains(matchRange.lowerBound) &&
                range.contains(matchLength) {
                let start = url.index(url.startIndex, offsetBy: matchRange.lowerBound)
                let end = url.index(url.startIndex, offsetBy: matchLength)
                return String(url[start...end])
            }
        }
    } catch {
        print(error.localizedDescription)
    }
    return nil
}
