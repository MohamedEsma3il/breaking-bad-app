import 'package:bloc/bloc.dart';
import 'package:breaking_bad/data/models/quote.dart';
import 'package:breaking_bad/data/repository/characters_repository.dart';
import 'package:meta/meta.dart';

import '../../data/models/character.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());
  final CharactersRepository charactersRepository;
  List<Character> characters = [];

  List<Character> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getCharacterQuotes(String charName) {
    charactersRepository.getCharacterQuotes(charName).then((quotes) {
      emit(QuotesLoaded(quotes));
    });
  }
}
