import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_taking_app/pages/todos/add_edit_todo.dart';
import 'package:note_taking_app/providers/todos_provider.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../models/todo.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodosProvider>(
      builder: (context, todosProvider, _) {
        return todosProvider.isLoading == false
            ? todosProvider.todos.isNotEmpty
                ? ListView.builder(
                    itemCount: todosProvider.todos.length,
                    itemBuilder: (context, index) {
                      Todo currentTodo = todosProvider.todos[index];

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                                  .withOpacity(1.0),
                              width: 1.5),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 0.5,
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: IconButton(
                            icon: Icon(
                              currentTodo.completed! ? Icons.check_circle : Icons.circle_outlined,
                              color: Colors.blue,
                              size: 30,
                            ),
                            onPressed: () {
                              if (currentTodo.completed!) {
                                currentTodo.completed = false;
                              } else {
                                currentTodo.completed = true;
                              }
                              todosProvider.updateTodo(currentTodo);
                            },
                          ),
                          title: Text(
                            todosProvider.todos[index].content!,
                            style: currentTodo.completed!
                                ? const TextStyle(decoration: TextDecoration.lineThrough)
                                : null,
                          ),
                          onTap: () {
                            /// Navigate to update todo page
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => AddEditTodoPage(
                                  isUpdate: true,
                                  todo: currentTodo,
                                ),
                              ),
                            );
                          },
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Todo'),
                                content: const Text('Are you sure you want to delete the todo ?'),
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('CANCEL'),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                                    onPressed: () {
                                      todosProvider.deleteTodo(currentTodo);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('DELETE'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  )
                : const Center(child: Text("No todos yet"))
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
