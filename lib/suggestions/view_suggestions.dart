import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/suggestions/bloc/suggestions_bloc.dart';
import 'package:serophero/utils/datetime_utils.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';

class ViewSuggestions extends StatelessWidget {
  const ViewSuggestions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("View Suggestions"))),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Center(
          child: BlocBuilder<SuggestionsBloc, SuggestionsState>(
            builder: (context, state) {
              if (state is SuggestionsSuccess) {
                return Column(
                  children: state.suggestions.map((suggest) {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          // height: 100,
                          // width: MediaQuery.of(context).size.width / 1.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiary
                                    .withOpacity(0.05), // Shadow color
                                spreadRadius: 5, // Spread radius
                                blurRadius: 7, // Blur radius
                                offset:
                                    const Offset(0, 3), // Offset of the shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  //image
                                  CircleAvatar(
                                      radius: 15,
                                      backgroundImage: suggest.sender_image !=
                                              ""
                                          ? NetworkImage(
                                              "${AppUrls.baseUrl}/media/${suggest.sender_image}")
                                          : const AssetImage(
                                                  'assets/images/defaults/no_image_user.png')
                                              as ImageProvider<Object>
                                      // backgroundImage: AssetImage(
                                      //     'assets/images/defaults/no_image_user.png'),
                                      ),
                                  const SizedBox(width: 05),
                                  //user name
                                  Text(suggest.sender_name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ],
                              ),

                              //suggestions,
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.45,
                                child: Text(
                                  suggest.description,
                                  // "this is a suggestion text",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: true,
                                ),
                              ),

                              //datetime
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  padding: const EdgeInsets.only(top: 8),
                                  margin: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    DateTimeUtils.formatRelativeTime(
                                        suggest.datetime),
                                    // "Datetime",
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20)
                      ],
                    );
                  }).toList(),
                );
              }
              if (state is SuggestionsFailure) {
                return const Text("Failure");
              }
              if (state is SuggestionsLoading) {
                return const CircularProgressIndicator();
              }
              context.read<SuggestionsBloc>().add(SuggestionsPageOpened());
              return CustomElevatedButton(
                text: "Hawa",
                onPressed: () {
                  context.read<SuggestionsBloc>().add(SuggestionsPageOpened());
                },
              );
            },
          ),
        ),
      )),
    );
  }
}
