import 'package:flutter/cupertino.dart';
import 'package:note_taking_app/services/api_service.dart';
import '../models/todo.dart';

class TodosProvider with ChangeNotifier {
  bool isLoading = true;
  List<Todo> todos = [];

  TodosProvider() {
    fetchTodos();
  }

  /// Sort todos by created/updated datetime
  void sortTodos() => todos.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));

  /// Sort todos by its boolean "completed" field
  void sortByCompleted() => todos.sort((a, b) {
        if (a.completed!) {
          return 1;
        }
        return -1;
      });

  void addTodo(Todo todo) {
    todos.add(todo);
    sortTodos();
    sortByCompleted();
    notifyListeners();
    ApiService.addTodo(todo);
  }

  void updateTodo(Todo todo) {
    int indexOfTodo = todos.indexOf(todos.firstWhere((element) => element.id == todo.id));
    todos[indexOfTodo] = todo;
    sortTodos();
    sortByCompleted();
    notifyListeners();
    ApiService.updateTodo(todo);
  }

  void deleteTodo(Todo todo) {
    int indexOfTodo = todos.indexOf(todos.firstWhere((element) => element.id == todo.id));
    todos.removeAt(indexOfTodo);
    sortTodos();
    sortByCompleted();
    notifyListeners();
    ApiService.deleteTodo(todo.id!);
  }

  void fetchTodos() async {
    todos = await ApiService.fetchTodos();
    sortTodos();
    sortByCompleted();
    isLoading = false;
    notifyListeners();
  }
}
