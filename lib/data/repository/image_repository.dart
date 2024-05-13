import 'package:my_lib_blocs/data/model/image_model.dart';
import 'package:my_lib_blocs/data/provider/image_provider.dart';

abstract class IImageRepository {
  Future<ImageModel> getImages();
}

class ImageRepository implements IImageRepository {
  final MyImageProvider imageProvider;
  ImageRepository(this.imageProvider);

  @override
  Future<ImageModel> getImages() {
    return imageProvider.readImageService();
  }
}
