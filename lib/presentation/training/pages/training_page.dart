import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TrainingPage extends StatelessWidget {
  const TrainingPage({required this.trainingSettings, Key? key}) : super(key: key);

  static const routeName = '/training';
  static const argTrainingSettings = 'argTrainingSettings';
  static Route route({required TrainingSettings trainingSettings}) {
    return MaterialPageRoute(builder: (context) => TrainingPage(trainingSettings: trainingSettings));
  }

  final TrainingSettings trainingSettings;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WriterBloc(strokeReducer: StrokeReducer(maxPointsQuantity: 20), kanaChecker: KanaChecker())),
        BlocProvider(create: (context) {
          return ListBloc(BlocProvider.of<WriterBloc>(context), WordsRepository(), StatisticsRepository())..add(ListStarted(trainingSettings));
        }),
        BlocProvider(create: (context) => TrainingBloc(BlocProvider.of<ListBloc>(context))),
        BlocProvider(create: (context) => WordBloc(BlocProvider.of<ListBloc>(context))),
        BlocProvider(create: (context) => KanaBloc(BlocProvider.of<ListBloc>(context))),
      ],
      child: TrainingView(trainingSettings: trainingSettings),
    );
  }
}

class TrainingView extends StatefulWidget {
  const TrainingView({required this.trainingSettings, Key? key}) : super(key: key);

  final TrainingSettings trainingSettings;

  @override
  _TrainingViewState createState() => _TrainingViewState();
}

class _TrainingViewState extends State<TrainingView> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _buildQuitDialog(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(IconUrl.quitTraining, color: Theme.of(context).primaryIconTheme.color),
            onPressed: () => _buildQuitDialog(context),
          ),
        ),
        body: BlocListener<ListBloc, ListState>(
          listenWhen: (previous, current) {
            return previous != current;
          },
          listener: (context, state) {
            if (state is ListPageReady) {
              _pageController.animateToPage(
                state.wordIndex,
                duration: Duration(milliseconds: state.changePageDurationInMilliseconds),
                curve: Curves.easeInOutCubic,
              );
            }
            if (state is TrainingEnded) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                ReviewPage.routeName,
                (route) => route.isFirst,
                arguments: {ReviewPage.argWordsResult: state.words},
              );
            }
          },
          child: BlocBuilder<TrainingBloc, TrainingState>(
            builder: (context, trainingState) {
              if (trainingState is TrainingReady) {
                return Column(
                  children: [
                    BlocBuilder<WordBloc, WordState>(
                      builder: (context, wordState) {
                        return StepProgressIndicator(
                          currentStep: (wordState is WordReady) ? wordState.index : 0,
                          totalSteps: (wordState is WordReady) ? wordState.total : 1,
                          size: Device.get().isTablet ? 6 : 5,
                          padding: 0.5,
                          selectedColor: Theme.of(context).colorScheme.secondary,
                          unselectedColor: Colors.grey.shade400,
                        );
                      },
                    ),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return PageView.builder(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: (context.watch<WordBloc>().state is WordReady) ? (context.watch<WordBloc>().state as WordReady).total : 1,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  const Spacer(),
                                  BlocBuilder<WordBloc, WordState>(
                                    builder: (context, wordState) {
                                      return GestureDetector(
                                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text((wordState as WordReady).translate),
                                            duration: const Duration(seconds: 1),
                                          ),
                                        ),
                                        child: SvgPicture.asset((wordState as WordReady).imageUrl, height: constraints.maxHeight * 10 / 30),
                                      );
                                    },
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: KanaViewers(
                                      width: constraints.maxWidth - 16 * 2, // 16 * 2 is the padding size for this content
                                      height: constraints.maxHeight * 4 / 30,
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 32),
                                    child: Writer(
                                      squareSize: constraints.maxHeight * 12 / 30,
                                      borderSize: 9,
                                      showHint: widget.trainingSettings.showHint,
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }

              return const Shimmer(child: ShimmerTrainingView());
            },
          ),
        ),
      ),
    );
  }

  void _buildQuitDialog(BuildContext context) {
    final strings = JStrings.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(strings.trainingQuitTitle),
        content: Text(strings.trainingQuitContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(strings.trainingQuitAnswerNo),
          ),
          TextButton(
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            child: Text(strings.trainingQuitAnswerYes),
          ),
        ],
      ),
    );
  }
}
