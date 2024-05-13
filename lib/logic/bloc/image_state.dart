import 'package:my_lib_blocs/data/model/image_model.dart';

abstract class ImageState {}

class LogicInitializeState extends ImageState {}

class LogicErrorState extends ImageState {
  final String error;
  LogicErrorState({required this.error});
}

class LogicloadingState extends ImageState {}

class ReadImageState extends ImageState {
  final ImageModel imageModel;
  ReadImageState({required this.imageModel});
}

class AddImageLoading extends ImageState {
  bool isLoading;
  AddImageLoading({required this.isLoading});
}

class UpdateImageLoading extends ImageState {
  bool isLoading;
  UpdateImageLoading({required this.isLoading});
}

class DeleteImageLoading extends ImageState {
  bool isLoading;
  DeleteImageLoading({required this.isLoading});
}
