part of 'shared.dart';

Future<File> getImage() async {
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);

  // arahkan pada objek yang ada di firebase storage dengan nama filename
  StorageReference ref = FirebaseStorage.instance.ref().child(fileName);

  // memberikan tugas pada reference untuk upload file
  StorageUploadTask task = ref.putFile(image);

  // setelah melakukan tugasnya, kita minta kembaliannya
  // ketika complete, dia akan mengembalikan storage task snapshot
  StorageTaskSnapshot snapshot = await task.onComplete;

  // setelah mendapat snapshot hasil dari task, kembalikan download url nya
  return await snapshot.ref.getDownloadURL();
}

Widget generateDashedDivider(double width) {
  int n = width ~/ 5;
  return Row(
    children: List.generate(
        n,
        (index) => (index % 2 == 0)
            ? Container(
                height: 2,
                width: width / n,
                color: accentColorLightGray,
              )
            : SizedBox(
                width: width / n,
              )),
  );
}
