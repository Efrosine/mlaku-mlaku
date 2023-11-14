import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mlaku_mlaku/features/presentation/bloc/booking/booking_hotels_bloc.dart';

class CTextfiedSearch extends StatelessWidget {
  const CTextfiedSearch(
      {super.key,
      required this.options,
      required this.label,
      required this.icons,
      required this.onSaved,
      this.isEnable = true});

  final IconData icons;
  final String label;
  final Function(String?) onSaved;
  final List<String> options;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (value) {
        if (value.text.isEmpty) return options;
        return options
            .where((element) => element.toLowerCase().contains(value.text.toLowerCase()));
      },
      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFormField(
          enabled: isEnable,
          controller: textEditingController,
          focusNode: focusNode,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value!.isEmpty) {
              context.read<BookingHotelsBloc>().add(BookingFirstDesChanged(value, false));
              return 'Tidak boleh kosong';
            } else if (!options.contains(value)) {
              context.read<BookingHotelsBloc>().add(BookingFirstDesChanged(value, false));
              return 'pilihan tidak valid';
            }
            context.read<BookingHotelsBloc>().add(BookingFirstDesChanged(value, true));
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            prefixIcon: Icon(icons),
            suffixIcon: Icon(Icons.arrow_drop_down_rounded),
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          onTapOutside: (event) => focusNode.unfocus(),
          onSaved: onSaved,
        );
      },
    );
  }
}