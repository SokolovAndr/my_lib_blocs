import 'package:flutter/material.dart';
import 'package:my_lib_blocs/data/model/author_model.dart';
import 'package:my_lib_blocs/logic/bloc/author_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/author_event.dart';
import '../../logic/bloc/author_state.dart';
import 'add_author_screen.dart';
import 'update_author_screen.dart';

class AuthorsScreen extends StatefulWidget {
  const AuthorsScreen({super.key});

  @override
  State<AuthorsScreen> createState() => _AuthorsScreenState();
}

class _AuthorsScreenState extends State<AuthorsScreen> {
  @override
  void initState() {
    context.read<AuthorBloc>().add(ReadAuthorEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Авторы"),
      ),
      body: _buildBody,
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddAuthorScreen()));
            Future.delayed(const Duration(milliseconds: 5), () {
              context.read<AuthorBloc>().add(ReadAuthorEvent());
            });
          },
          child: const Icon(Icons.add)),
    );
  }

  Widget get _buildBody {
    return BlocBuilder<AuthorBloc, AuthorState>(builder: (context, state) {
      if (state is LogicInitializeState || state is LogicloadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is LogicErrorState) {
        String err = state.error;
        return Center(
          child: Text(err),
        );
      } else if (state is ReadAuthorState) {
        List<Data> authorList = state.authorModel.data;
        var data = state.authorModel;
        return authorList.isNotEmpty
            ? _buildListView(data)
            : const Center(child: Text("Список пуст"));
      } else {
        return Container();
      }
    });
  }

  Widget _buildListView(AuthorModel authorModel) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<AuthorBloc>().add(ReadAuthorEvent());
      },
      child: ListView.builder(
          itemCount: authorModel.data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return UpdateAuthorScreen(
                      id: authorModel.data[index].id,
                      name: authorModel.data[index].name);
                }));
              },
              child: ListTile(
                leading: Text(authorModel.data[index].id.toString()),
                title: Text(authorModel.data[index].name),
                trailing: IconButton(
                  onPressed: () async {
                    context.read<AuthorBloc>().add(DeleteAuthorEvent(
                        id: authorModel.data[index].id.toString()));
                    context.read<AuthorBloc>().add(ReadAuthorEvent());
                  },
                  icon: const Icon(Icons.delete_outline),
                ),
              ),
            );
          }),
    );
  }
}
