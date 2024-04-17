import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lib_blocs/logic/bloc/book_bloc.dart';
import '../../constants/snack_bar.dart';
import '../../logic/bloc/book_event.dart';
import '../../logic/bloc/book_state.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController _bookTitleCtrl = TextEditingController();
  final TextEditingController _bookDescriptionCtrl = TextEditingController();
  final TextEditingController _bookAuthorIdCtrl = TextEditingController();
  final TextEditingController _bookGenreIdCtrl = TextEditingController();

  @override
  void dispose() {
    _bookTitleCtrl.dispose();
    _bookDescriptionCtrl.dispose();
    _bookAuthorIdCtrl.dispose();
    _bookGenreIdCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить книгу'),
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
            controller: _bookTitleCtrl,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: _bookDescriptionCtrl,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Описание"),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: _bookAuthorIdCtrl,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Автор"),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: _bookGenreIdCtrl,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Жанр"),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(onPressed: () {
          if (_bookTitleCtrl.text.isEmpty ||
              _bookDescriptionCtrl.text.isEmpty ||
              _bookAuthorIdCtrl.text.isEmpty ||
              _bookGenreIdCtrl.text.isEmpty) {
            snackBar(context, "Введите все данные");
          } else {
            context.read<BookBloc>().add(AddBookEvent(
                context: context,
                title: _bookTitleCtrl.text,
                description: _bookDescriptionCtrl.text,
                authorId: _bookAuthorIdCtrl.text,
                genreId: _bookGenreIdCtrl.text));
          }
        }, child: BlocBuilder<BookBloc, BookState>(builder: (context, state) {
          if (state is AddBookLoading) {
            bool isLoading = state.isLoading;
            return isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text("Добавить книгу");
          } else {
            return const Text("Добавить книгу");
          }
        }))
      ],
    );
  }
}
