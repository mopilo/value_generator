import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:netguru_value_generator/features/splash/splash_bloc.dart';
import 'package:mockito/mockito.dart';


void main() {

  late SplashCubit splashCubit;

  setUp(() {
    splashCubit = SplashCubit();
  });

  tearDown(() {
    splashCubit.close();
  });

  test("Should start with initial state", () {
    expect(splashCubit.state, SplashInitialState());
  });

  blocTest(
    "Should navigate to main screen after authorization is finished",
    build: () => splashCubit,
    act: (SplashCubit bloc) async {
      await Future.delayed(const Duration(seconds: 2));
    },
    expect: () => [SplashAuthorizedState()]
  );
}
