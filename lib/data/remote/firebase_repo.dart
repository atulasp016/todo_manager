import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_manager/domain/models/todo_model.dart';

class FirebaseRepo {
  static var mFireStore = FirebaseFirestore.instance;
  static String collectionToDo = 'todos';

  /// add todo
  static void addTodo(TodoModel todo) {
    mFireStore.collection(collectionToDo).add(todo.toDoc()).then((value) {
      mFireStore
          .collection(collectionToDo)
          .doc(value.id)
          .update({'todoId': value.id});
    }).onError(((error, stackTrace) {}));
  }

  /// add todo
  static void markTodoStatus(String todoId, bool status) {
    String currTime = '';
    if (status) {
      currTime = DateTime.now().millisecondsSinceEpoch.toString();
    }
    mFireStore
        .collection(collectionToDo)
        .doc(todoId)
        .update({'isCompleted': status, 'completedAt': currTime});
  }

  ///update todo
  static Future<void> updateToDo(TodoModel updateTodo) {
    return mFireStore
        .collection(collectionToDo)
        .doc(updateTodo.todoId)
        .update(updateTodo.toDoc());
  }

  ///update todo
  static Future<void> deleteToDo(TodoModel deleteTodo) {
    return mFireStore
        .collection(collectionToDo)
        .doc(deleteTodo.todoId)
        .delete();
  }

  /// fetch all todo

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllTodo() {
    return mFireStore.collection(collectionToDo).snapshots();
  }
}
