import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lib_blocs/data/model/author_model.dart';
import 'package:my_lib_blocs/data/model/book_model.dart';
import '../../constants/snack_bar.dart';
import '../../data/model/genre_model.dart';
import '../../logic/bloc/book_bloc.dart';
import '../../logic/bloc/book_event.dart';
import '../../logic/bloc/book_state.dart';
import 'authors_choose_screen.dart';
import 'genres_choose_screen.dart';

class UpdateBookScreen extends StatefulWidget {
  final int id;
  final String title;
  final String description;
  final int authorId;
  final int genreId;
  final Ui autorUi;
  final Ui genreUi;

  const UpdateBookScreen(
      {super.key,
      required this.id,
      required this.title,
      required this.description,
      required this.authorId,
      required this.genreId,
      required this.autorUi,
      required this.genreUi});

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
    _bookAuthorIdCtrl = TextEditingController(text: widget.autorUi.name);
    _bookGenreIdCtrl = TextEditingController(text: widget.genreUi.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DataAuthor? author = DataAuthor(id: 0, name: "");
    DataGenre? genre = DataGenre(id: 0, name: "");

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
              readOnly: true,
              controller: _bookAuthorIdCtrl,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Автор",
                  labelText: author.name),
              onTap: () async {
                author = await Navigator.push<DataAuthor>(context,
                    MaterialPageRoute(builder: (context) {
                  return const AuthorsChooseScreen();
                }));
                _bookAuthorIdCtrl.text = author?.name ?? "";
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              readOnly: true,
              controller: _bookGenreIdCtrl,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Жанр",
                  labelText: genre.name),
              onTap: () async {
                genre = await Navigator.push<DataGenre>(context,
                    MaterialPageRoute(builder: (context) {
                  return const GenresChooseScreen();
                }));
                _bookGenreIdCtrl.text = genre?.name ?? "";
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          //___________ЗДЕСЬ КОД
          ElevatedButton(
            onPressed: () async {
              if (_bookTitleCtrl.text.isEmpty ||
                  _bookDescriptionCtrl.text.isEmpty ||
                  _bookAuthorIdCtrl.text.isEmpty ||
                  _bookGenreIdCtrl.text.isEmpty) {
                snackBar(context, "Введите все данные");
              } else {
                context.read<BookBloc>().add(UpdateBookEvent(context,
                    id: widget.id.toString(),
                    title: _bookTitleCtrl.text,
                    description: _bookDescriptionCtrl.text,
                    authorId: author!.id,
                    genreId: genre!.id,
                    autorUi: author!,
                    genreUi: genre!));
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
