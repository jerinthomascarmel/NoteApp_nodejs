import 'package:flutter/widgets.dart';
import 'package:noteapp/services/api_services.dart';
import '../model/note.dart';

class NoteProvider with ChangeNotifier {
  bool isLoading = true;
  List<Note> notes = [];

  NoteProvider() {
    fetchNotes();
  }

  void sortNotes() {
    notes.sort((a, b) => b.dateadded!.compareTo(a.dateadded!));
  }

  void addNote(Note note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiServices.addNote(note);
  }

  void updateNote(Note note) {
    int index =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[index] = note;
    sortNotes();
    notifyListeners();
    ApiServices.addNote(note);
  }

  void deleteNote(Note note) {
    int index =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(index);
    sortNotes();
    notifyListeners();
    ApiServices.deleteNote(note);
  }

  void fetchNotes() async {
    notes.clear();
    notes = await ApiServices.fetchNotes("jerinthomas");
    isLoading = false;
    sortNotes();
    notifyListeners();
  }
}
