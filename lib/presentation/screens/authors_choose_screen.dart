import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/author_model.dart';
import '../../logic/bloc/author_bloc.dart';
import '../../logic/bloc/author_event.dart';
import '../../logic/bloc/author_state.dart';

class AuthorsChooseScreen extends StatefulWidget {
  const AuthorsChooseScreen({super.key});

  @override
  State<AuthorsChooseScreen> createState() => _AuthorsChooseScreenState();
}

class _AuthorsChooseScreenState extends State<AuthorsChooseScreen> {
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
        List<DataAuthor> authorList = state.authorModel.dataAuthor;
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
          itemCount: authorModel.dataAuthor.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                Navigator.pop<DataAuthor>(
                    context, authorModel.dataAuthor[index]);
              },
              child: ListTile(
                leading: Text(authorModel.dataAuthor[index].id.toString()),
                title: Text(authorModel.dataAuthor[index].name),
              ),
            );
          }),
    );
  }
}
