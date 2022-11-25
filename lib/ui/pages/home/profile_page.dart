import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/user_auth_cubit/user_auth_cubit.dart';
import '../../components/auth/link.dart';
import '../../components/wrappers/page_wrapper.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      pageTitle: 'Профиль',
      pageTitleAction: Link(
        text: 'Выйти',
        onPress: BlocProvider.of<UserAuthCubit>(context).logOut,
      ),
      children: const [],
    );
  }
}
