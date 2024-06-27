//
//  SplashView.swift
//  NC2_KkongNyang
//
//  Created by Yeji Seo on 6/18/24.
//

import SwiftUI
import Lottie

struct SplashView: View {
    var body: some View {
        NavigationStack{
            NavigationLink(destination: ChannelView()){
                ZStack {
                    Color.black
                        .ignoresSafeArea(edges: .all)
                    
                    VStack {
                        LottieView(animation: .named("splash"))
                            .looping()
                            .frame(width: 700)
                        
                        Text("Cat saves the world Inc")
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                    }
                }
            }
        }
        
    }
}

#Preview {
    SplashView()
}
