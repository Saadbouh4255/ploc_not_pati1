import 'package:flutter/material.dart';
import '../models/note.dart';

class CreatePage extends StatefulWidget {
  final Note? note;

  const CreatePage({super.key, this.note});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _contenuController = TextEditingController();

  final List<Color> _colors = [
    Colors.amber,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange,
  ];

  Color _selectedColor = Colors.amber;

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      _titreController.text = widget.note!.titre;
      _contenuController.text = widget.note!.contenu;
      _selectedColor = widget.note!.couleur;
    }
  }

  @override
  void dispose() {
    _titreController.dispose();
    _contenuController.dispose();
    super.dispose();
  }

  void _sauvegarderNote() {
    final String titre = _titreController.text.trim();
    final String contenu = _contenuController.text.trim();

    if (titre.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Le titre est obligatoire'),
        ),
      );
      return;
    }

    final now = DateTime.now();

    final note = Note(
      id: widget.note?.id ?? now.millisecondsSinceEpoch.toString(),
      titre: titre,
      contenu: contenu,
      couleur: _selectedColor,
      dateCreation: widget.note?.dateCreation ?? now,
      dateModification: widget.note != null ? now : null,
    );

    Navigator.pop(context, note);
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.note != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Modifier une note' : 'Nouvelle note'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titreController,
              maxLength: 60,
              decoration: const InputDecoration(
                labelText: 'Titre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contenuController,
              minLines: 4,
              maxLines: 10,
              decoration: const InputDecoration(
                labelText: 'Contenu',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Choisir une couleur',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: _colors.map((color) {
                final bool isSelected = _selectedColor == color;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _sauvegarderNote,
                child: const Text('Sauvegarder'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}