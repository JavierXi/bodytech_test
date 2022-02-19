class Item {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Item({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body'],
      );
}
