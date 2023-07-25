class IliinessesModel {
  int? id;
  String? illinessesName;
  List<String>? medicineName;
  bool? taped;
  IliinessesModel(
      {this.id, this.illinessesName, this.medicineName, this.taped = false});
  IliinessesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    illinessesName = json['ill_name'];
    medicineName = json['treats'].cast<String>();
    taped = json['taped'];
  }
}
