import 'dart:convert';
import 'dart:developer';

import 'package:note_taking_app/models/note.dart';
import 'package:http/http.dart' as http;

import '../models/todo.dart';

class ApiService {
  static const String _baseUrl = "http://10.0.2.2:3001";

  /// /// /// Notes api services /// /// ///

  /// Create note
  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse("$_baseUrl/notes");
    var response = await http.post(
      requestUri,
      body: note.toJson(),
    );
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  /// Update selected note
  static Future<void> updateNote(Note note) async {
    Uri requestUri = Uri.parse("$_baseUrl/notes/${note.id}");
    var response = await http.put(
      requestUri,
      body: note.toJson(),
    );
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  /// Delete selected note
  static Future<void> deleteNote(int id) async {
    Uri requestUri = Uri.parse("$_baseUrl/notes/$id");
    var response = await http.delete(requestUri);
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  /// Get all notes
  static Future<List<Note>> fetchNotes() async {
    Uri requestUri = Uri.parse("$_baseUrl/notes");
    var response = await http.get(requestUri);

    var decoded = jsonDecode(response.body);
    List<Note> notes = [];

    for (var noteJson in decoded) {
      Note newNote = Note.fromJson(noteJson);
      notes.add(newNote);
    }

    return notes;
  }

  /// /// /// ToDos api services /// /// ///

  /// Create todo
  static Future<void> addTodo(Todo todo) async {
    Uri requestUri = Uri.parse("$_baseUrl/todos");
    var response = await http.post(
      requestUri,
      body: todo.toJson(),
    );
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  /// Update selected todo
  static Future<void> updateTodo(Todo todo) async {
    Uri requestUri = Uri.parse("$_baseUrl/todos/${todo.id}");
    var response = await http.put(
      requestUri,
      body: todo.toJson(),
    );
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  /// Delete selected todo
  static Future<void> deleteTodo(int id) async {
    Uri requestUri = Uri.parse("$_baseUrl/todos/$id");
    var response = await http.delete(requestUri);
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  /// Get all todos
  static Future<List<Todo>> fetchTodos() async {
    Uri requestUri = Uri.parse("$_baseUrl/todos");
    var response = await http.get(requestUri);
    var decoded = jsonDecode(response.body);

    List<Todo> todos = [];
    for (var todoJson in decoded) {
      Todo newTodo = Todo.fromJson(todoJson);
      todos.add(newTodo);
    }

    return todos;
  }
}
