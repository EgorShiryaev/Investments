import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../dependency_injection.dart';
import '../../../logic/models/login_data.dart';
import '../../blocs/auth/user_auth_cubit/user_auth_state.dart';
import '../../blocs/favorites/quotes_cubit.dart/quotes_cubit.dart';
import '../../blocs/index.dart';
import '../../components/modals/error_modal.dart';
import '../../pages/home_tab_page.dart';
import 'auth_navigation_cubit_view.dart';

class UserAuthCubitView extends StatelessWidget {
  const UserAuthCubitView({super.key});

  void blocListner(BuildContext context, UserAuthState state) {
    if (state is! InitialUserAuthState && state is! UserIsAuth) {
      FlutterNativeSplash.remove();
    }
    if (state is AutologinFailureAuthState) {
      ErrorModal.show(
        context,
        message: 'Во время авторизации произошла ошибка',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserAuthCubit>(
      create: (context) => getIt<UserAuthCubit>()..checkUserAuthState(),
      child: BlocListener<UserAuthCubit, UserAuthState>(
        listener: blocListner,
        child: BlocBuilder<UserAuthCubit, UserAuthState>(
          builder: (context, state) {
            LoginData? loginData;
            if (state is UserIsAuth) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider<FavoriteInstrumentsCubit>(
                    create: (context) =>
                        getIt<FavoriteInstrumentsCubit>()..load(),
                  ),
                  BlocProvider<QuotesCubit>(
                    create: (context) => getIt<QuotesCubit>()..connect(),
                  ),
                ],
                child: const HomeTabsPage(),
              );
            } else if (state is AutologinFailureAuthState) {
              loginData = state.loginData;
            }
            return AuthNavigationCubitView(previousLoginData: loginData);
          },
        ),
      ),
    );
  }
}
