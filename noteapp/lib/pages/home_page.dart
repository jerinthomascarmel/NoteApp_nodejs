import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/pages/add_new.dart';
import 'package:noteapp/providers/notes_provider.dart';
import 'package:provider/provider.dart';

import '../model/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NoteProvider noteProvider = Provider.of<NoteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note App"),
        centerTitle: true,
      ),
      body: (noteProvider.isLoading == false)
          ? SafeArea(
              child: (noteProvider.notes.isNotEmpty)
                  ? GridView.count(
                      padding: const EdgeInsets.all(5),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: List.generate(
                        noteProvider.notes.length,
                        (index) {
                          Note currentNote = noteProvider.notes[index];
                          return GestureDetector(
                            onTap: () {
                              //update
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) => AddNewNote(
                                      isUpdated: true,
                                      note: currentNote,
                                    ),
                                  ));
                            },
                            onLongPress: () {
                              //delete
                              noteProvider.deleteNote(currentNote);
                            },
                            child: Container(
                              // margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 75, 73, 73))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      currentNote.title!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        currentNote.content!,
                                        maxLines: 5,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Color.fromARGB(
                                                255, 113, 99, 99),
                                            fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(child: Text("No Notes yet!")))
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => AddNewNote(isUpdated: false),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
