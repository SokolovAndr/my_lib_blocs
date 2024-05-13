import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lib_blocs/data/model/image_model.dart';
import 'package:my_lib_blocs/logic/bloc/image_bloc.dart';
import 'package:my_lib_blocs/logic/bloc/image_event.dart';
import 'package:my_lib_blocs/logic/bloc/image_state.dart';

class ImagesChooseScreen extends StatefulWidget {
  const ImagesChooseScreen({super.key});

  @override
  State<ImagesChooseScreen> createState() => _ImagesChooseScreenState();
}

class _ImagesChooseScreenState extends State<ImagesChooseScreen> {
  @override
  void initState() {
    context.read<ImageBloc>().add(ReadImageEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Изображения"),
      ),
      body: _buildBody,
    );
  }

  Widget get _buildBody {
    return BlocBuilder<ImageBloc, ImageState>(builder: (context, state) {
      if (state is LogicInitializeState || state is LogicloadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is LogicErrorState) {
        String err = state.error;
        return Center(
          child: Text(err),
        );
      } else if (state is ReadImageState) {
        List<DataImage> imageList = state.imageModel.dataImage;
        var data = state.imageModel;
        return imageList.isNotEmpty
            ? _buildListView(data)
            : const Center(child: Text("Список пуст"));
      } else {
        return Container();
      }
    });
  }

  Widget _buildListView(ImageModel imageModel) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ImageBloc>().add(ReadImageEvent());
      },
      child: ListView.builder(
          itemCount: imageModel.dataImage.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                Navigator.pop<DataImage>(
                    context, imageModel.dataImage[index]);
              },
              child: ListTile(
                leading: Text(imageModel.dataImage[index].id.toString()),
                title: Text(imageModel.dataImage[index].name),
                subtitle: Text(imageModel.dataImage[index].type),
              ),
            );
          }),
    );
  }
}
