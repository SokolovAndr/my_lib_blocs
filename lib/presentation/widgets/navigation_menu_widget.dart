import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/navigation_cubit.dart';
import '../screens/home_screen.dart';
import '../screens/second_screen.dart';

class NavigationMenuWidget extends StatelessWidget {
  const NavigationMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
      BlocBuilder<NavigationCubit, NavigationState>(builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  context.read<NavigationCubit>().goToAuthorsScreen();
                }
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_books),
                  label: 'Книги',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.create),
                  label: 'Авторы',
                ),
              ],
            ),
          ),
        );
      }),
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (_, state) => state is StateA ? const BooksScreen() : const AuthorsScreen(),
      ),
    );
  }
}
