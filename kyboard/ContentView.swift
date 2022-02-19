//
//  ContentView.swift
//  kyboard
//
//  Created by Xcode2021 on 2022/01/09.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var data = MyData()
    //追記
    let def = UserDefaults.standard
    var dateFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateStyle = .short
        f.timeStyle = .short
        f.locale = Locale(identifier: "ja_JP")
        return f
    }
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    VStack(alignment: .leading) {
                        Text("【年月日】")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                        Text(dateFormatter.string(from: data.yyyymmdd))
                            .font(.title2)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(Color("keisenColor"), width: 2)



                    VStack(alignment: .leading) {
                        Text("【氏名　血液型】")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                        ForEach(0 ..< data.name.count, id: \.self) {i in
                            Text(data.name[i])
                        }
                        .font(.title2)
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(Color("keisenColor"), width: 2)

                    VStack(alignment: .leading) {
                        Text("【作業内容】")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                        ForEach(0 ..< data.sagyo.count, id:\.self) {i in Text(data.sagyo[i])
                        }
                        .font(.title2)
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(Color("keisenColor"), width: 2)

                    VStack(alignment: .leading) {
                        Text("【危険予知】")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                        ForEach(0 ..< data.kiken.count, id:\.self) {i in Text(data.kiken[i])
                        }
                        .font(.title2)
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(Color("keisenColor"), width: 2)

                    VStack(alignment: .leading) {
                        Text("【安全対策】")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                        ForEach(0 ..< data.taisaku.count, id:\.self) {i in Text(data.taisaku[i])
                        }
                        .font(.title2)
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(Color("keisenColor"), width: 2)
                }
            }



            .padding()
            //.font(.system(size: 25, weight: .regular, design: .monospaced))

            .navigationTitle("KYDoc（危険予知記録）")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: NavigationLink(
                                    destination: InputView(data: data),
                                    label: {
                                        Text("編集画面へ")
                                    }))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        //追記
        .onAppear {
            let tmp = def.array(forKey: "Test1") as? [String]
            if (tmp != nil) {
                data.name = tmp!
                print("123")
            }
            let tmp2 = def.array(forKey: "Test2") as? [String]
            if (tmp2 != nil) {
                    data.nameRireki = tmp2!
                print("abc")
            }
            print("hij")
        }
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
