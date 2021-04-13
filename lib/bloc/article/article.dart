import 'package:bloc/bloc.dart';

import 'events.dart';
import 'models.dart';

export 'events.dart';
export 'models.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleModel> {
  ArticleBloc() : super(ArticleModel());

  @override
  mapEventToState(event) async* {
    if (event is ArticleOverride)
      yield event.model;
    else if (event is ArticleFetchHeadline) {
      if (event.toOverride) yield event.setLoading(state);

      yield await event.fetch(state);
    }
  }
}
