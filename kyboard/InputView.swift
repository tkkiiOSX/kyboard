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
            FirstView().tabItem {
                Text("名前")

            }
            SecondView().tabItem {
                Text("作業")

            }
            ThirdView().tabItem {
                Text("危険")

            }
            FourthView().tabItem {
                Text("対策")

            }
        }

        VStack {
            NameView(data: data)
            //SagyoView(data: data)
            //KikenView(data: data)
            //TaisakuView(data: data)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()

        }, label: {
            Text("戻る")
        }))

    }
}
struct FirstView: View {
    var body: some View {
        Text("名前")

    }
}

struct SecondView: View {
    var body: some View {
        Text("作業")
    }
}

struct ThirdView: View {
    var body: some View {
        Text("危険")
    }
}

struct FourthView: View {
    var body: some View {
        Text("対策")
    }
}


struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(data: MyData())
    }
}
