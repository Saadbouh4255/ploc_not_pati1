import 'package:flutter/material.dart';
import '../models/note.dart';
import 'create_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Note> _notes = [];

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year} à "
        "${date.hour.toString().padLeft(2, '0')}:"
        "${date.minute.toString().padLeft(2, '0')}";
  }

  Future<void> _ajouterNote() async {
    final Note? nouvelleNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreatePage(),
      ),
    );

    if (nouvelleNote != null) {
      setState(() {
        _notes.add(nouvelleNote);
      });
    }
  }

  Future<void> _ouvrirDetail(Note note, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(note: note),
      ),
    );

    if (result == null) return;

    if (result is Note) {
      setState(() {
        _notes[index] = result;
      });
    } else if (result == 'deleted') {
      setState(() {
        _notes.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Notes'),
        centerTitle: true,
      ),
      body: _notes.isEmpty
          ? const Center(
        child: Text(
          'Aucune note',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: InkWell(
              onTap: () => _ouvrirDetail(note, index),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: note.couleur,
                      width: 8,
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    note.titre,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.contenu.length > 30
                              ? "${note.contenu.substring(0, 30)}..."
                              : note.contenu,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _formatDate(note.dateCreation),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _ajouterNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}