import 'package:branches_presences_5/app/bloc/app_bloc.dart';
import 'package:branches_presences_5/app/utils/email_validation.dart';
import 'package:branches_presences_5/app/widget/confirm_message_dialog.dart';
import 'package:branches_presences_5/users/bloc/edit_user_detail_form/edit_user_detail_form_bloc.dart';
import 'package:branches_presences_5/users/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/widget/widget.dart';

class EditUserDetailView extends StatelessWidget {
  final User currentUser;
  final _form = GlobalKey<FormState>();

  EditUserDetailView({Key? key, required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);
    return BlocConsumer<EditUserDetailFormBloc, EditUserDetailFormState>(
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
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Elaborazione...')),
            );
        }
        if (state.status == EditUserDetailFormStatus.submissionSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          context.read<AppBloc>().add(const FetchAppUser());
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
                  text: currentUser.name,
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
                  text: currentUser.email,
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
                  text: currentUser.about,
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
