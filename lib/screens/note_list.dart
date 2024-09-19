import 'package:flutter/material.dart';
import 'package:sqflite_example/note_model.dart';
import 'package:sqflite_example/screens/add_note.dart';
import 'package:sqflite_example/services/database_service.dart';

class NoteLists extends StatefulWidget {
  const NoteLists({super.key});

  @override
  State<NoteLists> createState() => _NoteListsState();
}

class _NoteListsState extends State<NoteLists> {
  int count = 10;
  onDelete() {
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink,
          tooltip: "Add Note",
          elevation: 0,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const AddNote()));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: const Text("Notes"),
        ),
        body: FutureBuilder(
            future: DatabaseService.instance.getNotes(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  NoteModel notes = snapshot.data![index];
                  return ListTile(
                    leading: notes.prioroty == "High"
                        ? const CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                            ),
                          )
                        : const CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            ),
                          ),
                    title: Text(notes.heading),
                    subtitle: Text(notes.description),
                  );
                },
              );
            }));
  }
}
