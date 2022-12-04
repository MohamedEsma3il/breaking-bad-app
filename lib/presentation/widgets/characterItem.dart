import 'package:breaking_bad/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';
import '../../data/models/character.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin:  EdgeInsetsDirectional.all(8.w),
      padding:  EdgeInsetsDirectional.all(4.w) ,
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8).w,
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, characterDetailsScreen,
            arguments: character),
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              character.name,
              style:  TextStyle(
                height: 1.4.h,
                fontSize: 16.sp,
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          child: Hero(
            tag: character.charId,
            child: Container(
              color: MyColors.myGrey,
              child: FadeInImage(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                image: NetworkImage(character.image),
                placeholder: const AssetImage('assets/images/loading.gif'),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/img_not_found.jpg',
                      fit: BoxFit.cover);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
