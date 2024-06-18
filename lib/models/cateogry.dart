class Category {
  int? id;
  late String name;
  late String description;

 categoryMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
    return map;
  }
}