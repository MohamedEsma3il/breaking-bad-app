import 'package:breaking_bad/data/models/character.dart';
import 'package:breaking_bad/data/models/quote.dart';
import 'package:breaking_bad/data/web_services/characters_web_services.dart';

class CharactersRepository{
  final CharactersWebServices charactersWebServices;
  CharactersRepository(this.charactersWebServices);

  Future<List<Character>> getAllCharacters() async{
    final characters = await charactersWebServices.getAllCharacters();
    return characters.map((character) => Character.fromJson(character)).toList();
  }

  Future<List<Quote>> getCharacterQuotes(String charName) async {
    final quotes = await charactersWebServices.getCharacterQuotes(charName);
    return quotes.map((charQuotes) => Quote.fromJson(charQuotes)).toList();
  }


}