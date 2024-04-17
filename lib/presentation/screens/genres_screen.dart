import 'package:flutter/material.dart';
import 'package:my_lib_blocs/data/model/genre_model.dart';
import 'package:my_lib_blocs/logic/bloc/genre_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/genre_event.dart';
import '../../logic/bloc/genre_state.dart';
import 'add_genre_screen.dart';
import 'update_genre_screen.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({super.key});

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  @override
  void initState() {
    context.read<GenreBloc>().add(ReadGenreEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Жанры"),
      ),
      body: _buildBody,
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddGenreScreen()));
            Future.delayed(const Duration(milliseconds: 5), () {
              context.read<GenreBloc>().add(ReadGenreEvent());
            });
          },
          child: const Icon(Icons.add)),
    );
  }

  Widget get _buildBody {
    return BlocBuilder<GenreBloc, GenreState>(builder: (context, state) {
      if (state is LogicInitializeState || state is LogicloadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is LogicErrorState) {
        String err = state.error;
        return Center(
          child: Text(err),
        );
      } else if (state is ReadGenreState) {
        List<Data> genreList = state.genreModel.data;
        var data = state.genreModel;
        return genreList.isNotEmpty
            ? _buildListView(data)
            : const Center(child: Text("Список пуст"));
      } else {
        return Container();
      }
    });
  }

  Widget _buildListView(GenreModel genreModel) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<GenreBloc>().add(ReadGenreEvent());
      },
      child: ListView.builder(
          itemCount: genreModel.data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return UpdateGenreScreen(
                      id: genreModel.data[index].id,
                      name: genreModel.data[index].name);
                }));
              },
              child: ListTile(
                leading: Text(genreModel.data[index].id.toString()),
                title: Text(genreModel.data[index].name),
                trailing: IconButton(
                  onPressed: () async {
                    context.read<GenreBloc>().add(DeleteGenreEvent(
                        id: genreModel.data[index].id.toString()));
                    context.read<GenreBloc>().add(ReadGenreEvent());
                  },
                  icon: const Icon(Icons.delete_outline),
                ),
              ),
            );
          }),
    );
  }
}
