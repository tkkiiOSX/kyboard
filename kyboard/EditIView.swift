import SwiftUI

struct EditView: View {

    @State var tempN = ""
    @State var Nsel1 = 0
    @State var deleAlert = false
    @State var indexDelN: IndexSet!

    let def = UserDefaults.standard

    @Binding var items: [String]
    @Binding var itemRirekis: [String]

    var msg1: String
    var itemSave: String
    var itemRirekiSave: String

    var body: some View {
        VStack {
            Button(action: {
                deleAlert = true
            }) {
                Text("\(msg1)のクリア")
                    .padding(.all, 10)
                    .foregroundColor(.black)
                    .background(Color(white: 0.95))
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 3, x: 10, y: 10)   
            }
            .alert(isPresented: $deleAlert) {
                Alert(
                    title: Text("確認"),
                    message: Text("この項目を削除しますか？"),
                    primaryButton: .default(Text("はい"), action: {
                        //保持データのクリア
                        UserDefaults.standard.removeObject(forKey: itemSave)
                        UserDefaults.standard.removeObject(forKey: itemRirekiSave)

                        items = []
                        itemRirekis = []
                    }),
                    secondaryButton: .cancel(Text("やめる"))
                )
            }
            HStack {
                Spacer()
                EditButton()
            }

            List {
                Section(header:
                            Text("【\(msg1)】")) {
                    ForEach(0 ..< items.count, id: \.self) {i in
                        Text(items[i])
                    }
                    .onDelete { indexDel in
                        items.remove(atOffsets: indexDel)
                        def.set(items, forKey: itemSave )
                    }
                    .onMove { src, dst in
                        items.move(fromOffsets: src, toOffset: dst)
                        def.set(items, forKey: itemSave )
                    }
                }
            }
            if itemRirekis.count > 0 {
                HStack {
                    Picker(selection: $Nsel1, label: Text("\(msg1)選択")) {
                        ForEach(0 ..< itemRirekis.count, id: \.self) {i in
                            Text(itemRirekis[i])
                        }
                    }
                    Button(action: {
                        items.append(itemRirekis[Nsel1])
                        Nsel1 = 0
                        //追記
                        def.set(items, forKey: itemSave)
                        def.set(itemRirekis, forKey: itemRirekiSave)
                    }) {
                        Text("\(msg1)を選択する")
                            .padding(.all, 10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding()
                            .shadow(color: .gray, radius: 3, x: 10, y: 10)
                    }
                }
            }

            HStack {
                TextField("\(msg1)を入力ください", text: $tempN)
                    .padding(.all, 10)
                    .background(Color.white)
                Button(action: {
                    if tempN != "" {
                        //data.name.append(tempN)
                        items.append(tempN)
                        //data.nameRireki.append(tempN)
                        itemRirekis.append(tempN)
                        tempN = ""
                        //追記
                        def.set(items, forKey: itemSave)
                        def.set(itemRirekis, forKey: itemRirekiSave)
                    } 
                }) {
                    Text("\(msg1)を登録する")
                        .padding(.all, 10)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding()
                        .shadow(color: .gray, radius: 3, x: 10, y: 10)   
                }
            }
        }
        .navigationBarHidden(false)
    }
}

