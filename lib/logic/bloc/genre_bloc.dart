import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lib_blocs/data/repository/genre_repository.dart';
import 'package:my_lib_blocs/logic/bloc/genre_event.dart';
import 'package:my_lib_blocs/logic/bloc/genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final GenreRepository _genreRepository;

  GenreBloc(this._genreRepository) : super(LogicInitializeState()) {
    on<AddGenreEvent>((event, emit) async {
      emit(AddGenreLoading(isLoading: true));
      await _genreRepository.genreProvider
          .addGenreService(event.name)
          .then((value) {
        emit(AddGenreLoading(isLoading: false));
        /*Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(event.context);
        });*/
        Navigator.pop(event.context);
      }).onError((error, stackTrace) {
        emit(AddGenreLoading(isLoading: false));
      });
    });

    on<ReadGenreEvent>((event, emit) async {
      emit(LogicloadingState());
      await _genreRepository.genreProvider.readGenreService().then((value) {
        emit(ReadGenreState(genreModel: value));
      }).onError((error, stackTrace) {
        emit(LogicErrorState(error: error.toString()));
      });
    });

    on<UpdateGenreEvent>((event, emit) async {
      emit(UpdateGenreLoading(isLoading: true));
      //final Map<String, dynamic> data = {"id": event.id, "name": event.name};

      await _genreRepository.genreProvider
          .updateGenreService(event.id, event.name)
          .then((value) {
        emit(UpdateGenreLoading(isLoading: false));
        //snackBar(event.context, "User has been updated");
        /*Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(event.context);
        });*/
        Navigator.pop(event.context);
      }).onError((error, stackTrace) {
        emit(UpdateGenreLoading(isLoading: false));
      });
    });

    on<DeleteGenreEvent>((event, emit) async {
      emit(DeleteGenreLoading(isLoading: true));
      await _genreRepository.genreProvider
          .deleteGenreService(event.id)
          .then((value) {
        emit(DeleteGenreLoading(isLoading: false));
      }).onError((error, stackTrace) {
        emit(DeleteGenreLoading(isLoading: false));
      });
    });
  }
}
