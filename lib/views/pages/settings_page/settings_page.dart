import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/controllers/auth_cubit/auth_cubit.dart';
import 'package:housing_project/views/pages/settings_page/widgets/logout_button.dart';
import 'package:housing_project/views/pages/settings_page/widgets/settings_page_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AuthCubit>(context);
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is AuthLoading ||
          current is AuthError ||
          current is AuthSuccess,
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is AuthError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is AuthSuccess) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02, horizontal: size.width * 0.02),
              child: Column(
                children: [
                  SettingsPageCard(user: state.user),
                  SizedBox(height: size.height * 0.02),
                  SettingsPageCard(
                    user: state.user,
                    isChangePassword: true,
                  ),
                  const Spacer(),
                  const LogoutButton(),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
