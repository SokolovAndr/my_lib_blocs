import 'package:flutter/material.dart';

abstract class GenreEvent {}

class ReadGenreEvent extends GenreEvent {}

class AddGenreEvent extends GenreEvent {
  final String name;
  final BuildContext context;
  AddGenreEvent({required this.name, required this.context});
}

class UpdateGenreEvent extends GenreEvent {
  final String id;
  final String name;
  final BuildContext context;
  UpdateGenreEvent(this.context, {required this.id, required this.name});
}

class DeleteGenreEvent extends GenreEvent {
  final String id;
  DeleteGenreEvent({required this.id});
}
