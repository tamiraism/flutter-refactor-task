//item model classiig mainees salgasan

class Item {
  final int id;
  final String? title;
  final String? description;

  Item({required this.id, this.title, this.description});

  factory Item.fromJson(Map<dynamic, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      description: json['body'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}