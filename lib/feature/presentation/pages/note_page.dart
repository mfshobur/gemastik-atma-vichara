import 'package:atma_vichara_gemastik/core/constants.dart';
import 'package:atma_vichara_gemastik/feature/presentation/provider/note_notifier.dart';
import 'package:atma_vichara_gemastik/feature/presentation/widgets/note/note_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final notes = [
    //   AnnualNote(
    //     id: 'id',
    //     title: 'title',
    //     description: 'description',
    //     date: DateTime.now(),
    //   ),
    //   AnnualNote(
    //     id: 'id',
    //     title: 'title',
    //     description: 'description',
    //     date: DateTime.now(),
    //   ),
    //   AnnualNote(
    //     id: 'id',
    //     title: 'title',
    //     description: 'description',
    //     date: DateTime.now(),
    //   ),
    // ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () => context.go(
          '/note/edit',
        ),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: kFontweightBold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Consumer<NoteNotifier>(
                builder: (context, value, child) => NoteList(notes: value.notes),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
