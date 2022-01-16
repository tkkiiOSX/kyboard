//
//  ContentView.swift
//  kyboard
//
//  Created by Xcode2021 on 2022/01/09.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var data = MyData()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    VStack(alignment: .leading) {
                        Text("氏名　血液型")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(0 ..< data.name.count, id: \.self) {i in
                            Text(data.name[i])
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(Color("keisenColor"), width: 2)

                    VStack(alignment: .leading) {
                        Text("作業内容")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(0 ..< data.sagyo.count, id:\.self) {i in Text(data.sagyo[i])
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(Color("keisenColor"), width: 2)

                    VStack(alignment: .leading) {
                        Text("危険予知")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(0 ..< data.kiken.count, id:\.self) {i in Text(data.kiken[i])
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(Color("keisenColor"), width: 2)

                    VStack(alignment: .leading) {
                        Text("安全対策")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(0 ..< data.taisaku.count, id:\.self) {i in Text(data.taisaku[i])
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(Color("keisenColor"), width: 2)
                }
            }



            .padding()
            .font(.system(size: 25, weight: .regular, design: .monospaced))

            .navigationTitle("KYDoc（危険予知記録）")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: NavigationLink(
                                    destination: InputView(data: data),
                                    label: {
                                        Text("編集画面へ")
                                    }))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)

            ContentView()

        }
    }
}
