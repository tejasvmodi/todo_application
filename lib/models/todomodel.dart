class Todotable {
  int? id;
  late String title;
  late String description;
  late String category;
  late String todoDate;
  late int isFinished;

  Map<String, dynamic> todoMap() {
    var map = <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'todoDate': todoDate,
      'isFinished': isFinished
    };
    return map;
  }
}
