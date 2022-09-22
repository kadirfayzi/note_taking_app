class Todo {
  Todo({
    this.id,
    this.content,
    this.completed,
    this.updatedAt,
  });

  int? id;
  String? content;
  bool? completed;
  String? updatedAt;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        content: json["content"],
        completed: json["completed"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "completed": completed.toString(),
        "updatedAt": updatedAt,
      };
}
