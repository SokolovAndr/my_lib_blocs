
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lib_blocs/logic/bloc/author_bloc.dart';

import '../../constants/snack_bar.dart';
import '../../logic/bloc/author_event.dart';
import '../../logic/bloc/author_state.dart';

class UpdateAuthorScreen extends StatefulWidget {
  final int id;
  final String name;

  const UpdateAuthorScreen({super.key, required this.id, required this.name});

  @override
  State<UpdateAuthorScreen> createState() => _UpdateAuthorScreenState();
}

class _UpdateAuthorScreenState extends State<UpdateAuthorScreen> {
  late final TextEditingController _authorNameCtrl;

  @override
  void initState() {
    _authorNameCtrl = TextEditingController(text: widget.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Обновить автора"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: _authorNameCtrl,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Имя автора"),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () async  {
              if (_authorNameCtrl.text.isEmpty) {
                snackBar(context, "Введите все данные");
              } else {
                context.read<AuthorBloc>().add(UpdateAuthorEvent(context,
                    id: widget.id.toString(), name: _authorNameCtrl.text));
                    context.read<AuthorBloc>().add(ReadAuthorEvent());
              }
            },
            child: BlocBuilder<AuthorBloc, AuthorState>(
              builder: (context, state) {
                if (state is UpdateAuthorLoading) {
                  bool isLoading = state.isLoading;
                  return isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Обновить автора");
                } else {
                  return const Text("Обновить автора");
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
