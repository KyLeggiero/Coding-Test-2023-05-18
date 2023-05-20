//
//  ThankYouForYourConsideration.swift
//  Bent
//
//  Created by Ky Leggiero on 2023-05-19.
//

import SwiftUI

struct ThankYouForYourConsideration: View {
    
    let onReset: () -> Void
    
    
    var body: some View {
        VStack {
            Text("Thank you for your consideration")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .padding()
            
            Link(destination: URL(string: "https://KyLeggiero.me")!) {
                HStack {
                    Spacer()
                    Text("– Ky")
                        .font(.system(size: 24))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            VStack {
                Spacer()
                Button("Reset this demo", action: onReset)
            }
        }
        .padding()
    }
}

struct ThankYouForYourConsideration_Previews: PreviewProvider {
    static var previews: some View {
        ThankYouForYourConsideration(onReset: {})
    }
}
