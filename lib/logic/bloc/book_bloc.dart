import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lib_blocs/data/repository/book_repository.dart';
import 'package:my_lib_blocs/logic/bloc/book_event.dart';
import 'package:my_lib_blocs/logic/bloc/book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository _bookRepository;

  BookBloc(this._bookRepository) : super(LogicInitializeState()) {
    on<AddBookEvent>((event, emit) async {
      emit(AddBookLoading(isLoading: true));
      await _bookRepository.bookProvider.addBookService(event.title, event.description, event.authorId,
              event.genreId, event.autorUi, event.genreUi)
          .then((value) {
        emit(AddBookLoading(isLoading: false));
        /*Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(event.context);
        });*/
        Navigator.pop(event.context);
      }).onError((error, stackTrace) {
        emit(AddBookLoading(isLoading: false));
      });
    });

    on<ReadBookEvent>((event, emit) async {
      emit(LogicloadingState());
      await _bookRepository.bookProvider.readBookService().then((value) {
        emit(ReadBookState(bookModel: value));
      }).onError((error, stackTrace) {
        emit(LogicErrorState(error: error.toString()));
      });
    });

    on<UpdateBookEvent>((event, emit) async {
      emit(UpdateBookLoading(isLoading: true));
      await _bookRepository.bookProvider
          .updateBookService(event.id, event.title, event.description,
              event.authorId, event.genreId, event.autorUi, event.genreUi)
          .then((value) {
        emit(UpdateBookLoading(isLoading: false));
        //snackBar(event.context, "User has been updated");
        /*Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(event.context);
        });*/
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
