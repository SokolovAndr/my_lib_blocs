import 'package:my_lib_blocs/data/model/genre_model.dart';

abstract class GenreState {}

class LogicInitializeState extends GenreState {}

class LogicErrorState extends GenreState {
  final String error;
  LogicErrorState({required this.error});
}

class LogicloadingState extends GenreState {}

class ReadGenreState extends GenreState {
  final GenreModel genreModel;
  ReadGenreState({required this.genreModel});
}

class AddGenreLoading extends GenreState {
  bool isLoading;
  AddGenreLoading({required this.isLoading});
}

class UpdateGenreLoading extends GenreState {
  bool isLoading;
  UpdateGenreLoading({required this.isLoading});
}

class DeleteGenreLoading extends GenreState {
  bool isLoading;
  DeleteGenreLoading({required this.isLoading});
}
