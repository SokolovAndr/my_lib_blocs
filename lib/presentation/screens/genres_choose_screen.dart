import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/genre_model.dart';
import '../../logic/bloc/genre_bloc.dart';
import '../../logic/bloc/genre_event.dart';
import '../../logic/bloc/genre_state.dart';

class GenresChooseScreen extends StatefulWidget {
  const GenresChooseScreen({super.key});

  @override
  State<GenresChooseScreen> createState() => _GenresChooseScreenState();
}

class _GenresChooseScreenState extends State<GenresChooseScreen> {
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
        List<DataGenre> genreList = state.genreModel.dataGenre;
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
          itemCount: genreModel.dataGenre.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                Navigator.pop<DataGenre>(context, genreModel.dataGenre[index]);
              },
              child: ListTile(
                leading: Text(genreModel.dataGenre[index].id.toString()),
                title: Text(genreModel.dataGenre[index].name),
              ),
            );
          }),
    );
  }
}
