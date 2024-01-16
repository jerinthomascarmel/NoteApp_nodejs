import 'dart:convert';
import '../model/note.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  // static String _baseUrl = "http://localhost:5000/notes";
  static String baseUrl = "http://10.0.2.2:5000/notes";

  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse("$baseUrl/add");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    print(decoded.toString());
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse("$baseUrl/delete");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    print(decoded.toString());
  }

  static Future<List<Note>> fetchNotes(String userid) async {
    Uri requestUri = Uri.parse("$baseUrl/list");
    var response = await http.post(requestUri, body: {"userid": userid});
    var decoded = jsonDecode(response.body);
    List<Note> notes = [];
    for (var element in decoded) {
      Note curr = Note.fromMap(element);
      notes.add(curr);
    }
    // print(decoded);
    return notes;
  }
}
