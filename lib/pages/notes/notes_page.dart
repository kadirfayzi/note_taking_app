import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_taking_app/models/note.dart';
import 'package:note_taking_app/pages/notes/add_edit_note.dart';
import 'package:note_taking_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  NotesPageState createState() => NotesPageState();
}

class NotesPageState extends State<NotesPage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(
      builder: (context, notesProvider, _) {
        return notesProvider.isLoading == false
            ? notesProvider.notes.isNotEmpty
                ? notesProvider.getFilteredNotes(searchQuery).isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          children: [
                            TextField(
                              onChanged: (val) => setState(() => searchQuery = val),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  hintText: "Search",
                                  fillColor: Colors.white70),
                            ),
                            const SizedBox(height: 10),
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount: notesProvider.getFilteredNotes(searchQuery).length,
                              itemBuilder: (context, index) {
                                Note currentNote =
                                    notesProvider.getFilteredNotes(searchQuery)[index];

                                return GestureDetector(
                                  onTap: () {
                                    /// Navigate to update note page
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => AddEditNotePage(
                                          isUpdate: true,
                                          note: currentNote,
                                        ),
                                      ),
                                    );
                                  },
                                  onLongPress: () {
                                    /// Delete note
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Delete Note'),
                                        content: const Text(
                                            'Are you sure you want to delete the note ?'),
                                        actions: [
                                          TextButton(
                                            style:
                                                TextButton.styleFrom(foregroundColor: Colors.black),
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text('CANCEL'),
                                          ),
                                          TextButton(
                                            style:
                                                TextButton.styleFrom(foregroundColor: Colors.black),
                                            onPressed: () {
                                              notesProvider.deleteNote(currentNote);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('DELETE'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color:
                                              Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                                                  .withOpacity(1.0),
                                          width: 2),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currentNote.title!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 20),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          currentNote.content!,
                                          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "No notes found!",
                          textAlign: TextAlign.center,
                        ),
                      )
                : const Center(child: Text("No notes yet"))
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
