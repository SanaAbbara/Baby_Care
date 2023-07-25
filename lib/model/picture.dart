import 'dart:typed_data';

class Picture {
  int? id;
  String? title;
  String? picture;
  Picture({this.id, required this.title, required this.picture});
  int get idphoto => id!;
  String get pictures => picture!;
  String get titles => title!;

  Picture.fromMap(Map map) {
    id = map[id];
    title = map[title];
    picture = map[picture];
  }
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "picture": picture,
      };
}
