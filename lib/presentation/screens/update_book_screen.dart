import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/snack_bar.dart';
import '../../logic/bloc/book_bloc.dart';
import '../../logic/bloc/book_event.dart';
import '../../logic/bloc/book_state.dart';

class UpdateBookScreen extends StatefulWidget {
  final int id;
  final String title;
  final String description;
  final int authorId;
  final int genreId;

  const UpdateBookScreen(
      {super.key,
      required this.id,
      required this.title,
      required this.description,
      required this.authorId,
      required this.genreId});

  @override
  State<UpdateBookScreen> createState() => _UpdateBookScreenState();
}

class _UpdateBookScreenState extends State<UpdateBookScreen> {
  late final TextEditingController _bookTitleCtrl;
  late final TextEditingController _bookDescriptionCtrl;
  late final TextEditingController _bookAuthorIdCtrl;
  late final TextEditingController _bookGenreIdCtrl;

  @override
  void initState() {
    _bookTitleCtrl = TextEditingController(text: widget.title);
    _bookDescriptionCtrl = TextEditingController(text: widget.description);
    _bookAuthorIdCtrl = TextEditingController(text: widget.authorId.toString());
    _bookGenreIdCtrl = TextEditingController(text: widget.genreId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Обновить книгу"),
      ),
      body: Column(
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
          ElevatedButton(
            onPressed: () async  {
              if (_bookTitleCtrl.text.isEmpty ||
              _bookDescriptionCtrl.text.isEmpty ||
              _bookAuthorIdCtrl.text.isEmpty ||
              _bookGenreIdCtrl.text.isEmpty) {
                snackBar(context, "Введите все данные");
              } else {
                context.read<BookBloc>().add(UpdateBookEvent(context,
                    id: widget.id.toString(), title: _bookTitleCtrl.text, description: _bookDescriptionCtrl.text, authorId: _bookAuthorIdCtrl.text, genreId: _bookGenreIdCtrl.text));
                    context.read<BookBloc>().add(ReadBookEvent());
              }
            },
            child: BlocBuilder<BookBloc, BookState>(
              builder: (context, state) {
                if (state is UpdateBookLoading) {
                  bool isLoading = state.isLoading;
                  return isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Обновить книгу");
                } else {
                  return const Text("Обновить книгу");
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
