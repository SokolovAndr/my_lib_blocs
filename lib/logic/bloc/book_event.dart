import 'package:flutter/material.dart';
import 'package:my_lib_blocs/data/model/author_model.dart';
import 'package:my_lib_blocs/data/model/genre_model.dart';
import 'package:my_lib_blocs/data/model/image_model.dart';

abstract class BookEvent {}

class ReadBookEvent extends BookEvent {}

class ReadFilterBookEvent extends BookEvent {
  final List<String> currentFilters;
  ReadFilterBookEvent({
    required this.currentFilters,
  });
}

class AddBookEvent extends BookEvent {
  final String title;
  final String description;
  final int authorId;
  final int genreId;
  final int imageId;
  final BuildContext context;
  final DataAuthor autorUi;
  final DataGenre genreUi;
  final DataImage imageUi;
  AddBookEvent(
      {required this.title,
      required this.description,
      required this.authorId,
      required this.genreId,
      required this.imageId,
      required this.context,
      required this.autorUi,
      required this.genreUi,
      required this.imageUi});
}

class UpdateBookEvent extends BookEvent {
  final String id;
  final String title;
  final String description;
  final int authorId;
  final int genreId;
  final int imageId;
  final BuildContext context;
  final DataAuthor autorUi;
  final DataGenre genreUi;
  final DataImage imageUi;

  UpdateBookEvent(this.context,
      {required this.id,
      required this.title,
      required this.description,
      required this.authorId,
      required this.genreId,
      required this.imageId,
      required this.autorUi,
      required this.genreUi,
      required this.imageUi});
}

class DeleteBookEvent extends BookEvent {
  final String id;
  DeleteBookEvent({required this.id});
}
