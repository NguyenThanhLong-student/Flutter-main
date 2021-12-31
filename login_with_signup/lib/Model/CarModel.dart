class CarModel {
  String make;
  String model;
  String description;
  String imageSrc;
  CarModel(this.make, this.model, this.description, this.imageSrc);
  operator ==(other) =>
      (other is CarModel) && (make == other.make) && (model == other.model);
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'make': make,
      'model': model,
      'description': description,
      'imageSrc': imageSrc
    };
    return map;
  }

  
  CarModel.fromMap(Map<String, dynamic> map) {
    make = map['make'];
    model = map['model'];
    description = map['description'];
    imageSrc = map['imageSrc'];
  }
}