import 'package:blog_flutter/pages/detail_page/actionMenu_component/component.dart';
import 'package:blog_flutter/pages/detail_page/actionMenu_component/state.dart'
    hide initState;
import 'package:blog_flutter/pages/detail_page/comList_adapter/adapter.dart';

import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DetailPage extends Page<DetailState, Map<String, dynamic>> {
  DetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DetailState>(
              adapter: NoneConn<DetailState>() + ComListAdapter(),
              slots: <String, Dependent<DetailState>>{
                'actionMenu': ActionMenuConnector() + ActionMenuComponent()
              }),
          middleware: <Middleware<DetailState>>[],
        );
}
