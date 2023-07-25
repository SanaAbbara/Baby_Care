class TipsModel {
  String? title;
  String? subTitle;
  TipsModel({this.title, this.subTitle});
  TipsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['tip'];
  }
}
