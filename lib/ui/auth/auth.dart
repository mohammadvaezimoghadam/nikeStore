import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nikestore/common/utils.dart';
import 'package:nikestore/data/repo/auth_repository.dart';
import 'package:nikestore/ui/auth/bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    const onBackground = Colors.white;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Theme(
        data: themeData.copyWith(
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    minimumSize: MaterialStateProperty.all(Size.fromHeight(56)),
                    backgroundColor: MaterialStateProperty.all(onBackground),
                    foregroundColor: MaterialStateProperty.all(
                        themeData.colorScheme.secondary))),
            snackBarTheme: SnackBarThemeData(
                contentTextStyle: TextStyle(fontFamily: "Vazir"),
                backgroundColor: themeData.colorScheme.primary),
            colorScheme:
                themeData.colorScheme.copyWith(onSurface: onBackground),
            inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(color: onBackground),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white, width: 1)))),
        child: Scaffold(
          backgroundColor: themeData.colorScheme.secondary,
          body: BlocProvider<AuthBloc>(
            create: (context) {
              final bloc = AuthBloc(authRepository);
              bloc.stream.forEach((state) {
                if (state is AuthSuccess) {
                  Navigator.of(context).pop();
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.exception.message)));
                }
              });
              bloc.add(AuthStarted());
              return bloc;
            },
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                physics: difaultScrollPhy,
                child: Padding(
                  padding: const EdgeInsets.only(left: 48, right: 48),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (previous, current) {
                      return current is AuthLoading ||
                          current is AuthInitial ||
                          current is AuthError;
                    },
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/nike_logo.png',
                            color: Colors.white,
                            width: 120,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            state.isLogin ? 'خوش آمدید' : 'ثبت نام ',
                            style: TextStyle(color: onBackground, fontSize: 22),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            state.isLogin
                                ? 'لطفا وارد حساب کاربری خود شوید'
                                : 'ایمیل و رمز عبور خود را تعیین کنید',
                            style: TextStyle(color: onBackground, fontSize: 16),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          TextField(
                            controller: userNameController,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecoration(label: Text("آدرس ایمیل")),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          _PasswordTextFild(
                            onBackground: onBackground,
                            controller: passWordController,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context).add(
                                  AuthBtnIsClicked(userNameController.text,
                                      passWordController.text));
                            },
                            child: state is AuthLoading
                                ? const CupertinoActivityIndicator()
                                : Text(state.isLogin ? 'ورود' : 'ثبت نام '),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.isLogin
                                    ? 'حساب کاربری نداری ؟'
                                    : 'حساب کاربری دارید',
                                style: TextStyle(
                                    color: onBackground.withOpacity(0.7)),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(AuthModeChangeIsClick());
                                },
                                child: Text(
                                  state.isLogin ? 'ثیت نام ' : 'ورود',
                                  style: TextStyle(
                                    color: themeData.colorScheme.primary,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordTextFild extends StatefulWidget {
  final TextEditingController controller;
  const _PasswordTextFild({
    Key? key,
    required this.onBackground,
    required this.controller,
  }) : super(key: key);

  final Color onBackground;

  @override
  State<_PasswordTextFild> createState() => _PasswordTextFildState();
}

class _PasswordTextFildState extends State<_PasswordTextFild> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      decoration: InputDecoration(
          label: Text('رمز عبور'),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: Icon(
                obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: widget.onBackground.withOpacity(0.6),
              ))),
    );
  }
}
