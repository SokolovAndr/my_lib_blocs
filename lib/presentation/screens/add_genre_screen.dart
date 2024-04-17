import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/snack_bar.dart';
import '../../logic/bloc/genre_bloc.dart';
import '../../logic/bloc/genre_event.dart';
import '../../logic/bloc/genre_state.dart';

class AddGenreScreen extends StatefulWidget {
  const AddGenreScreen({super.key});

  @override
  State<AddGenreScreen> createState() => _AddGenreScreenState();
}

class _AddGenreScreenState extends State<AddGenreScreen> {
  final TextEditingController _genreNameCtrl = TextEditingController();

  @override
  void dispose() {
    _genreNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить жанр'),
      ),
      body: _buildBody,
    );
  }

  Widget get _buildBody {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: _genreNameCtrl,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Название"),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(onPressed: () {
          if (_genreNameCtrl.text.isEmpty) {
            snackBar(context, "Введите название");
          } else {
            context.read<GenreBloc>().add(
                AddGenreEvent(name: _genreNameCtrl.text, context: context));
          }
        }, child:
            BlocBuilder<GenreBloc, GenreState>(builder: (context, state) {
          if (state is AddGenreLoading) {
            bool isLoading = state.isLoading;
            return isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text("Добавить жанр");
          } else {
            return const Text("Добавить жанр");
          }
        }))
      ],
    );
  }
}
