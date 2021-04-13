import 'package:bloc/bloc.dart';

import 'models.dart';
import 'events.dart';

export 'models.dart';
export 'events.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, NavigatorModel> {
  NavigatorBloc() : super(NavigatorModel());

  @override
  mapEventToState(event) async* {
    if (event is NavigatorAppendPage)
      yield NavigatorModel(
        pages: [...state.pages, event.page],
      );
    else if (event is NavigatorPopPage) {
      final pages = state.pages;

      if (pages.length > 1) pages.removeLast();

      yield NavigatorModel(
        pages: pages,
      );
    } else if (event is NavigatorOverridePage)
      yield NavigatorModel(
        pages: event.pages,
      );
    else if (event is NavigatorSetRootPage)
      yield NavigatorModel(
        pages: [event.page],
      );
  }
}
