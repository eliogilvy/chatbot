class Conversation {
  final String id;
  final String title;
  final int createdAt;
  final int lastUpdated;

  Conversation({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.lastUpdated,
  });

  // To json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt,
      'lastUpdated': lastUpdated,
    };
  }

  // fromJson
  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'] as String,
      title: json['title'] as String,
      createdAt: json['createdAt'] as int,
      lastUpdated: json['lastUpdated'] as int,
    );
  }
}
