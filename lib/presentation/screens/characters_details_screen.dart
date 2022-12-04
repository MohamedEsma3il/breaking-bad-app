import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/data/models/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);
  final Character character;

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 500.h,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.nickName,
          style: const TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: character.charId,
          child: FadeInImage(
            fit: BoxFit.cover,
            image: NetworkImage(character.image),
            placeholder: const AssetImage('assets/images/loading.gif'),
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/img_not_found.jpg',
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.w),
      child: RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: TextStyle(
                shadows: const [
                  Shadow(color: MyColors.myWhite, offset: Offset(0, -4))
                ],
                decoration: TextDecoration.underline,
                decorationColor: MyColors.myYellow,
                decorationThickness: 4,
                color: Colors.transparent,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                shadows: const [
                  Shadow(color: MyColors.myWhite, offset: Offset(0, -4))
                ],
                color: Colors.transparent,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.isNotEmpty /*length != 0*/) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.sp,
            color: MyColors.myWhite,
            shadows: const [
              Shadow(
                blurRadius: 7,
                color: MyColors.myYellow,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context)
        .getCharacterQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0).w,
                  padding: const EdgeInsets.all(8).w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      characterInfo('Job : ', character.jobs.join(' / ')),
                      characterInfo(
                          'Appeared in : ', character.categoryForTwoSeries),
                      characterInfo('Seasons : ',
                          character.appearanceOfSeasons.join(' / ')),
                      characterInfo('Status : ', character.statusIfDeadOrAlive),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : characterInfo('Better Call Saul Seasons : ',
                              character.betterCallSaulAppearance.join(" / ")),
                      characterInfo('Actor/Actress : ', character.actorName),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                          return checkIfQuotesAreLoaded(state);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.95,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
