import 'package:flutter/material.dart';
import 'package:note_taking_app/models/note.dart';
import 'package:note_taking_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class AddEditNotePage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddEditNotePage({Key? key, required this.isUpdate, this.note}) : super(key: key);

  @override
  AddEditNotePageState createState() => AddEditNotePageState();
}

class AddEditNotePageState extends State<AddEditNotePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  final FocusNode noteFocus = FocusNode();

  void addNewNote() {
    Note newNote = Note(
      title: titleController.text,
      content: contentController.text,
      updatedAt: DateTime.now().toIso8601String(),
    );
    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void updateNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    widget.note!.updatedAt = DateTime.now().toIso8601String();
    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    /// If user selects a note item,
    /// fill up the title and content text field with selected note title and content
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
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
                updateNote();
              } else {
                addNewNote();
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
            TextField(
              controller: titleController,
              autofocus: (widget.isUpdate == true) ? false : true,
              onSubmitted: (val) {
                if (val != "") {
                  noteFocus.requestFocus();
                }
              },
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(hintText: "Title", border: InputBorder.none),
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                focusNode: noteFocus,
                maxLines: null,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(hintText: "Note", border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
