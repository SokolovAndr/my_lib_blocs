import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lib_blocs/logic/bloc/image_bloc.dart';
import 'package:my_lib_blocs/logic/bloc/image_state.dart';
import '../../constants/snack_bar.dart';
import '../../logic/bloc/image_event.dart';

class AddImageScreen extends StatefulWidget {
  const AddImageScreen({super.key});

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  final TextEditingController _imageNameCtrl = TextEditingController();
  final TextEditingController _imageTypeCtrl = TextEditingController();

  @override
  void dispose() {
    _imageNameCtrl.dispose();
    _imageTypeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить Изображение'),
      ),
      body: _buildBody,
    );
  }

  Widget get _buildBody {
    return Column(
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
        ElevatedButton(onPressed: () {
          if (_imageNameCtrl.text.isEmpty || _imageTypeCtrl.text.isEmpty) {
            snackBar(context, "Введите все поля");
          } else {
            context
                .read<ImageBloc>()
                .add(AddImageEvent(name: _imageNameCtrl.text, type: _imageTypeCtrl.text, context: context));
          }
        }, child:
            BlocBuilder<ImageBloc, ImageState>(builder: (context, state) {
          if (state is AddImageLoading) {
            bool isLoading = state.isLoading;
            return isLoading
                ? const CircularProgressIndicator(color: Colors.white,)
                : const Text("Добавить изображение");
          } else {
            return const Text("Добавить изображение");
          }
        }))
      ],
    );
  }
}
