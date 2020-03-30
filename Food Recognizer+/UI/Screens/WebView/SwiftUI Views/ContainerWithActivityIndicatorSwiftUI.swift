//
//  ContainerWithActivityIndicatorSwiftUI.swift
//  Food Recognizer+
//
//  Created by dev on 30.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import SwiftUI

let kPreviewBackground = Color.white
struct ContainerWithActivityIndicatorSwiftUI: View {
  var body: some View {
    ZStack {
      kPreviewBackground
        .edgesIgnoringSafeArea(.all)

      VStack {
        ActivityIndicatorSwiftUI()
          .frame(width: 80, height: 80)
        }.foregroundColor(Color.black)
      }
  }
}

struct ContainerWithActivityIndicatorSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        ContainerWithActivityIndicatorSwiftUI()
    }
}
