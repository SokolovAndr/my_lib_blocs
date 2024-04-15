import 'package:my_lib_blocs/data/model/author_model.dart';
import 'package:my_lib_blocs/data/provider/author_provider.dart';


abstract class IAuthorRepository {
  Future<AuthorModel> getAuthors();
}

class AuthorRepository implements IAuthorRepository {
  final AuthorProvider authorProvider;
  AuthorRepository(this.authorProvider);

  @override
  Future<AuthorModel> getAuthors() {
    return authorProvider.readAuthorService();
  }
}
