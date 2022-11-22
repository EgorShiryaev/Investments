import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/user_auth_cubit/user_auth_cubit.dart';
import '../../components/link.dart';
import '../../components/page_wrapper.dart';

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
