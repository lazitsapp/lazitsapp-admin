import 'package:article_repository/article_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {

  final ArticleRepository _articleRepository;

  ArticlesBloc(ArticleRepository articleRepository) :
    _articleRepository = articleRepository,
    super(const ArticlesInitialState()) {




  }

}
