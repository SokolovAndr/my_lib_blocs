import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lib_blocs/data/provider/author_provider.dart';
import 'package:my_lib_blocs/data/provider/book_provider.dart';
import 'package:my_lib_blocs/data/provider/genre_provider.dart';
import 'package:my_lib_blocs/data/provider/user_provider.dart';
import 'package:my_lib_blocs/data/repository/author_repository.dart';
import 'package:my_lib_blocs/data/repository/book_repository.dart';
import 'package:my_lib_blocs/data/repository/genre_repository.dart';
import 'package:my_lib_blocs/data/repository/user_repository.dart';
import 'package:my_lib_blocs/logic/bloc/author_bloc.dart';
import 'package:my_lib_blocs/logic/bloc/genre_bloc.dart';
import 'package:my_lib_blocs/logic/bloc/user_bloc.dart';
import 'logic/bloc/book_bloc.dart';
import 'logic/cubit/navigation_cubit.dart';
import 'presentation/widgets/navigation_menu_widget.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(UserProvider()),
        ),
        RepositoryProvider(
          create: (context) => AuthorRepository(AuthorProvider()),
        ),
        RepositoryProvider(
            create: (context) => GenreRepository(GenreProvider())),
        RepositoryProvider(
          create: (context) => BookRepository(BookProvider()))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => UserBloc(context.read<UserRepository>())),
          BlocProvider(
              create: (context) => AuthorBloc(context.read<AuthorRepository>())),
          BlocProvider(
              create: (context) => GenreBloc(context.read<GenreRepository>())),
          BlocProvider(
            create: (context) => BookBloc(context.read<BookRepository>())),
          BlocProvider(
            lazy: false,
            create: (context) => NavigationCubit(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationMenuWidget());
  }
}
