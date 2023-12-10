import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mlaku_mlaku/features/presentation/bloc/auth/auth_bloc_bloc.dart';
import 'package:mlaku_mlaku/features/presentation/bloc/booking/booking_hotels_bloc.dart';
import 'package:mlaku_mlaku/features/presentation/pages/auth/entry_data_page.dart';
import 'package:mlaku_mlaku/features/presentation/widgets/auth_widget.dart';

import '../../widgets/globalcomponent/bunderan.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Bunderan(
              color: Color(0x3F1BA0E1),
              size: 249,
              top: -53,
              right: -88,
            ),
            Bunderan(
              color: Color(0x3F1BA0E1),
              size: 192,
              top: 149,
              right: -113,
            ),
            Positioned(
              top: 86,
              left: 13,
              child: Container(
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blue,
                    width: 4,
                  ),
                  color: Colors.white,
                ),
                child: Text(
                  'Mlaku\nmlaku',
                  style: TextStyle(fontSize: 48),
                ),
              ),
            ),
            _buildBody(context),
          ],
        ),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return BlocConsumer<AuthBlocBloc, AuthBlocState>(
      listenWhen: (previous, current) => current is AuthBlocActionState,
      buildWhen: (previous, current) {
        print('current ${current.runtimeType}');
        print('prex ${previous.runtimeType}');
        return current is! AuthBlocActionState;
      },
      listener: (_, state) {
        switch (state.runtimeType) {
          case AuthBlocStateDone:
            print('done');
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text('Login Berhasil'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/main');
                           
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ));
            break;
          case AuthBlocStateError:
            print('gagal');
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text('Login Gagal'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ));
            break;
        }
      },
      builder: (_, state) {
        print('tes ${state.runtimeType}');
        switch (state.runtimeType) {
          case AuthBlocStateSignIn:
            print('sign in');
            return AuthWidget(isLogin: true);
          case AuthBlocStateSignUp:
            print('sign up');
            return AuthWidget(isLogin: false);
          case AuthBlocUserEntryDataState:
            return EntryDataPage(data: state.user!);
          default:
            return Placeholder();
        }
      },
    );
  }
}
