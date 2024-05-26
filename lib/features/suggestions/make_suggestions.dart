import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/suggestions/bloc/suggestions_bloc.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';
import 'package:serophero/widgets/custom_textfield.dart';
import 'package:serophero/widgets/snackbar.dart';

class DropSuggestions extends StatelessWidget {
  const DropSuggestions({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController suggestionController = TextEditingController();
    return BlocListener<SuggestionsBloc, SuggestionsState>(
      listener: (context, state) {
        if (state is SuggestionsProfane) {
          MySnackbar.show(
            context,
            title: "Profane Detected",
            message: state.error,
            type: SnackbarType.error,
          );
        }
        if (state is SuggestionsFailure) {
          MySnackbar.show(
            context,
            title: "Unsuccesful",
            message: state.error,
            type: SnackbarType.error,
          );
        }
        if (state is PostSuggestionSuccess) {
          MySnackbar.show(
            context,
            title: "Suggestion Drop Successful",
            message: "Your suggestion has been dropped succesfully.",
            type: SnackbarType.success,
          );
          suggestionController.clear();
        }
        // if(state is SuggestionsFailure){}
      },
      child: Scaffold(
          appBar: AppBar(title: const Center(child: Text("Drop Suggestions"))),
          body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Column(
                  children: [
                    CustomTextFormField(
                      context: context,
                      hintText: "Suggestions",
                      controller: suggestionController,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<SuggestionsBloc, SuggestionsState>(
                      builder: (context, state) {
                        return CustomElevatedButton(
                          isLoading: state is SuggestionsLoading,
                          text: "Drop Suggestions",
                          backgroundColorBtn:
                              Theme.of(context).colorScheme.primary,
                          onPressed: () {
                            context.read<SuggestionsBloc>().add(PostSuggestions(
                                description: suggestionController.text.trim()));
                          },
                        );
                      },
                    )
                  ],
                )),
          )),
    );
  }
}
