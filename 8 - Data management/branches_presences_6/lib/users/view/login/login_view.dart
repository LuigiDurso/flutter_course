import 'package:branches_presences_6/branches/bloc/branches_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/bloc/app/app_bloc.dart';
import '../../../app/utils/email_validation.dart';
import '../../../app/utils/spinner_dialog.dart';
import '../../../app/widget/confirm_message_dialog.dart';
import '../../bloc/login_form/login_form_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var navigator = Navigator.of(context);

    return BlocConsumer<LoginFormBloc, LoginFormState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
        if (state.status == LoginFormStatus.submissionFailed) {
          SpinnerDialog.closeSpinnerDialog(navigator);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showDialog<void>(
            context: context,
            builder: (_) => ConfirmMessageDialog(
              message: (state.error ?? 'Errore'),
            ),
          );
        }
        if (state.status == LoginFormStatus.submissionInProgress) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          SpinnerDialog.buildShowDialog(context);
        }
        if (state.status == LoginFormStatus.submissionSuccess) {
          SpinnerDialog.closeSpinnerDialog(navigator);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          context.read<AppBloc>()
              .add(
            AppUserChanged(
              user: state.loggedUser!,
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _form,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  theme.primaryColor,
                  Colors.white,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Presenze SI2001",
                            style: theme.textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Bentornato",
                              style: theme.textTheme.subtitle1!.copyWith(
                                color: Colors.white,
                              )),
                        ],
                      ),
                      Image.asset(
                        'assets/images/si2001-logo-bianco.png',
                        height: 100,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 60,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.primaryColor,
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom:
                                        BorderSide(color: Colors.grey.shade200),
                                      ),
                                    ),
                                    child: TextFormField(
                                      focusNode: state.emailFocusNode,
                                      keyboardType: TextInputType.emailAddress,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context).requestFocus(state.passwordFocusNode);
                                      },
                                      validator: (email) {
                                        return EmailValidation.emailRegex.hasMatch(email ?? '')
                                            ? null
                                            : 'Inserisci una email valida!';
                                      },
                                      onChanged: (email) {
                                        context.read<LoginFormBloc>().add(
                                          EmailChanged(email: email),
                                        );
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "Email",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      focusNode: state.passwordFocusNode,
                                      onFieldSubmitted: (_) {
                                        context.read<LoginFormBloc>().add(
                                          FormSubmitted(form: _form),
                                        );
                                      },
                                      validator: (pw) {
                                        return pw != null && pw.length > 3
                                            ? null
                                            : 'Inserisci una Password di almeno 4 caratteri';
                                      },
                                      onChanged: (pw) {
                                        context.read<LoginFormBloc>().add(
                                          PasswordChanged(password: pw),
                                        );
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "Password",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            InkWell(
                              onTap: () {
                                context.read<LoginFormBloc>().add(
                                  FormSubmitted(form: _form),
                                );
                              },
                              child: Container(
                                height: 50,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 50),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: theme.primaryColor,
                                ),
                                child: const Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
