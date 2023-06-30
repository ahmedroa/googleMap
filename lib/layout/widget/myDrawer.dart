import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mappp/bloc/bloc_state.dart';
import 'package:mappp/constants/my_colors.dart';
import 'package:mappp/layout/screen/login_screen.dart';
import 'package:mappp/models/strings.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../../bloc/bloc_cubit.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  // PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();

  Widget buildDrawerHeader(context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsetsDirectional.fromSTEB(70, 10, 70, 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blue[100],
          ),
          child: Image.network(
            'https://pbs.twimg.com/profile_images/1669852053731000320/esNr87L8_400x400.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Text(
          'Ahmed',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        // 01287729832
        Text(
          '0537305711',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
        // BlocProvider<PhoneAuthCubit>(
        //     create: (context) => phoneAuthCubit,
        //     child: Text(
        //       '${phoneAuthCubit.getLoggedInUser().phoneNumber}',
        //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //     )),
      ],
    );
  }

  Widget buildDrawerListItem({
    required IconData leadingIcon,
    required String title,
    Widget? trailing,
    Function()? onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: color ?? MyColors.blue,
      ),
      title: Text(title),
      trailing: trailing ??= Icon(
        Icons.arrow_right,
        color: MyColors.blue,
      ),
      onTap: onTap,
    );
  }

  Widget buildDrawerListItemsDivider() {
    return Divider(
      height: 0,
      thickness: 1,
      indent: 18,
      endIndent: 24,
    );
  }

  // void _launchURL(String url) async {
  //   await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  // }

  Widget buildIcon(IconData icon, String url) {
    return InkWell(
      // onTap: () => _launchURL(url),
      child: Icon(
        icon,
        color: MyColors.blue,
        size: 35,
      ),
    );
  }

  Widget buildSocialMediaIcons() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16),
      child: Row(
        children: [
          buildIcon(
            FontAwesomeIcons.twitter,
            'https://www.facebook.com/groups/omarahmedx14',
          ),
          const SizedBox(
            width: 20,
          ),
          buildIcon(
            FontAwesomeIcons.telegram,
            'https://t.me/FlutterDevo0',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 280,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[100]),
              child: buildDrawerHeader(context),
            ),
          ),
          buildDrawerListItem(leadingIcon: Icons.person, title: 'My Profile'),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(
            leadingIcon: Icons.history,
            title: 'Places History',
            onTap: () {},
          ),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(leadingIcon: Icons.settings, title: 'Settings'),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(leadingIcon: Icons.help, title: 'Help'),
          buildDrawerListItemsDivider(),
          BlocProvider<PhoneAuthCubit>(
            create: (context) => PhoneAuthCubit(),
            child: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
              listener: (context, state) {
                if (state is LogoutSuccessful) {
                  navigateAndFinish(context, LoginScreen());
                }
              },
              builder: (context, state) {
                return buildDrawerListItem(
                  leadingIcon: Icons.logout,
                  title: 'logout',
                  onTap: () {
                    PhoneAuthCubit().logOut(context);
                  },
                );
              },
            ),
          ),
          buildDrawerListItemsDivider(),
          const SizedBox(
            height: 130,
          ),
          ListTile(
            leading: Text(
              'Follow us',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          buildSocialMediaIcons(),
        ],
      ),
    );
  }
}
