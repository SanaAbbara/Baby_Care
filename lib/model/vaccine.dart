class Vaccine {
  String? vaccineName;
  int? doseNum;
  bool? taken;
  String? deadLine;
  int? vaccinId;

  Vaccine(
      {this.vaccineName,
      this.doseNum,
      this.taken,
      this.deadLine,
      this.vaccinId});

  Vaccine.fromJson(Map<String, dynamic> json) {
    vaccineName = json['vaccine_name'];
    vaccinId = json['id'];
    doseNum = json['dose_num'];
    taken = json['taken'];
    deadLine = json['dead_line'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vaccine_name'] = this.vaccineName;
    data['dose_num'] = this.doseNum;
    data['taken'] = this.taken;
    data['dead_line'] = this.deadLine;
    data['id'] = this.vaccinId;
    return data;
  }
}
