import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasi_care/features/auth/pages/blocs/auth_bloc.dart';
import 'package:kasi_care/features/auth/pages/blocs/auth_state.dart';

class ForgetpassPage extends StatelessWidget {
  const ForgetpassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SafeArea(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      height: 48.0,
                      child: MaterialButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () async {},
                        child: Text('Send Reset Link'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
