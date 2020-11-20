import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/notes/notes_bloc.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) => BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {},
        builder: (context, authState) => Scaffold(
            body: BlocBuilder<NotesBloc, NotesState>(
                builder: (context, notesState) =>
                    _buildBody(context, authState, notesState)),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                
              },
              backgroundColor: Colors.black,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )),
      );

  Stack _buildBody(
          BuildContext context, AuthState authState, NotesState notesState) =>
      Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.white,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text(
                    'Journal',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                leading: authState is Authenticated
                    ? IconButton(
                        icon: const Icon(
                          Icons.exit_to_app,
                          size: 28,
                          color: Colors.black,
                        ),
                        onPressed: () {})
                    : IconButton(
                        icon: const Icon(
                          Icons.account_circle,
                          color: Colors.black,
                          size: 28,
                        ),
                        onPressed: () {}),
                actions: [
                  IconButton(
                      icon: const Icon(
                        Icons.brightness_6,
                        color: Colors.black,
                        size: 28,
                      ),
                      onPressed: () {})
                ],
              ),
              if (notesState is NotesLoaded) NotesGrid(notes: notesState.notes)
            ],
          )
        ],
      );
}
