import SwiftUI

struct NameView: View {
    @ObservedObject var data: MyData
    @State var tempN = ""
    @State var Nsel1 = 0
    @State var deleAlert = false

    @State var indexSave: IndexSet = IndexSet()

    let def = UserDefaults.standard

    var body: some View {
        VStack {
            EditButton()
            List {
                Section(header:
                            Text("【氏名・血液型】")) {
                    ForEach(0 ..< data.name.count, id: \.self) {i in
                        Text(data.name[i])
                    }
                    .onDelete { indexDel in
                        data.name.remove(atOffsets: indexDel)
                    }
                    .onMove { src, dst in
                        data.name.move(fromOffsets: src, toOffset: dst)
                    }
                }
            }
            //.listStyle(SidebarListStyle())

            if data.nameRireki.count > 0 {
                HStack {
                    Picker(selection: $Nsel1, label: Text("名前選択")) {
                        ForEach(0 ..< data.nameRireki.count, id: \.self) {i in
                            Text(data.nameRireki[i])
                        }
                    }
                    Button(action: {
                        data.name.append(data.nameRireki[Nsel1])
                        Nsel1 = 0
                        //追記
                        def.set(data.name, forKey: "TestN" )
                    }) {
                        Text("名前を選択する")
                    }
                }
            }

            HStack {
                TextField("氏名・血液型・＋ーを入力ください", text: $tempN)
                Button(action: {
                    data.name.append(tempN)
                    data.nameRireki.append(tempN)
                    tempN = ""
                    //追記
                    def.set(data.name, forKey: "TestN" )
                    def.set(data.nameRireki, forKey: "TestN1")
                    //データセーブ部分
                    UserDefaults.standard.set(data.name, forKey: "NAME")
                }) {
                    Text("名前を登録する")
                }
            }
        }
    }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView(data: MyData())
    }
}
