import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lib_blocs/data/model/book_model.dart';
import 'package:my_lib_blocs/logic/bloc/book_bloc.dart';
import '../../logic/bloc/book_event.dart';
import '../../logic/bloc/book_state.dart';
import 'add_book_screen.dart';
import 'update_book_screen.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  @override
  void initState() {
    context.read<BookBloc>().add(ReadBookEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Книги"),
      ),
      body: _buildBody,
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddBookScreen()));
            Future.delayed(const Duration(milliseconds: 5), () {
              context.read<BookBloc>().add(ReadBookEvent());
            });
          },
          child: const Icon(Icons.add)),
    );
  }

  Widget get _buildBody {
    return BlocBuilder<BookBloc, BookState>(builder: (context, state) {
      if (state is LogicInitializeState || state is LogicloadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is LogicErrorState) {
        String err = state.error;
        return Center(
          child: Text(err),
        );
      } else if (state is ReadBookState) {
        List<DataBook> bookList = state.bookModel.dataBook;
        var data = state.bookModel;

        return bookList.isNotEmpty
            ? _buildListView(data)
            : const Center(child: Text("Список пуст"));
      } else {
        return Container();
      }
    });
  }

  Widget _buildListView(BookModel bookModel) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<BookBloc>().add(ReadBookEvent());
      },
      child: ListView.builder(
          itemCount: bookModel.dataBook.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return UpdateBookScreen(
                      id: bookModel.dataBook[index].id,
                      title: bookModel.dataBook[index].title,
                      description: bookModel.dataBook[index].description,
                      authorId: bookModel.dataBook[index].authorId,
                      genreId: bookModel.dataBook[index].genreId,
                      autorUi: bookModel.dataBook[index].autorUi,
                      genreUi: bookModel.dataBook[index].genreUi);
                }));
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  bookModel.dataBook[index].id.toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const PaddingWidget(),
                              Text(
                                bookModel.dataBook[index].title,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              const PaddingWidget(),
                              Text(
                                bookModel.dataBook[index].description,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              const PaddingWidget(),
                              Text(
                                bookModel.dataBook[index].autorUi.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              const PaddingWidget(),
                              Text(
                                bookModel.dataBook[index].genreUi.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: IconButton(
                            onPressed: () async {
                              context.read<BookBloc>().add(DeleteBookEvent(
                                  id: bookModel.dataBook[index].id.toString()));
                              context.read<BookBloc>().add(ReadBookEvent());
                            },
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class PaddingWidget extends StatelessWidget {
  const PaddingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      child: Divider(
        thickness: 1,
      ),
    );
  }
}
