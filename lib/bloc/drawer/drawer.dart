import 'package:bloc/bloc.dart';

import 'models.dart';
import 'events.dart';

export 'models.dart';
export 'events.dart';

const drawerDuration = const Duration(milliseconds: 240);

class DrawerBloc extends Bloc<DrawerEvent, DrawerModel> {
  DrawerBloc() : super(DrawerModel(isOpen: false));

  @override
  mapEventToState(event) async* {
    if (event is DrawerOpen)
      yield event.model;
    else if (event is DrawerClose)
      yield event.model;
    else if (event is DrawerToggle)
      yield DrawerModel(
        isOpen: !state.isOpen,
      );
  }
}
