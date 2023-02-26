import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikestore/data/autinfo.dart';
import 'package:nikestore/data/repo/auth_repository.dart';
import 'package:nikestore/ui/auth/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<AuthInfo?>(
        valueListenable: AuthRepository.authChangeNotifire,
        builder: (context, value, child) {
          bool isAuthenticated = value != null && value.accessToken.isNotEmpty;
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isAuthenticated?Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('خوش امدید'),
                    Icon(CupertinoIcons.check_mark_circled,color: Colors.green,)

                  ],
                ):Text('وارد حساب خود شوید'),
                isAuthenticated
                    ? ElevatedButton(
                        onPressed: () {
                          authRepository.signOut();
                        },
                        child: Text('خروج از حساب'),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => AuthScreen()));
                        },
                        child: Text('وارد حساب کاربری خود شوید'),
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}