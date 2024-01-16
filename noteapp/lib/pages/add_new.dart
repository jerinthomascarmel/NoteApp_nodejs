// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:noteapp/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../model/note.dart';

class AddNewNote extends StatefulWidget {
  final bool isUpdated;
  final Note? note;
  AddNewNote({super.key, required this.isUpdated, this.note});

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void addNewNote() {
    Note note = Note(
        id: const Uuid().v1(),
        userid: "jerinthomas",
        title: titleController.text,
        content: contentController.text,
        dateadded: DateTime.now());

    Provider.of<NoteProvider>(context, listen: false).addNote(note);
    Navigator.of(context).pop();
  }

  void updateNote() {
    widget.note?.title = titleController.text;
    widget.note?.content = contentController.text;
    widget.note?.dateadded = DateTime.now();
    Provider.of<NoteProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    if (widget.isUpdated) {
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
                if (!widget.isUpdated) {
                  addNewNote();
                } else {
                  updateNote();
                }
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              autofocus: true,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  hintText: 'Title', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: TextFormField(
                controller: contentController,
                maxLines: 10,
                maxLength: 200,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    hintText: 'Content', border: OutlineInputBorder()),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
