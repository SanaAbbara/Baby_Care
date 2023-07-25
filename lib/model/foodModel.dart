class FoodModel {
  List<String>? nMilk;
  List<String>? water;
  List<String>? fruits;
  List<String>? vegetables;
  List<String>? cyrbohedats;
  List<String>? cremy;
  List<String>? fmilk;

  FoodModel(
      {this.nMilk,
      this.water,
      this.fruits,
      this.vegetables,
      this.cyrbohedats,
      this.cremy,
      this.fmilk});

  FoodModel.fromJson(Map<String, dynamic> json) {
    nMilk = json['Breast milk'].cast<String>();
    water = json['Water'].cast<String>();
    fruits = json['Fruits'].cast<String>();
    vegetables = json['Vegetables'].cast<String>();
    cyrbohedats = json['Cyrbohedats'].cast<String>();
    cremy = json['Cremy'].cast<String>();
    fmilk = json['Formula milk'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Breast milk'] = this.nMilk;
    data['Water'] = this.water;
    data['Fruits'] = this.fruits;
    data['Vegetables'] = this.vegetables;
    data['Cyrbohedats'] = this.cyrbohedats;
    data['Cremy'] = this.cremy;
    data['Formula milk'] = this.fmilk;
    return data;
  }
}
