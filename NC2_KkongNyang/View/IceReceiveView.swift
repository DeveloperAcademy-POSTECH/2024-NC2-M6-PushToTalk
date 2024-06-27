//
//  IceReceiveView.swift
//  NC2_KkongNyang
//
//  Created by 부창현 on 6/20/24.
//


import SwiftUI
import Lottie
import AVFoundation

//var player: AVAudioPlayer?

struct IceReceiveView: View {
    @State private var playbackMode: LottiePlaybackMode = .paused(at: .currentFrame)
    @State private var playbackMode2: LottiePlaybackMode = .paused(at: .currentFrame)
    @State private var animationView: LottieAnimationView?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false
    @State private var frameToTriggerSound: AnimationFrameTime = 0
    @State private var pressStartTime: Date?
    @State private var pressedDuration: TimeInterval = 0
    @State private var totalPressedDuration: TimeInterval = 0  // 추가된 상태 변수
    @State private var WarmEffectOpacity = 0
    @State private var receiveAudio: Bool = false

    var body: some View {
        
        NavigationStack{
            ZStack {
                Color.black
                    .ignoresSafeArea(edges: .all)
                
                LottieView(animation: .named("IceLottieFinal"))
                    .animationSpeed(0.5)
                    .playbackMode(playbackMode)
                    .configure { view in
                        self.animationView = view
                    }
                    .frame(width: 600, height: 700)
                    .padding(.bottom, 60)
                
                
                LottieView(animation: .named("WarmGrad Final"))
                    .animationSpeed(0.5)
                    .looping()
                    .playbackMode(playbackMode2)
                    .configure { view in
                        self.animationView = view
                    }
                    .frame(width: 600, height: 700)
                    .padding(.bottom, 60)
                    .opacity(Double(WarmEffectOpacity))
                
                
                VStack {
                    Spacer()
                    // receiveAudio
                    Button(action: {
                        
                    }, label: {
                        Rectangle()
                            .frame(width: 400, height: 70)
                            .foregroundStyle(.black)
                    })
                    .onLongPressGesture(minimumDuration: 0.1, pressing: { isPressing in
                        
                        if isPressing {
                            self.WarmEffectOpacity = 1
                            self.pressStartTime = Date()
                            self.startAnimation()
                            receiveAudio = true
                            
                            if totalPressedDuration >= 15
                            {playSound()}
                        } else {
                            receiveAudio = false
                            if let startTime = self.pressStartTime {
                                self.pressedDuration = Date().timeIntervalSince(startTime)
                                self.totalPressedDuration += self.pressedDuration  // 누적 시간 업데이트
                                print("현재 누른 시간: \(self.pressedDuration)")
                                print("누적 누른 시간: \(self.totalPressedDuration)")
                            }
                            self.WarmEffectOpacity = 0
                            self.pauseAnimation()
                        }
                    }, perform: {
                        
                    })
                    
                    
                    Button(action: {
                        //워키토키 펑션 들어갈 자리
                    }) {
                        if totalPressedDuration >= 26 {
                            NavigationLink(destination: ChannelView()){
                                ZStack{
                                    Rectangle()
                                        .frame(width: 345, height: 64)
                                        .foregroundStyle(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                    Text("Back to Home")
                                        .font(.system(size: 22))
                                        .bold()
                                        .foregroundStyle(.black)
                                }
                            }
                            
                        }
                        else{
                            ZStack{
                                let color = isPlaying ? Color.gray : Color.white
                                let text = isPlaying ?
                                HStack{
                                    Text("Unable Now")
                                        .font(.system(size: 22))
                                        .bold()
                                        .foregroundColor(.white)
                                    Spacer()
                                        .frame(width: 0)
                                    Image(systemName: "mic.fill")
                                        .resizable()
                                        .frame(width: 16, height: 0)
                                        .foregroundStyle(.black)
                                }
                                :
                                HStack{
                                    Text("Tab & Hold to Talk")
                                        .font(.system(size: 22))
                                        .bold()
                                        .foregroundColor(.black)
                                    Spacer()
                                        .frame(width: 20)
                                    Image(systemName: "mic.fill")
                                        .resizable()
                                        .frame(width: 16, height: 25)
                                        .foregroundStyle(.black)
                                }
                                Rectangle()
                                    .frame(width: 345, height: 64)
                                    .foregroundStyle(color)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                HStack{
                                    text
                                }
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    .onLongPressGesture(minimumDuration: 0.1, pressing: { isPressing in
                        
                        if isPressing {
                            self.pressStartTime = Date()
                            self.startAnimation()
                            // TODO: n Frame 일 때, 소리가 나도록 해야함
                            
                            if totalPressedDuration >= 15
                            {playSound()}
                        } else {
                            if let startTime = self.pressStartTime {
                                self.pressedDuration = Date().timeIntervalSince(startTime)
                                self.totalPressedDuration += self.pressedDuration  // 누적 시간 업데이트
                                print("현재 누른 시간: \(self.pressedDuration)")
                                print("누적 누른 시간: \(self.totalPressedDuration)")
                            }
                            self.pauseAnimation()
                        }
                    }, perform: {
                        
                    })
                }
                
                .task {
                    self.loadSound()
                }
                if totalPressedDuration >= 15 {
                    VStack{
                        Text("Congratuation!")
                            .foregroundStyle(.white)
                            .font(.system(size: 30))
                            .bold()
                            .padding(.top, 100)
                        Spacer()
                    }
                    
                    
                }
                else {
                    VStack{
                        Image(systemName: receiveAudio ? "ear.badge.waveform": "dot.circle.and.hand.point.up.left.fill")
                            .resizable()
                            .frame(width: receiveAudio ? 40 : 60, height: receiveAudio ? 50 : 50)
                            .foregroundStyle(.white)
                            .padding(.top, 80)
                            .padding(.leading, 22)
                        Text(receiveAudio ? "상대의 말을 듣고있습니다": "버튼을 눌러 얼음을 녹여주세요")
                            .foregroundStyle(.white)
                            .font(.system(size: 18))
                            .bold()
                        Spacer()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    
    
    //---------
    
    private func startAnimation() {
        playbackMode = .playing(.fromProgress(0, toProgress: 1, loopMode: .playOnce))
        isPlaying = true
        playbackMode2 = .playing(.fromProgress(0, toProgress: 1, loopMode: .loop))
    }
    
    
    private func pauseAnimation() {
        playbackMode = .paused(at: .currentFrame)
        isPlaying = false
    }
    
    private func loadSound() {
        guard let soundURL = Bundle.main.url(forResource: "앙칼고앵이", withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            
        } catch {
            print("Failed to load sound: \(error.localizedDescription)")
        }
    }
    
    private func playSound() {
        
        audioPlayer?.play()
    }
}

#Preview {
    IceReceiveView()
}
