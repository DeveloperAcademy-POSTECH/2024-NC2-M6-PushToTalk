//
//  ChannelView.swift
//  NC2_KkongNyang
//
//  Created by Yeji Seo on 6/20/24.
//

import SwiftUI

//struct LargeButtonStyle: ButtonStyle {
//
//    let backgroundColor: Color
//    let foregroundColor: Color
//
//    func makeBody(configuration: Self.Configuration) -> some View {
//        let currentForegroundColor =   foregroundColor.opacity(0.3)
//        let currentBackgroundColor =  backgroundColor
//        return configuration.label
//            .padding()
//            .foregroundColor(currentForegroundColor)
//            .background( backgroundColor)
//        // This is the key part, we are using both an overlay as well as cornerRadius
//            .cornerRadius(16)
//        //            .overlay(
//        //                RoundedRectangle(cornerRadius: 6)
//        //                    .stroke(currentForegroundColor, lineWidth: 1)
//        //            )
//            .padding([.top, .bottom], 5)
//            .font(Font.system(size: 19, weight: .semibold))
//    }
//}

struct LargeButton: View {
    
    private static let buttonHorizontalMargins: CGFloat = 20
    
    var backgroundColor: Color
    var foregroundColor: Color
    var textColor: Color
    
    private let title: String
    private let action: () -> Void
    
    
    init(title: String,
         disabled: Bool = false,
         backgroundColor: Color = Color.green,
         foregroundColor: Color = Color.white,
         textColor: Color = Color.black,
         action: @escaping () -> Void) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.textColor = textColor
        self.title = title
        self.action = action
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            //            Spacer(minLength: LargeButton.buttonHorizontalMargins)
            
            
            HStack(alignment: .top, spacing: 0){
                VStack(alignment: .leading, spacing: 0){
                    Text(self.title)
                        .foregroundColor(textColor)
                        .font(.system(size: 15, weight: .bold))
                        .frame(width: 168, height: 35, alignment: .topLeading)
                        .padding(.bottom, 14)
                    HStack{
                        Text("Boo")
                            .font(.system(size: 12, weight: .bold))
                            .padding(0)
                            .padding(.trailing,-3)
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(Color(hex: "91A7D1"))
                            .padding(0)
                        
                        Text("Hale")
                            .font(.system(size: 12, weight: .bold))
                            .padding(0)
                        Circle()
                            .padding(0)
                            .padding(.leading,-1)
                            .frame(width: 8, height: 8)
                            .foregroundColor(Color(hex: "#DB5D5D"))
                        
                        Text("Aengzi")
                            .font(.system(size: 12, weight: .bold))
                            .padding(0)
                        
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(Color(hex: "#4D9870"))
                            .padding(0)
                        
                    }
                    .foregroundStyle(foregroundColor)
                    .padding(.trailing)
                }
                .padding(EdgeInsets(top: 7, leading: 8, bottom: -8, trailing: 51))
                Image("sunglassCat")
                    .resizable()
                    .frame(width: 99, height: 93)
                    .padding(EdgeInsets(top: -10, leading: 0, bottom: -20, trailing: -18))
            }
            
            
            //            Spacer(minLength: LargeButton.buttonHorizontalMargins)
        }
        .padding(0)
        .frame(width:345, height: 90)
        .background(backgroundColor)
        .cornerRadius(16)
    }
}




struct ChannelView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black
                    .ignoresSafeArea()
                VStack{
                    HStack{
                        Text("KKONG NYANG")
                            .font(.system(size: 25, weight: .bold))
                            .tracking(2)
                        Spacer()
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 22)
                            .bold()
                    }
                    .padding(EdgeInsets(top: 0, leading: 25, bottom: 20, trailing: 25))
                    .foregroundStyle(.white)
                    
                    ScrollView{
                        NavigationLink(destination: IceReceiveView()){
                            LargeButton(title: "우리 스껄 고양이 보러갈래?", backgroundColor: Color(hex: "#E7E6E7"), foregroundColor: Color(hex: "#000000").opacity(0.6), textColor: .black) {
                                print("dd")
                            }
                            .padding(.top)
                            .padding(.bottom, 16)
                        }
                        
                        NavigationLink(destination: IceReceiveView()){
                            LargeButton(title: "우리 스껄 고양이 보러갈래?", backgroundColor: Color(hex: "#E7E6E7"), foregroundColor: Color(hex: "#000000").opacity(0.6), textColor: .black) {
                                
                            }
                            .padding(.bottom, 16)
                        }
                    }
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ChannelView()
}
