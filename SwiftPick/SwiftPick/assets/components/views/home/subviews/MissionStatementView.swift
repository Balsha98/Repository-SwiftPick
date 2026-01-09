import SwiftUI

public struct MissionStatementView: View {
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Our Mission")
                    .font(.title)
                    .fontWeight(.bold)
                //Text
                
                Spacer()
                
                Image(systemName: "target")
                    .font(.title)
                    .foregroundStyle(Color.primary)
                //Image
            }//HStack
            
            ZStack {
                HStack(spacing: 16) {
                    VStack {
                        HStack {
                            Text("Enlighten.")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .italic()
                                .foregroundStyle(.white)
                            //Text
                            
                            Spacer()
                        }//HStack
                        
                        Spacer()
                        
                        HStack(alignment: .bottom) {
                            Rectangle()
                                .fill(.white)
                                .frame(width: 32, height: 2)
                            //Rectangles
                            
                            Spacer()
                            
                            Image("logo.valuetainment.portrait.inverted")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48, height: 48)
                            //Image
                        }//HStack
                    }//VStack
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .background(Color.primary)
                    .cornerRadius(4)
                    
                    VStack(spacing: 16) {
                        VStack {
                            HStack {
                                Text("Entertain.")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .italic()
                                    .foregroundStyle(.white)
                                //Text
                                
                                Spacer()
                            }//HStack
                            
                            Spacer()
                            
                            HStack(alignment: .bottom) {
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: 32, height: 2)
                                //Rectangles
                                
                                Spacer()
                                
                                Image("logo.valuetainment.portrait.inverted")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 48, height: 48)
                                //Image
                            }//HStack
                        }//VStack
                        .padding()
                        .background(Color.primary)
                        .cornerRadius(4)
                        
                        VStack {
                            HStack {
                                Text("Empower.")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .italic()
                                    .foregroundStyle(.white)
                                //Text
                                
                                Spacer()
                            }//HStack
                            
                            Spacer()
                            
                            HStack(alignment: .bottom) {
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: 32, height: 2)
                                //Rectangles
                                
                                Spacer()
                                
                                Image("logo.valuetainment.portrait.inverted")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 48, height: 48)
                                //Image
                            }//HStack
                        }//VStack
                        .frame(height: 96)
                        .padding()
                        .background(Color.primary)
                        .cornerRadius(4)
                    }//VStack
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }//HStack
                .frame(height: 320)
            }//ZStack
            .shadow(
                color: .black.opacity(0.2),
                radius: 4, x: 0, y: 4
            )//shadow
        }//VStack
        .frame(maxWidth: .infinity)
    }//body
}//MissionStatementView
