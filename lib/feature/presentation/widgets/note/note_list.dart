import 'package:atma_vichara_gemastik/feature/domain/entities/annual_note.dart';
import 'package:atma_vichara_gemastik/feature/presentation/widgets/note/note_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteList extends StatefulWidget {
  const NoteList({
    super.key,
    required this.notes,
  });

  final List<AnnualNote> notes;

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  List<DateTime> noteDate = [];

  @override
  void initState() {
    widget.notes.sort((a, b) => a.date.compareTo(b.date));
    for (var note in widget.notes) {
      if (!noteDate.contains(DateTime(note.date.year, note.date.month))) {
        noteDate.add(DateTime(note.date.year, note.date.month));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: noteDate.map((date) {
      final notes = widget.notes
          .where((note) => note.date.year == date.year && note.date.month == date.month)
          .toList();
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                DateFormat('MMMM yyyy').format(date),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ...notes.map(
              (e) => NoteTile(note: e),
            ),
          ],
        ),
      );
    }).toList());
  }
}
