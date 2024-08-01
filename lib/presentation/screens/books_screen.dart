import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:my_lib_blocs/data/model/book_data_model.dart';
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
        actions: [
          TextButton(
              onPressed: clearCache,
              child: const Text(
                'Очистить кэш',
                style: TextStyle(color: Colors.black),
              ))
        ],
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
        List<DataBook> bookList = state.data.books;
        return bookList.isNotEmpty
            ? _buildListView(state.data)
            : const Center(child: Text("Список пуст"));
      } else {
        return Container();
      }
    });
  }

  List<String> selectedGenres = [];

  Widget _buildListView(BookDataModel bookData) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<BookBloc>().add(ReadBookEvent());
        selectedGenres.clear();
      },
      child: Column(
        children: [
          SizedBox(
              height: 45,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: bookData.categories
                      .map(
                        (genre) => Padding(
                          padding: const EdgeInsets.all(5),
                          child: FilterChip(
                              selected: selectedGenres.contains(genre),
                              label: Text(genre),
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    selectedGenres.add(genre);
                                  } else {
                                    selectedGenres.remove(genre);
                                  }
                                });
                                context.read<BookBloc>().add(ReadFilterBookEvent(
                                        currentFilters: selectedGenres,
                                      ),
                                    );
                              }),
                        ),
                      )
                      .toList(),
                ),
              )),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: bookData.books.length,
                itemBuilder: (context, index) {
                  final DataBook book = bookData.books[index];

                  return GestureDetector(
                    onTap: () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return UpdateBookScreen(
                            id: book.id,
                            title: book.title,
                            description: book.description,
                            authorId: book.authorId,
                            genreId: book.genreId,
                            imageId: book.imageId,
                            autorUi: book.autorUi,
                            genreUi: book.genreUi,
                            imageUi: book.imageUi);
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 150,
                                child: buildImage(book.imageId),
                              ),
                              const SizedBox(width: 25),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.title,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const PaddingWidget(),
                                    Text(
                                      book.description,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const PaddingWidget(),
                                    Text(
                                      book.autorUi.name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const PaddingWidget(),
                                    Text(
                                      book.genreUi.name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: IconButton(
                                  onPressed: () async {
                                    context.read<BookBloc>().add(
                                        DeleteBookEvent(
                                            id: book.id.toString()));
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
          ),
        ],
      ),
    );
  }

  Widget buildImage(int index) => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          key: UniqueKey(),
          imageUrl: 'http://10.0.2.2:5080/Image/File$index',
          height: 50,
          width: 50,
          fit: BoxFit.cover,
          maxHeightDiskCache: 75,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Container(
            color: Colors.black12,
            child: const Icon(Icons.error, color: Colors.red),
          ),
        ),
      );

  void clearCache() {
    DefaultCacheManager().emptyCache();
    imageCache.clear();
    imageCache.clearLiveImages();
    setState(() {});
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
