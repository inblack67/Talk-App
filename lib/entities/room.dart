class MRoom {
  final int id;
  final String description;
  // final String insertedAt;
  // final String updatedAt;
  final String name;

  MRoom({
    required this.id,
    required this.description,
    // required this.insertedAt,
    required this.name,
    // required this.updatedAt,
  });

  factory MRoom.fromJSON(Map<String, dynamic> json) {
    return MRoom(
      id: json['id'],
      description: json['description'],
      // insertedAt: json['insertedAt'],
      // updatedAt: json['updatedAt'],
      name: json['name'],
    );
  }
}
