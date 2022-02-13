//
//  InputView.swift
//  KY20211219
//
//  Created by Xcode2021 on 2021/12/26.
//

import SwiftUI

struct InputView: View {
    @ObservedObject var data: MyData
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        TabView {
            NameView(data: data)
                .tabItem {
                    Text("名前")
                }
            SagyoView(data: data)
                .tabItem {
                    Text("作業")
                }
            KikenView(data: data)
                .tabItem {
                    Text("危険")
                }
            TaisakuView(data: data)
                .tabItem {
                    Text("対策")
                }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()

        }, label: {
            Text("戻る")
        }))

    }
}


struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(data: MyData())
    }
}
