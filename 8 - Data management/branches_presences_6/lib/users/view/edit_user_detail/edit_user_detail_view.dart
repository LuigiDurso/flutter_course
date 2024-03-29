import 'package:branches_presences_6/app/bloc/app/app_bloc.dart';
import 'package:branches_presences_6/app/utils/email_validation.dart';
import 'package:branches_presences_6/app/widget/confirm_message_dialog.dart';
import 'package:branches_presences_6/users/bloc/edit_user_detail_form/edit_user_detail_form_bloc.dart';
import 'package:branches_presences_6/users/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/utils/spinner_dialog.dart';
import '../../../app/widget/widget.dart';

class EditUserDetailView extends StatefulWidget {
  final User currentUser;

  const EditUserDetailView({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<EditUserDetailView> createState() => _EditUserDetailViewState();
}

class _EditUserDetailViewState extends State<EditUserDetailView> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);
    return BlocConsumer<EditUserDetailFormBloc, EditUserDetailFormState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == EditUserDetailFormStatus.submissionFailed) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showDialog<void>(
            context: context,
            builder: (_) => const ConfirmMessageDialog(
              message: 'Errore di immissione',
            ),
          );
        }
        if (state.status == EditUserDetailFormStatus.submissionInProgress) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          SpinnerDialog.buildShowDialog(context);
        }
        if (state.status == EditUserDetailFormStatus.submissionSuccess) {
          navigator.pop();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          context.read<AppBloc>()
              .add(
            AppUserChanged(
              user: widget.currentUser.copyWith(
                name: state.name,
                email: state.email,
                about: state.about
              ),
            ),
          );
          navigator.pop();
        }
      },
      builder: (ctx, state) => Form(
        key: _form,
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Nome',
                  text: widget.currentUser.name,
                  focusNode: state.nameFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(ctx).requestFocus(state.emailFocusNode);
                  },
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return 'Inserisci un nome';
                    }
                    return null;
                  },
                  onChanged: (name) {
                    ctx
                        .read<EditUserDetailFormBloc>()
                        .add(NameChanged(name: name));
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: widget.currentUser.email,
                  focusNode: state.emailFocusNode,
                  textInputType: TextInputType.emailAddress,
                  onFieldSubmitted: (_) {
                    FocusScope.of(ctx).requestFocus(state.aboutFocusNode);
                  },
                  validator: (email) {
                    return EmailValidation.emailRegex.hasMatch(email ?? '')
                        ? null
                        : 'Inserisci una email valida!';
                  },
                  onChanged: (email) {
                    ctx.read<EditUserDetailFormBloc>().add(
                          EmailChanged(email: email),
                        );
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'About',
                  text: widget.currentUser.about,
                  maxLines: 5,
                  focusNode: state.aboutFocusNode,
                  onFieldSubmitted: (_) {
                    ctx.read<EditUserDetailFormBloc>().add(
                      FormSubmitted(form: _form),
                    );
                  },
                  validator: (about) {
                    return about == null || about.isEmpty
                        ? 'Inserisci informazioni'
                        : null;
                  },
                  onChanged: (about) {
                    ctx.read<EditUserDetailFormBloc>().add(
                      AboutChanged(about: about),
                    );
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Salva'),
                  onPressed: () {
                    ctx.read<EditUserDetailFormBloc>().add(
                      FormSubmitted(form: _form),
                    );
                  },
                ),
              ],
            )),
      ),
    );
  }
}
