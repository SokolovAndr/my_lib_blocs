import 'package:flutter/material.dart';
import 'package:my_lib_blocs/data/model/author_model.dart';
import 'package:my_lib_blocs/data/model/genre_model.dart';

abstract class BookEvent {}

class ReadBookEvent extends BookEvent {}

class AddBookEvent extends BookEvent {
  final String title;
  final String description;
  final int authorId;
  final int genreId;
  final BuildContext context;
  final DataAuthor autorUi;
  final DataGenre genreUi;
  AddBookEvent(
      {required this.title,
      required this.description,
      required this.authorId,
      required this.genreId,
      required this.context,
      required this.autorUi,
      required this.genreUi});
}

class UpdateBookEvent extends BookEvent {
  final String id;
  final String title;
  final String description;
  final int authorId;
  final int genreId;
  final BuildContext context;
  final DataAuthor autorUi;
  final DataGenre genreUi;

  UpdateBookEvent(this.context,
      {required this.id,
      required this.title,
      required this.description,
      required this.authorId,
      required this.genreId,
      required this.autorUi,
      required this.genreUi
      });
}

class DeleteBookEvent extends BookEvent {
  final String id;
  DeleteBookEvent({required this.id});
}
