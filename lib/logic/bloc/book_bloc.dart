import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lib_blocs/data/model/book_data_model.dart';
import 'package:my_lib_blocs/data/model/book_model.dart';
import 'package:my_lib_blocs/data/repository/book_repository.dart';
import 'package:my_lib_blocs/logic/bloc/book_event.dart';
import 'package:my_lib_blocs/logic/bloc/book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository _bookRepository;
  late BookDataModel booksData;

  BookBloc(this._bookRepository) : super(LogicInitializeState()) {
    on<AddBookEvent>((event, emit) async {
      emit(AddBookLoading(isLoading: true));
      await _bookRepository.bookProvider
          .addBookService(
              event.title,
              event.description,
              event.authorId,
              event.genreId,
              event.imageId,
              event.autorUi,
              event.genreUi,
              event.imageUi)
          .then((value) {
        emit(AddBookLoading(isLoading: false));
        Navigator.pop(event.context);
      }).onError((error, stackTrace) {
        emit(AddBookLoading(isLoading: false));
      });
    });

    BookDataModel getDataFromApi(BookModel model) {
      return BookDataModel(
          categories: model.dataBook.map((e) => e.genreUi.name).toSet(),
          books: model.dataBook);
    }

    on<ReadBookEvent>((event, emit) async {
      emit(LogicloadingState());
      await _bookRepository.bookProvider.readBookService().then((value) {
        booksData = getDataFromApi(value);
        emit(ReadBookState(data: getDataFromApi(value)));
      }).onError((error, stackTrace) {
        emit(LogicErrorState(error: error.toString()));
      });
    });

    on<ReadFilterBookEvent>((event, emit) async {
      emit(LogicloadingState());
      final filteredBooks = booksData.books
          .where((book) => event.currentFilters.contains(book.genreUi.name))
          .toList();
      final allBooks = booksData.books;
      if (filteredBooks.isEmpty) {
        emit(
          ReadBookState(
              data: BookDataModel(
            books: allBooks,
            categories: booksData.categories,
          )),
        );
      } else {
        emit(
          ReadBookState(
              data: BookDataModel(
            books: filteredBooks,
            categories: booksData.categories,
          )),
        );
      }
    });

    on<UpdateBookEvent>((event, emit) async {
      emit(UpdateBookLoading(isLoading: true));
      await _bookRepository.bookProvider
          .updateBookService(
              event.id,
              event.title,
              event.description,
              event.authorId,
              event.genreId,
              event.imageId,
              event.autorUi,
              event.genreUi,
              event.imageUi)
          .then((value) {
        emit(UpdateBookLoading(isLoading: false));
        Navigator.pop(event.context);
      }).onError((error, stackTrace) {
        emit(UpdateBookLoading(isLoading: false));
      });
    });

    on<DeleteBookEvent>((event, emit) async {
      emit(DeleteBookLoading(isLoading: true));
      await _bookRepository.bookProvider
          .deleteBookService(event.id)
          .then((value) {
        emit(DeleteBookLoading(isLoading: false));
      }).onError((error, stackTrace) {
        emit(DeleteBookLoading(isLoading: false));
      });
    });
  }
}
