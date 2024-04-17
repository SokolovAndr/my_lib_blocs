import 'package:my_lib_blocs/data/model/book_model.dart';
import 'package:my_lib_blocs/data/provider/book_provider.dart';


abstract class IBookRepository {
  Future<BookModel> getBooks();
}

class BookRepository implements IBookRepository {
  final BookProvider bookProvider;
  BookRepository(this.bookProvider);

  @override
  Future<BookModel> getBooks() {
    return bookProvider.readBookService();
  }
}
