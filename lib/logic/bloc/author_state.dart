import 'package:my_lib_blocs/data/model/author_model.dart';

abstract class AuthorState {}

class LogicInitializeState extends AuthorState {}

class LogicErrorState extends AuthorState {
  final String error;
  LogicErrorState({required this.error});
}

class LogicloadingState extends AuthorState {}

class ReadAuthorState extends AuthorState {
  final AuthorModel authorModel;
  ReadAuthorState({required this.authorModel});
}

class AddAuthorLoading extends AuthorState {
  bool isLoading;
  AddAuthorLoading({required this.isLoading});
}

class UpdateAuthorLoading extends AuthorState {
  bool isLoading;
  UpdateAuthorLoading({required this.isLoading});
}

class DeleteAuthorLoading extends AuthorState {
  bool isLoading;
  DeleteAuthorLoading({required this.isLoading});
}
