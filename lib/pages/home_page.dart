import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'notes/add_edit_note.dart';
import 'notes/notes_page.dart';
import 'todos/add_edit_todo.dart';
import 'todos/todos_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Listener(
      ///Whenever the user taps anywhere else it removes the focus and cursor too.
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: _pageIndex == 0 ? const Text("Notes") : const Text("Todos"),
          centerTitle: true,
        ),
        body: _pageIndex == 0 ? const NotesPage() : const TodosPage(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.notes), label: "Notes"),
            BottomNavigationBarItem(icon: Icon(Icons.checklist), label: "Todos"),
          ],
          onTap: (index) => setState(() => _pageIndex = index),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _pageIndex == 0
              ? Navigator.push(
                  context,
                  CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const AddEditNotePage(
                      isUpdate: false,
                    ),
                  ),
                )
              : Navigator.push(
                  context,
                  CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const AddEditTodoPage(
                      isUpdate: false,
                    ),
                  ),
                ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
