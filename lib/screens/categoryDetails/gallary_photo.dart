// import 'dart:convert';
// import 'dart:io';

// import 'dart:typed_data';
// import 'package:baby_care/model/picture.dart';
// import 'package:baby_care/sqldb/sql_db.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';

// // class GallaryPhoto extends StatefulWidget {
// //   const GallaryPhoto({Key? key}) : super(key: key);

// //   @override
// //   State<GallaryPhoto> createState() => _GallaryPhotoState();
// // }

// // class _GallaryPhotoState extends State<GallaryPhoto> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(),
// //     );
// //   }
// // }

// class Utility {
//   static Image imageFromBase64String(String base64String) {
//     return Image.memory(
//       base64Decode(base64String),
//       fit: BoxFit.fill,
//     );
//   }

//   static Uint8List dataFromBase64String(String base64String) {
//     return base64Decode(base64String);
//   }

//   static String base64String(Uint8List data) {
//     return base64Encode(data);
//   }
// }

// class GallaryPhotos extends StatefulWidget {
//   //
//   GallaryPhotos() : super();

//   final String title = "Flutter Save Image";

//   @override
//   _GallaryPhotosState createState() => _GallaryPhotosState();
// }

// class _GallaryPhotosState extends State<GallaryPhotos> {
//   //
//   File? imageFile;
//   Image? image;
//   BabyCareDb? dbHelper;
//   List<Picture>? images;
//   String imageEncode = "";
//   @override
//   void initState() {
//     super.initState();
//     // images = [];
//     // dbHelper = DBHelper();
//     // refreshImages();
//   }

//   // refreshImages() {
//   //   dbHelper!.getPhotos().then((imgs) {
//   //     setState(() {
//   //       images!.clear();
//   //       images!.addAll(imgs);
//   //     });
//   //   });
//   // }

//   Future pickImageFromCamera() async {
//     // ignore: invalid_use_of_visible_for_testing_member

//     // Pick an image
//     final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (myfile == null) {
//       return;
//     }
//     var imagesFile = File(myfile.path);
//     final bytes = imagesFile.readAsBytesSync();
//     final image_now = base64Encode(bytes);
//     setState(() {
//       imageFile = imagesFile;
//       imageEncode = image_now;
//     });

//     //String imgString = base64Encode(imageFile!.readAsBytesSync());
//     String imageName = imageFile!.path.split("/").last;
//     print(
//         "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
//     print(imageName);

//     // Photo photo = Photo(imageName, imgString);
//     // dbHelper!.save(photo);
//     // refreshImages();
//   }

//   // gridView() {
//   //   return Padding(
//   //     padding: EdgeInsets.all(5.0),
//   //     child: GridView.count(
//   //       crossAxisCount: 2,
//   //       childAspectRatio: 1.0,
//   //       mainAxisSpacing: 4.0,
//   //       crossAxisSpacing: 4.0,
//   //       children: images!.map((photo) {
//   //         return Image.memory(
//   //           base64Decode(photo.photo_name!),
//   //           fit: BoxFit.fill,
//   //         );
//   //         ;
//   //       }).toList(),
//   //     ),
//   //   );
//   // }
//   void updateListView() {
//     final Future<Database> dbfutur = dbHelper!.initDb();
//     dbfutur.then((database) {
//       Future<List<Picture>> imagesListfuture = dbHelper!.getPhotos();
//       imagesListfuture.then((imageslist) {
//         setState(() {
//           images = imageslist;
//           images!.length = imageslist.length;
//         });
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (images == null) {
//       images = [];
//       updateListView();
//     }
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.green,
//           title: Text(widget.title),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () {
//                 pickImageFromCamera();
//               },
//             )
//           ],
//         ),
//         body: Padding(
//             padding: EdgeInsets.all(5.0),
//             child: ListView.builder(
//                 itemCount: images == null ? 0 : images!.length,
//                 itemBuilder: ((context, index) {
//                   return Card(
//                     child: ListTile(
//                       title: Text(images![index].titles),
//                       subtitle: Text(images![index].titles),
//                       leading:
//                           Image.memory(base64Decode(images![index].pictures)),
//                     ),
//                   );
//                 })))
//         // Center(
//         //   child: Column(
//         //     mainAxisAlignment: MainAxisAlignment.start,
//         //     children: <Widget>[
//         //       Flexible(
//         //         child: imageFile == null ? Container() : Image.file(imageFile!),
//         //       )
//         //     ],
//         //   ),
//         // ),
//         );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';

import 'dart:convert';

class Utility {
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}

class Photo {
  int? id;
  String? photo_name;

  Photo(this.id, this.photo_name);
  String get photoName => photo_name!;
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'photo_name': photo_name,
    };
    return map;
  }

  Photo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    photo_name = map['photo_name'];
  }
}

class DBHelper {
  static Database? _db;
  static const String ID = 'id';
  static const String NAME = 'photo_name';
  static const String TABLE = 'PhotosTable';
  static const String DB_NAME = 'photos.db';

  Future<Database> get db async {
    if (null != _db) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $TABLE ($ID INTEGER, $NAME TEXT)");
  }

  Future<Photo> save(Photo employee) async {
    var dbClient = await db;
    employee.id = await dbClient.insert(TABLE, employee.toMap());
    return employee;
  }

  Future<List<Photo>> getPhotos() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps =
        await dbClient.query(TABLE, columns: [ID, NAME]);
    List<Photo> employees = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        employees.add(Photo.fromMap(maps[i]));
      }
    }
    return employees;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}

class GallaryPhotos extends StatefulWidget {
  //
  GallaryPhotos() : super();

  final String title = " gallary";

  @override
  _GallaryPhotosState createState() => _GallaryPhotosState();
}

class _GallaryPhotosState extends State<GallaryPhotos> {
  //
  Future<File>? imageFile;
  Image? image;
  late DBHelper dbHelper;
  late List<Photo> images;

  @override
  void initState() {
    super.initState();
    images = [];
    dbHelper = DBHelper();
    refreshImages();
  }

  refreshImages() {
    dbHelper.getPhotos().then((imgs) {
      setState(() {
        images.clear();
        images.addAll(imgs);
      });
    });
  }

  pickImageFromGallery() async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((imgFile) {
      String imgString =
          Utility.base64String(File(imgFile!.path).readAsBytesSync());
      Photo photo = Photo(0, imgString);
      dbHelper.save(photo);
      refreshImages();
    });
  }

  // gridView() {
  //   return Padding(
  //     padding: EdgeInsets.all(5.0),
  //     child: GridView.count(
  //       crossAxisCount: 2,
  //       childAspectRatio: 1.0,
  //       mainAxisSpacing: 4.0,
  //       crossAxisSpacing: 4.0,
  //       children: images.map((photo) {
  //         return Utility.imageFromBase64String(photo.photoName);
  //       }).toList(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              pickImageFromGallery();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
                child: Padding(
              padding: EdgeInsets.all(5.0),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                children: images.map((photo) {
                  return GestureDetector(
                      onTap: () {},
                      child: Utility.imageFromBase64String(photo.photoName));
                }).toList(),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
