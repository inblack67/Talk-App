class MRoom {
  final int id;
  final String description;
  final String insertedAt;
  final String name;

  MRoom({
    required this.id,
    required this.description,
    required this.insertedAt,
    required this.name,
  });

  factory MRoom.fromJSON(Map<String, dynamic> json) {
    return MRoom(
      id: json['id'],
      description: json['desc'],
      insertedAt: json['inserted_at'],
      name: json['name'],
    );
  }
}
