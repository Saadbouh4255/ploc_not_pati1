import 'package:flutter/material.dart';
import '../models/note.dart';
import 'create_page.dart';

class DetailPage extends StatelessWidget {
  final Note note;

  const DetailPage({super.key, required this.note});

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year} à "
        "${date.hour.toString().padLeft(2, '0')}:"
        "${date.minute.toString().padLeft(2, '0')}";
  }

  Future<void> _modifierNote(BuildContext context) async {
    final Note? noteModifiee = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatePage(note: note),
      ),
    );

    if (noteModifiee != null && context.mounted) {
      Navigator.pop(context, noteModifiee);
    }
  }

  Future<void> _supprimerNote(BuildContext context) async {
    final bool? confirmation = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Voulez-vous vraiment supprimer cette note ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirmation == true && context.mounted) {
      Navigator.pop(context, 'deleted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail Note'),
        backgroundColor: note.couleur,
        actions: [
          IconButton(
            onPressed: () => _modifierNote(context),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () => _supprimerNote(context),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.titre,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Créée le ${_formatDate(note.dateCreation)}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            if (note.dateModification != null) ...[
              const SizedBox(height: 6),
              Text(
                'Modifiée le ${_formatDate(note.dateModification!)}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  note.contenu,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}