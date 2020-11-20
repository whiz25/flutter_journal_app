import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';

class NotesGrid extends StatelessWidget {
  final List<Note> notes;
  const NotesGrid({@required this.notes, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        sliver: SliverGrid(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              final note = notes[index];
              return _buildNoteCard(note);
            }, childCount: notes?.length),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8)),
      );

  Widget _buildNoteCard(Note note) => GestureDetector(
        onTap: () {},
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: note.color,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: Text(
                  note.content,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                )),
                Text(DateFormat.yMd().add_jm().format(note.timestamp), style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600, color: Colors.white),)
              ],
            ),
          ),
        ),
      );
}
