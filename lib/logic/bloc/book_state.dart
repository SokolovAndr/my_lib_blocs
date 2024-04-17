import 'package:my_lib_blocs/data/model/book_model.dart';

abstract class BookState {}

class LogicInitializeState extends BookState {}

class LogicErrorState extends BookState {
  final String error;
  LogicErrorState({required this.error});
}

class LogicloadingState extends BookState {}

class ReadBookState extends BookState {
  final BookModel bookModel;
  ReadBookState({required this.bookModel});
}

class AddBookLoading extends BookState {
  bool isLoading;
  AddBookLoading({required this.isLoading});
}

class UpdateBookLoading extends BookState {
  bool isLoading;
  UpdateBookLoading({required this.isLoading});
}

class DeleteBookLoading extends BookState {
  bool isLoading;
  DeleteBookLoading({required this.isLoading});
}
