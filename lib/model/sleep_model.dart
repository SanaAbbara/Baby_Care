class SleepModel {
  String? month, sleepDuration;
  SleepModel({this.month, this.sleepDuration});

  SleepModel.fromJson(Map<String, dynamic> json) {
    sleepDuration = json['sleep'];
  }
}
