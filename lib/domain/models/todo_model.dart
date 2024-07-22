class TodoModel {
  String? todoId;
  String? title;
  String? desc;
  bool? isCompleted;
  int? priority; //3-> low(blue), 2-> medium(orange),1-> high(red),
  String? assignedAt;
  String? completedAt;

  TodoModel({
    this.todoId,
    required this.title,
    required this.desc,
    this.isCompleted = false,
    this.priority = 1,
    required this.assignedAt,
    this.completedAt = '',
  });

  ///map to model
  factory TodoModel.fromTodo(Map<String, dynamic> doc) => TodoModel(
        todoId: doc['todoId'],
        title: doc['title'],
        desc: doc['desc'],
        isCompleted: doc['isCompleted'] ?? false,
        priority: doc['priority'],
        assignedAt: doc['assignedAt'],
        completedAt: doc['completedAt'],
      );

  ///model to map
  Map<String, dynamic> toDoc() {
    return {
      'todoId': todoId,
      'title': title,
      'desc': desc,
      'isCompleted': isCompleted,
      'priority': priority,
      'assignedAt': assignedAt,
      'completedAt': completedAt,
    };
  }
}
