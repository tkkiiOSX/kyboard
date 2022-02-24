import SwiftUI

struct TaisakuView: View {
    @ObservedObject var data: MyData
    @State var tempT = ""
    @State var Tsel1 = 0
    @State var deleAlert = false

    @State var indexSave: IndexSet = IndexSet()

    let def = UserDefaults.standard

    var body: some View {
        VStack {
            EditButton()
            List {
                Section(header:
                            Text("【安全対策】")) {
                    ForEach(0 ..< data.taisaku.count, id: \.self) {i in
                        Text(data.taisaku[i])
                    }
                    .onDelete { indexDel in
                        data.taisaku.remove(atOffsets: indexDel)
                    }
                    .onMove { src, dst in
                        data.taisaku.move(fromOffsets: src, toOffset: dst)
                    }
                }
            }
            //.listStyle(SidebarListStyle())

            if data.taisakuRireki.count > 0 {
                HStack {
                    Picker(selection: $Tsel1, label: Text("安全対策選択")) {
                        ForEach(0 ..< data.taisakuRireki.count, id: \.self) {i in
                            Text(data.taisakuRireki[i])
                        }
                    }
                    Button(action: {
                        data.taisaku.append(data.taisakuRireki[Tsel1])
                        Tsel1 = 0
                        //追記
                        def.set(data.taisaku, forKey: "TAISAKU" )
                        def.set(data.taisakuRireki, forKey: "TAISAKURIREKI" )
                    }) {
                        Text("安全対策を選択する")
                    }
                }
            }

            HStack {
                TextField("安全対策を入力ください", text: $tempT)
                Button(action: {
                    data.taisaku.append(tempT)
                    data.taisakuRireki.append(tempT)
                    tempT = ""
                    //追記
                    //def.set(data.taisaku, forKey: "TestN" )
                    //def.set(data.taisakuRireki, forKey: "TestN1")

                    //データセーブ部分
                    UserDefaults.standard.set(data.taisaku, forKey: "TAISAKU")
                    UserDefaults.standard.set(data.taisakuRireki, forKey: "TAISAKURIREKI")
                }) {
                    Text("安全対策を登録する")
                }
            }
        }
    }
}

struct TaisakuView_Previews: PreviewProvider {
    static var previews: some View {
        NameView(data: MyData())
    }
}
