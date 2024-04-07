import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lib_blocs/presentation/screens/fourth_screen.dart';
import '../../logic/cubit/navigation_cubit.dart';
import '../screens/home_screen.dart';
import '../screens/second_screen.dart';
import '../screens/third_screen.dart';

class NavigationMenuWidget extends StatelessWidget {
  const NavigationMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 25,
                offset: const Offset(8, 20))
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedItemColor: Colors.redAccent,
              unselectedItemColor: Colors.black,
              showUnselectedLabels: true,
              currentIndex: state.index,
              onTap: (index) {
                if (index == 0) {
                  context.read<NavigationCubit>().goToBooksScreen();
                } else if (index == 1) {
                  context.read<NavigationCubit>().goToUsersScreen();
                } else if (index == 2) {
                  context.read<NavigationCubit>().goToAuthorsScreen();
                } else if (index == 3) {
                  context.read<NavigationCubit>().goToGenresScreen();
                }
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_books),
                  label: 'Книги',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Юзеры',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.edit),
                  label: 'Авторы',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Жанры',
                ),
              ],
            ),
          ),
        );
      }),
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (_, state) {
          if (state is StateA) {
            return const BooksScreen();
          } else if (state is StateB) {
            return const UsersScreen();
          } else if (state is StateC) {
            return const AuthorsScreen();
          } else if (state is StateD) {
            return const GenresScreen();
          }
          return const SizedBox();
        },
      ),
    );
  }
}
