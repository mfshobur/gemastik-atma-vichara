import 'package:atma_vichara_gemastik/feature/domain/entities/annual_note.dart';
import 'package:atma_vichara_gemastik/feature/presentation/provider/note_notifier.dart';
import 'package:atma_vichara_gemastik/feature/presentation/provider/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({
    super.key,
    required this.note,
  });

  final AnnualNote? note;

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  String? initialTitle;
  String? initialDescription;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  final FocusNode _descriptionFocusNode = FocusNode();
  bool canSave = false;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.note?.title);
    _descriptionController = TextEditingController(text: widget.note?.description);
    initialTitle = _titleController.text;
    initialDescription = _descriptionController.text;
    canSave = _titleController.text.isNotEmpty || _descriptionController.text.isNotEmpty;
    Provider.of<NoteNotifier>(context, listen: false).clearState();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  void updateTitle() {
    setState(() {
      canSave = _titleController.text.isNotEmpty || _descriptionController.text.isNotEmpty;
    });
  }

  void updateDescription() {
    setState(() {
      canSave = _titleController.text.isNotEmpty || _descriptionController.text.isNotEmpty;
    });
  }

  bool canPop() {
    if (_titleController.text != initialTitle ||
        _descriptionController.text != initialDescription) {
      return false;
    }
    return true;
  }

  void onSave(BuildContext context) {
    // update note
    if (widget.note != null) {
      final updatedNote = widget.note!.copyWith(
        title: _titleController.text,
        description: _descriptionController.text,
      );
      Provider.of<NoteNotifier>(context, listen: false).updateNote(
        updatedNote,
        Provider.of<UserNotifier>(context, listen: false).user!.id,
      );
    } else {
      // add note
      final newNote = AnnualNote(
        id: const Uuid().v4(),
        title: _titleController.text,
        description: _descriptionController.text,
        date: DateTime.now(),
      );
      Provider.of<NoteNotifier>(context, listen: false).addNote(
        newNote,
        Provider.of<UserNotifier>(context, listen: false).user!.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop(),
      onPopInvoked: (didPop) {
        if (didPop) return;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Discard changes?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.go('/note');
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          actions: [
            Consumer<NoteNotifier>(
              builder: (context, value, child) {
                final addState = value.addNoteState;
                final updateState = value.updateNoteState;
                if (addState.stateLoading() || updateState.stateLoading()) {
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 24,
                    height: 24,
                    child: const CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  );
                } else if (addState.stateSuccess() || updateState.stateSuccess()) {
                  Future.microtask(() => context.go('/note'));
                }
                return IconButton(
                  color: canSave ? Colors.black : null,
                  onPressed: () {
                    if (canSave) {
                      onSave(context);
                    }
                  },
                  icon: const Icon(Icons.check),
                );
              },
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            _descriptionFocusNode.requestFocus();
          },
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(DateFormat('EEEE • dd MMMM, yyyy').format(
                          widget.note?.date ?? DateTime.now(),
                        )),
                        const SizedBox(height: 4),
                        TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            hintText: 'Title',
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (_) => updateTitle(),
                        ),
                        // const SizedBox(height: 4),
                        TextField(
                          controller: _descriptionController,
                          focusNode: _descriptionFocusNode,
                          decoration: const InputDecoration(
                            hintText: '',
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          maxLines: null,
                          onChanged: (_) => updateDescription(),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _descriptionFocusNode.requestFocus();
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: 100, // Adjust this height to cover the bottom part
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
