
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lib_blocs/logic/bloc/author_bloc.dart';

import '../../constants/snack_bar.dart';
import '../../logic/bloc/author_event.dart';
import '../../logic/bloc/author_state.dart';

class AddAuthorScreen extends StatefulWidget {
  const AddAuthorScreen({super.key});

  @override
  State<AddAuthorScreen> createState() => _AddAuthorScreenState();
}

class _AddAuthorScreenState extends State<AddAuthorScreen> {
  final TextEditingController _userNameCtrl = TextEditingController();

  @override
  void dispose() {
    _userNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить автора'),
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
            controller: _userNameCtrl,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Имя"),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(onPressed: () {
          if (_userNameCtrl.text.isEmpty) {
            snackBar(context, "Введиет имя");
          } else {
            context
                .read<AuthorBloc>()
                .add(AddAuthorEvent(name: _userNameCtrl.text, context: context));
          }
        }, child:
            BlocBuilder<AuthorBloc, AuthorState>(builder: (context, state) {
          if (state is AddAuthorLoading) {
            bool isLoading = state.isLoading;
            return isLoading
                ? const CircularProgressIndicator(color: Colors.white,)
                : const Text("Добавить автора");
          } else {
            return const Text("Добавить автора");
          }
        }))
      ],
    );
  }
}
