// import 'package:blog_flutter/pages/changeInfo_page/changeAvator_component/component.dart';
import 'package:fish_redux/fish_redux.dart';

// import 'changeUserName_component/component.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ChangeInfoPage extends Page<ChangeInfoState, Map<String, dynamic>> {
  ChangeInfoPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ChangeInfoState>(
              adapter: null,
              slots: <String, Dependent<ChangeInfoState>>{
                // 'changeAvatar': ChangeUserNameCon() + ChangeUserNameComponent()
              }),
          middleware: <Middleware<ChangeInfoState>>[],
        );
}
