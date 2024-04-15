import 'package:flutter/material.dart';

abstract class AuthorEvent {}

class ReadAuthorEvent extends AuthorEvent {}

class AddAuthorEvent extends AuthorEvent {
  final String name;
  final BuildContext context;
  AddAuthorEvent({required this.name, required this.context});
}

class UpdateAuthorEvent extends AuthorEvent {
  final String id;
  final String name;
  final BuildContext context;
  UpdateAuthorEvent(this.context, {required this.id, required this.name});
}

class DeleteAuthorEvent extends AuthorEvent {
  final String id;
  DeleteAuthorEvent({required this.id});
}
