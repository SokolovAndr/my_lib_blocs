import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/user_model.dart';
import '../../logic/bloc/user_bloc.dart';

class AuthorsScreen extends StatelessWidget {
  const AuthorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Repository Provider'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UserErrorState) {
            return const Center(child: Text("Error"));
          }
          if (state is UserSucessState) {
            List<Datum> userList = state.userModel.data;
            return userList.isNotEmpty
                ? ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: Card(
                          child: ListTile(
                            title: Text(
                                '${userList[index].firstName} ${userList[index].lastName}'),
                            subtitle: Text('${userList[index].email}'),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  userList[index].avatar.toString()),
                            ),
                          ),
                        ),
                      );
                    })
                : const Center(child: Text("No Data Found"));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<UserBloc>().add(LoadUserEvent());
        },
        child: const Icon(Icons.refresh),
      )
    );
  }
}


