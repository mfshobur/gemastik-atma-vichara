import 'package:atma_vichara_gemastik/core/constants.dart';
import 'package:atma_vichara_gemastik/feature/domain/entities/annual_note.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.note,
  });

  final AnnualNote note;

  @override
  Widget build(BuildContext context) {
    bool titleEmpty = note.title.isEmpty;

    return GestureDetector(
      onTap: () => context.go('/note/edit', extra: note),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 27),
        decoration: BoxDecoration(
          color: kNotesBackgroundTileColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateFormat('EEE').format(note.date).toUpperCase(),
                  style: const TextStyle(
                    fontSize: 13,
                    // fontWeight: kFontweightSemiBold,
                    height: 0.5,
                  ),
                ),
                Text(
                  DateFormat('dd').format(note.date),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: kFontweightSemiBold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                titleEmpty ? note.description : note.title,
                style: const TextStyle(
                  fontSize: 20,
                  // fontWeight: kFontweightSemiBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
