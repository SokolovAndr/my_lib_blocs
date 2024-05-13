import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lib_blocs/logic/bloc/image_bloc.dart';
import '../../constants/snack_bar.dart';
import '../../logic/bloc/image_event.dart';
import '../../logic/bloc/image_state.dart';

class UpdateImageScreen extends StatefulWidget {
  final int id;
  final String name;
  final String type;

  const UpdateImageScreen(
      {super.key, required this.id, required this.name, required this.type});

  @override
  State<UpdateImageScreen> createState() => _UpdateImageScreenState();
}

class _UpdateImageScreenState extends State<UpdateImageScreen> {
  late final TextEditingController _imageNameCtrl;
  late final TextEditingController _imageTypeCtrl;

  @override
  void initState() {
    _imageNameCtrl = TextEditingController(text: widget.name);
    _imageTypeCtrl = TextEditingController(text: widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Обновить изображение"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: _imageNameCtrl,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Название"),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
                    Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: _imageTypeCtrl,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Тип"),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () async {
              if (_imageNameCtrl.text.isEmpty || _imageTypeCtrl.text.isEmpty) {
                snackBar(context, "Введите все данные");
              } else {
                context.read<ImageBloc>().add(UpdateImageEvent(context,
                    id: widget.id.toString(), name: _imageNameCtrl.text, type: _imageTypeCtrl.text));
                context.read<ImageBloc>().add(ReadImageEvent());
              }
            },
            child: BlocBuilder<ImageBloc, ImageState>(
              builder: (context, state) {
                if (state is UpdateImageLoading) {
                  bool isLoading = state.isLoading;
                  return isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Обновить изображение");
                } else {
                  return const Text("Обновить изображение");
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
