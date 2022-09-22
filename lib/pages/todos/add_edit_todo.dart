import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/todo.dart';
import '../../providers/todos_provider.dart';

class AddEditTodoPage extends StatefulWidget {
  final bool isUpdate;
  final Todo? todo;
  const AddEditTodoPage({Key? key, required this.isUpdate, this.todo}) : super(key: key);

  @override
  AddEditTodoPageState createState() => AddEditTodoPageState();
}

class AddEditTodoPageState extends State<AddEditTodoPage> {
  TextEditingController contentController = TextEditingController();
  FocusNode todoFocus = FocusNode();

  void addNewTodo() {
    Todo newTodo = Todo(
        content: contentController.text,
        completed: false,
        updatedAt: DateTime.now().toIso8601String());
    Provider.of<TodosProvider>(context, listen: false).addTodo(newTodo);
    Navigator.pop(context);
  }

  void updateTodo() {
    widget.todo!.content = contentController.text;
    widget.todo!.updatedAt = DateTime.now().toIso8601String();
    Provider.of<TodosProvider>(context, listen: false).updateTodo(widget.todo!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    /// If user selects a todo item,
    /// fill up the content text field with selected todo content
    if (widget.isUpdate) {
      contentController.text = widget.todo!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (widget.isUpdate) {
                updateTodo();
              } else {
                addNewTodo();
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: contentController,
                focusNode: todoFocus,
                maxLines: null,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(hintText: "Todo", border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
