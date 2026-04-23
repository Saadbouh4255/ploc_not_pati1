import 'package:flutter/material.dart';

class Note {
  final String id;
  final String titre;
  final String contenu;
  final Color couleur;
  final DateTime dateCreation;
  final DateTime? dateModification;

  Note({
    required this.id,
    required this.titre,
    required this.contenu,
    required this.couleur,
    required this.dateCreation,
    this.dateModification,
  });

  Note copyWith({
    String? id,
    String? titre,
    String? contenu,
    Color? couleur,
    DateTime? dateCreation,
    DateTime? dateModification,
  }) {
    return Note(
      id: id ?? this.id,
      titre: titre ?? this.titre,
      contenu: contenu ?? this.contenu,
      couleur: couleur ?? this.couleur,
      dateCreation: dateCreation ?? this.dateCreation,
      dateModification: dateModification ?? this.dateModification,
    );
  }
}