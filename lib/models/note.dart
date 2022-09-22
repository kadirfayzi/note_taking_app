class Note {
  Note({
    this.id,
    this.title,
    this.content,
    this.updatedAt,
  });

  int? id;
  String? title;
  String? content;
  String? updatedAt;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "updatedAt": updatedAt,
      };
}
