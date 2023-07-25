import 'dart:io';

class UserModel {
  int? id;
  String? email;
  String? password;
  String? babyname;
  String? father;
  String? mother;
  String? address;
  String? birth;
  int? ageInDays;
  String? pragnancyduration;
  String? gender;
  String? cmLength;
  String? kgWeight;
  String? arrangementAmongSiblings, image;
  int? ageInMonths;
  File? photo;

  UserModel(
      {this.image,
      this.photo,
      this.id,
      this.email,
      this.password,
      this.babyname,
      this.father,
      this.mother,
      this.address,
      this.birth,
      this.ageInDays,
      this.pragnancyduration,
      this.gender,
      this.cmLength,
      this.kgWeight,
      this.arrangementAmongSiblings,
      this.ageInMonths});

  UserModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    id = json['id'];
    email = json['email'];
    password = json['password'];
    babyname = json['babyname'];
    father = json['father'];
    mother = json['mother'];
    address = json['address'];
    birth = json['birth'];
    ageInDays = json['age_in_days'];
    pragnancyduration = json['pragnancyduration'];
    gender = json['gender'];
    cmLength = json['cm_length'];
    kgWeight = json['kg_weight'];
    arrangementAmongSiblings = json['arrangement_among_siblings'];
    ageInMonths = json['age_in_months'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.photo;
    data['id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['babyname'] = this.babyname;
    data['father'] = this.father;
    data['mother'] = this.mother;
    data['address'] = this.address;
    data['birth'] = this.birth;
    data['age_in_days'] = this.ageInDays;
    data['pragnancyduration'] = this.pragnancyduration;
    data['gender'] = this.gender;
    data['cm_length'] = this.cmLength;
    data['kg_weight'] = this.kgWeight;
    data['arrangement_among_siblings'] = this.arrangementAmongSiblings;
    data['age_in_months'] = this.ageInMonths;
    return data;
  }
}
