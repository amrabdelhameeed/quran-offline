import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/strings.dart';
import 'data/cubit/public_cubit.dart';
import 'data/repository/json_repo.dart';
import 'data/rootBundle/root_bundle.dart';
import 'presentation/home.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) =>
                PublicCubit(jsonRepository: JsonRepository(RootBundle()))
                  ..allSurahDetails()
                  ..allSurahDetailsForPages()
                  ..allSurahDetailsForJuz(),
            child: Home(),
          );
        });
    }
  }
}
