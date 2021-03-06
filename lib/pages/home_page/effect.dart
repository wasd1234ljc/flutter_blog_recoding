import 'package:blog_flutter/custom_widgets/state_with_ticker_provider.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<HomeState> buildEffect() {
  return combineEffects(<Object, Effect<HomeState>>{
    Lifecycle.initState: _initTabs,
    HomeAction.addNumber: _addNumber,
  });
}

void _addNumber(Action action, Context<HomeState> ctx) {
  if (ctx.state.userInfo == null) {
    Navigator.of(ctx.context).pushNamed('login_page');
  } else {
    Navigator.of(ctx.context).pushNamed('addArticle_page');
  }
}

void _initTabs(Action action, Context<HomeState> ctx) {
  print('initState------------------');
  final List<Widget> tabs = <Widget>[
    Text('推荐'),
    Text('游戏开发'),
    Text('游戏运维'),
    Text('游戏测评'),
  ];
  final List<int> tabNumber = <int>[
    0,
    1,
    2,
    3,
  ];
  final TickerProvider tickerProvider = ctx.stfState as StateWithTickerProvider;
  var _tabController =
      TabController(vsync: tickerProvider, length: tabs.length);

  _tabController.addListener(() {
    println(_tabController.index);
  });
  ctx.dispatch(HomeActionCreator.initTabs({
    'tabs': tabs,
    'tabNumber': tabNumber,
    '_tabController': _tabController
  }));
}
