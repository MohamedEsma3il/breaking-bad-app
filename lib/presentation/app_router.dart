import 'package:breaking_bad/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(builder: (_) => const CharactersScreen());
    }
  }
}
