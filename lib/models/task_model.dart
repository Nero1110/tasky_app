class TaskModel {
  int? id;
  String title;
  String description;
  bool isDone;
  DateTime createdAt;
  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.createdAt
  });

  Map<String, dynamic> tojson() {
    return {"title": title, "description": description, "isDone": isDone?1 : 0,"createdAt":createdAt.millisecondsSinceEpoch};
  }

  factory TaskModel.fromjson(json) {
    return TaskModel(
      createdAt: DateTime.fromMillisecondsSinceEpoch(json["createdAt"]),
      id: json["id"],
      title: json["title"],
      description: json["description"],
      isDone: json["isDone"]==1? true:false,
    );
  }
}
