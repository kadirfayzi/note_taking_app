import 'package:flutter/cupertino.dart';
import 'package:note_taking_app/models/note.dart';
import 'package:note_taking_app/services/api_service.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading = true;
  List<Note> notes = [];

  NotesProvider() {
    fetchNotes();
  }

  /// Get filtered notes by given search query
  List<Note> getFilteredNotes(String searchQuery) => notes
      .where((element) =>
          element.title!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          element.content!.toLowerCase().contains(searchQuery.toLowerCase()))
      .toList();

  /// Sort notes by created/updated datetime
  void sortNotes() => notes.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));

  void addNote(Note note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Note note) {
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    sortNotes();
    notifyListeners();
    ApiService.updateNote(note);
  }

  void deleteNote(Note note) {
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiService.deleteNote(note.id!);
  }

  void fetchNotes() async {
    notes = await ApiService.fetchNotes();
    sortNotes();
    isLoading = false;
    notifyListeners();
  }
}
