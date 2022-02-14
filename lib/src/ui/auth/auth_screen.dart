import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/dialog_utils/error_handling_dialog.dart';
import 'package:wisdom/src/app_utils/dialog_utils/profile_update_dialog.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/request/request_login_vo.dart';
import 'package:wisdom/src/data_models/request/request_register_vo.dart';
import 'package:wisdom/src/ui/auth/button_section.dart';
import 'package:wisdom/src/ui/auth/login_section.dart';
import 'package:wisdom/src/ui/auth/refer_code_section.dart';
import 'package:wisdom/src/ui/auth/register_section.dart';
import 'package:wisdom/src/ui/auth/title_section.dart';
import 'package:wisdom/src/ui/home/home_screen.dart';
import 'package:wisdom/src/ui/widgets/gradient_background.dart';
import 'package:wisdom/src/view_models/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/register_screen';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  final _referCodeController = TextEditingController();
  final _registerNickNameController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  final _loginNickNameController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  late AuthProvider _authProvider;
  late FirebaseMessaging messaging;
  String fireToken = '';

  @override
  void initState() {
    _authProvider = locator<AuthProvider>();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 6));
    _animationController.animateTo(0.0);
    _animationController.animateTo(0.2);

    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      setState(() {
        fireToken = value.toString();
        print(fireToken);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (context) => _authProvider,
      child: WillPopScope(
        onWillPop: () async {
          _onExit();
          return false;
        },
        child: Scaffold(
          body: Stack(
            children: [
              GradientBackground(),
              CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TitleSection(animationController: _animationController),
                          SizedBox(height: AppDimen.MARGIN_MEDIUM_3),
                          Stack(
                            children: [
                              Stack(
                                children: [
                                  Builder(builder: (context) {
                                    return LoginSection(
                                      loginNickNameController: _loginNickNameController,
                                      loginPasswordController: _loginPasswordController,
                                      animationController: _animationController,
                                      onPressRegister: () {
                                        _animationController.animateTo(0.4);
                                      },
                                      onPressLogin: () {
                                        _loginUser(
                                          Provider.of<AuthProvider>(context,
                                              listen: false),
                                        );
                                      },
                                    );
                                  }),
                                  ReferCodeSection(
                                      referCodeController: _referCodeController,
                                      animationController: _animationController),
                                  RegisterSection(
                                      registerNickNameController:
                                          _registerNickNameController,
                                      registerPasswordController:
                                          _registerPasswordController,
                                      animationController: _animationController),
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: ButtonSectionV2(
                                    animationController: _animationController,
                                    onPressed: () {
                                      _onNext(_authProvider);
                                    }),
                              ),
                            ],
                          ),
                          Consumer<AuthProvider>(builder: (context, provider, child) {
                            if (provider.state == ViewState.LOADING) {
                            } else if (provider.state == ViewState.COMPLETE) {
                              WidgetsBinding.instance!.addPostFrameCallback((_) {
                                Navigator.pushReplacementNamed(
                                    context, HomeScreen.routeName);
                              });
                            } else if (provider.state == ViewState.ERROR) {
                              WidgetsBinding.instance!.addPostFrameCallback((_) {
                                showErrorDialog(
                                    context, 'Error', provider.errorMessage, provider);
                              });
                            }
                            return Container();
                          }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppDimen.MARGIN_MEDIUM_2),
                  child: Consumer<AuthProvider>(
                    builder: (context, provider, child) {
                      if (provider.state == ViewState.LOADING) {
                        return child ?? Container();
                      }
                      return Container();
                    },
                    child: Lottie.asset(
                      'assets/jsons/white_line_loading.json',
                      width: 80,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showErrorDialog(
      BuildContext ctx, String title, String message, AuthProvider provider) {
    provider.setState(ViewState.NONE);
    showDialog(
      context: ctx,
      barrierDismissible: true,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: ErrorHandlingDialogBox(
            alertType: AlertType.ERROR,
            title: title,
            message: message,
          ),
        );
      },
    );
  }

  _onNext(AuthProvider provider) {
    if (_animationController.value >= 0.0 && _animationController.value < 0.4) {
      _animationController.animateTo(0.4);
    } else if (_animationController.value >= 0.4 && _animationController.value < 0.6) {
      _animationController.animateTo(0.6);
    } else if (_animationController.value >= 0.6 && _animationController.value < 0.8) {
      _registerUser(provider);
    }
  }

  _onExit() {
    if (_animationController.value >= 0.4 && _animationController.value < 0.6) {
      _animationController.animateTo(0.2);
    } else if (_animationController.value >= 0.6 && _animationController.value < 0.8) {
      _animationController.animateTo(0.4);
    } else {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    }
  }

  _registerUser(AuthProvider provider) {
    RequestRegisterVO request = RequestRegisterVO(
      nickname: _registerNickNameController.text,
      code: _referCodeController.text,
      deviceId: '',
      firebaseToken: fireToken,
      password: _registerPasswordController.text,
    );
    provider.registerUser(request);
  }

  _loginUser(AuthProvider provider) {
    RequestLoginVO request = RequestLoginVO(
      nickname: _loginNickNameController.text,
      password: _loginPasswordController.text,
      firebaseToken: fireToken,
    );
    provider.loginUser(request);
  }
}

class ButtonSectionView extends StatelessWidget {
  const ButtonSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: AppTheme.fresh_purple,
      ),
      child: InkWell(
        child: Center(
          child: Text(
            'Register',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: AppTheme.white,
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldTitle extends StatelessWidget {
  final String text;

  TextFieldTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: AppTheme.white,
          fontSize: AppDimen.TEXT_REGULAR_2X,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal),
    );
  }
}
