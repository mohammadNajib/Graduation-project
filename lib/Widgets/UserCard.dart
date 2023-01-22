import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:co_chef_mobile/Models/otherUsers.dart';
import 'package:co_chef_mobile/Repositories/otherUsersRepo.dart';
import 'package:co_chef_mobile/Screens/WelcomePage.dart';
import 'package:co_chef_mobile/Widgets/UserIcon.dart';
import 'package:co_chef_mobile/Screens/userProfile.dart';
import 'package:co_chef_mobile/Widgets/PopUP.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;

class UserCard extends StatefulWidget {
  final OtherProfile profile;

  const UserCard({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    OtherUsersRepo otherUsersRepo = OtherUsersRepo();
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile(id: widget.profile.id!)));
      },
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color4,
          border: Border.all(color: color2, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text((widget.profile.name) ?? '', textAlign: TextAlign.center, style: appTextStyle),
                Row(
                  children: [
                    ProfileIcon(data: widget.profile.followersCount.toString(), text: 'يتابعه', textColor: color2),
                    ProfileIcon(data: widget.profile.followingsCount.toString(), text: 'يتابع', textColor: color2),
                  ],
                )
              ],
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.2),
            PopUp(
              child: Text(widget.profile.isFollowing! ? 'أتابع' : 'متابعة', style: textStyle),
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.3,
              color: widget.profile.isFollowing! ? AppColors.color1 : AppColors.color3,
              onTap: () {
                if (widget.profile.isFollowing!) {
                  otherUsersRepo.unFollowUser(widget.profile.id!);

                  setState(() {
                    widget.profile.isFollowing = false;
                  });
                } else {
                  otherUsersRepo.followUser(widget.profile.id!);
                  setState(() {
                    widget.profile.isFollowing = true;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
