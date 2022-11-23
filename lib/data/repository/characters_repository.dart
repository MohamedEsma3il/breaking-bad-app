import 'package:breaking_bad/data/models/character.dart';
import 'package:breaking_bad/data/web_services/characters_web_services.dart';

class CharactersRepository{
  final CharactersWebServices charactersWebServices;
  CharactersRepository(this.charactersWebServices);

  Future<List<dynamic>> getAllCharacters() async{
    final characters = await charactersWebServices.getAllCharacters();
    return characters.map((character) => Character.fromJson(character)).toList();
  }

}