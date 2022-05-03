import 'package:fitness/constants/colors.dart';
import 'package:fitness/constants/font.dart';
import 'package:fitness/constants/image_path.dart';
import 'package:fitness/constants/string.dart';
import 'package:fitness/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppText.hi,
              style: TextStyle(
                fontSize: 32,
                fontFamily: AppFont.nunito,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 40),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeInitial) {
                  return Container();
                } else if (state is HomeLoading) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Shimmer(
                      duration: const Duration(seconds: 2),
                      color: (context.themeValue(
                        light: AppColor.black,
                        dark: AppColor.white,
                      ) as Color)
                          .withOpacity(0.005),
                      child: Container(
                        color: (context.themeValue(
                          light: AppColor.black,
                          dark: AppColor.white,
                        ) as Color)
                            .withOpacity(0.05),
                        alignment: Alignment.center,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(),
                          child: const IgnorePointer(
                            child: Opacity(
                              opacity: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (state is HomeSuccess) {
                  return Column(
                    children: [
                      HomeCardWidget(
                        iconPath: ImagePath(context).iconFootSteps,
                        heading: AppText.steps,
                        value: state.steps.toDouble(),
                        title: '${state.steps}',
                        goal: '15,000',
                      ),
                      HomeCardWidget(
                        iconPath: ImagePath(context).iconKcal,
                        heading: AppText.caloriesBurned,
                        value: state.calories.toDouble(),
                        title: '${state.calories}',
                        goal: '15,000',
                      )
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      HomeCardWidget(
                        iconPath: ImagePath(context).iconFootSteps,
                        heading: AppText.steps,
                        value: 0,
                        title: '0',
                        goal: '15,000',
                      ),
                      HomeCardWidget(
                        iconPath: ImagePath(context).iconKcal,
                        heading: AppText.caloriesBurned,
                        value: 0,
                        title: '0',
                        goal: '15,000',
                      ),
                      const ErrorPage(),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({
    required this.title,
    required this.goal,
    required this.iconPath,
    required this.heading,
    required this.value,
    Key? key,
  }) : super(key: key);
  final String iconPath;
  final String title;
  final String goal;
  final String heading;
  final double value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 122,
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17, 16, 8, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '$heading: ',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: AppFont.montserrat,
                            ),
                          ),
                          TextSpan(
                            text: title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.nunito,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Flexible(
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: value / 100,
                          valueColor: AlwaysStoppedAnimation(
                            context.themeValue(
                              light: AppColor.black,
                              dark: AppColor.white,
                            ) as Color,
                          ),
                          backgroundColor: AppColor.white,
                          minHeight: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '0',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppFont.nunito,
                          ),
                        ),
                        Text(
                          '${AppText.goal}: $goal',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppFont.nunito,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 21),
              SizedBox(
                height: 52,
                width: 52,
                child: Image.asset(iconPath),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              AppText.error,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            TextButton(
              onPressed: () => context.read<HomeCubit>().fetchHealthData(),
              child: const Text(AppText.retry),
            ),
            const TextButton(
              onPressed: SystemNavigator.pop,
              child: Text(AppText.exit),
            ),
          ],
        ),
      ),
    );
  }
}
