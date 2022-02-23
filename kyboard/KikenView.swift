import SwiftUI

struct KikenView: View {
    @ObservedObject var data: MyData
    @State var tempK = ""
    @State var Ksel1 = 0
    @State var deleAlert = false

    @State var indexSave: IndexSet = IndexSet()

    let def = UserDefaults.standard

    var body: some View {
        VStack {
            EditButton()
            List {
                Section(header:
                            Text("【危険予知】")) {
                    ForEach(0 ..< data.kiken.count, id: \.self) {i in
                        Text(data.kiken[i])
                    }
                    .onDelete { indexDel in
                        data.kiken.remove(atOffsets: indexDel)
                    }
                    .onMove { src, dst in
                        data.kiken.move(fromOffsets: src, toOffset: dst)
                    }
                }
            }
            //.listStyle(SidebarListStyle())

            if data.kikenRireki.count > 0 {
                HStack {
                    Picker(selection: $Ksel1, label: Text("作業選択")) {
                        ForEach(0 ..< data.kikenRireki.count, id: \.self) {i in
                            Text(data.kikenRireki[i])
                        }
                    }
                    Button(action: {
                        data.kiken.append(data.kikenRireki[Ksel1])
                        Ksel1 = 0
                        //追記
                        def.set(data.kiken, forKey: "KIKEN" )
                        def.set(data.kikenRireki, forKey: "KIKENRIREKI" )
                    }) {
                        Text("危険予知を選択する")
                    }
                }
            }

            HStack {
                TextField("危険予知を入力ください", text: $tempK)
                Button(action: {
                    data.kiken.append(tempK)
                    data.kikenRireki.append(tempK)
                    tempK = ""
                    //追記
                    //def.set(data.kiken, forKey: "TestK" )
                    //def.set(data.kikenRireki, forKey: "TestK1")

                    //データセーブ部分
                    UserDefaults.standard.set(data.kiken, forKey: "KIKEN")
                    UserDefaults.standard.set(data.kikenRireki, forKey: "KIKENRIREKI")
                }) {
                    Text("作業内容を登録する")
                }
            }
        }
    }
}

struct KikenView_Previews: PreviewProvider {
    static var previews: some View {
        KikenView(data: MyData())
    }
}

