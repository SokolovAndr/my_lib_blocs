import 'package:flutter/material.dart';

abstract class BookEvent {}

class ReadBookEvent extends BookEvent {}

class AddBookEvent extends BookEvent {
  final String title;
  final String description;
  final String authorId;
  final String genreId;
  final BuildContext context;
  AddBookEvent(
      {required this.title,
      required this.description,
      required this.authorId,
      required this.genreId,
      required this.context});
}

class UpdateBookEvent extends BookEvent {
  final String id;
  final String title;
  final String description;
  final String authorId;
  final String genreId;
  final BuildContext context;
  UpdateBookEvent(this.context,
      {required this.id,
      required this.title,
      required this.description,
      required this.authorId,
      required this.genreId});
}

class DeleteBookEvent extends BookEvent {
  final String id;
  DeleteBookEvent({required this.id});
}
