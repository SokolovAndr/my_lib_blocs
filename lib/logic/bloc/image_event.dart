import 'package:flutter/material.dart';

abstract class ImageEvent {}

class ReadImageEvent extends ImageEvent {}

class AddImageEvent extends ImageEvent {
  final String name;
  final String type;
  final BuildContext context;
  AddImageEvent({required this.name, required this.type, required this.context});
}

class UpdateImageEvent extends ImageEvent {
  final String id;
  final String name;
  final String type;
  final BuildContext context;
  UpdateImageEvent(this.context, {required this.id, required this.name, required this.type});
}

class DeleteImageEvent extends ImageEvent {
  final String id;
  DeleteImageEvent({required this.id});
}
