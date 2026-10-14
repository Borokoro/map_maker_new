import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/cubits/search/search_cubit.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/service_locator.dart';
import 'package:map_maker_new/types/custom_types/offer_search_criteria.dart';
import 'package:map_maker_new/types/models/offer_location_count.dart';
import 'package:map_maker_new/types/models/offer_locations.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';

class LocationFilter extends StatefulWidget {
  const LocationFilter({
    super.key,
    required this.searchCriteria,
    required this.onChanged,
  });

  final OfferSearchCriteria searchCriteria;
  final void Function(OfferSearchCriteria) onChanged;

  @override
  State<LocationFilter> createState() => _LocationFilterState();
}

class _LocationFilterState extends State<LocationFilter> {
  final SearchCubit _cubit = serviceLocator.get<SearchCubit>();
  late Future<OfferLocations> _locations;

  @override
  void initState() {
    super.initState();
    _locations = _getLocations();
  }

  @override
  void didUpdateWidget(covariant LocationFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchCriteria.voivodeship != widget.searchCriteria.voivodeship ||
        oldWidget.searchCriteria.county != widget.searchCriteria.county) {
      _locations = _getLocations();
    }
  }

  Future<OfferLocations> _getLocations() {
    return _cubit.getLocations(
      voivodeship: widget.searchCriteria.voivodeship,
      county: widget.searchCriteria.county,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OfferLocations>(
      future: _locations,
      builder: (BuildContext context, AsyncSnapshot<OfferLocations> snapshot) {
        return _getDropdowns(context, snapshot.data);
      },
    );
  }

  Widget _getDropdowns(BuildContext context, OfferLocations? locations) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final OfferSearchCriteria criteria = widget.searchCriteria;

    return Column(
      children: [
        _getDropdown(
          label: localizations.voivodeship,
          placeholder: localizations.voivodeshipPlaceholder,
          value: criteria.voivodeship,
          options: locations?.voivodeships ?? const [],
          onChanged: (String? voivodeship) => widget.onChanged(
            criteria.copyWith(voivodeship: () => voivodeship, county: () => null, commune: () => null),
          ),
        ),
        _getDropdown(
          label: localizations.county,
          placeholder: criteria.voivodeship == null
              ? localizations.pickVoivodeshipFirst
              : localizations.countyPlaceholder,
          value: criteria.county,
          options: criteria.voivodeship == null ? const [] : locations?.counties ?? const [],
          isEnabled: criteria.voivodeship != null,
          onChanged: (String? county) => widget.onChanged(
            criteria.copyWith(county: () => county, commune: () => null),
          ),
        ),
        _getDropdown(
          label: localizations.commune,
          placeholder: criteria.county == null
              ? localizations.pickCountyFirst
              : localizations.communePlaceholder,
          value: criteria.commune,
          options: criteria.county == null ? const [] : locations?.communes ?? const [],
          isEnabled: criteria.county != null,
          onChanged: (String? commune) => widget.onChanged(criteria.copyWith(commune: () => commune)),
        ),
      ].withVerticalElementsSpacing(12),
    );
  }

  Widget _getDropdown({
    required String label,
    required String placeholder,
    required String? value,
    required List<OfferLocationCount> options,
    required void Function(String?) onChanged,
    bool isEnabled = true,
  }) {
    final bool isValueMissing = value != null && options.every((option) => option.name != value);

    return DropdownButtonFormField<String?>(
      key: ValueKey("$label-$value-${options.length}"),
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.borderDefault),
        ),
      ),
      hint: Text(placeholder),
      items: [
        DropdownMenuItem<String?>(value: null, child: Text(placeholder)),
        if (isValueMissing) DropdownMenuItem<String?>(value: value, child: Text(value)),
        for (final OfferLocationCount option in options)
          DropdownMenuItem<String?>(
            value: option.name,
            child: Text(AppLocalizations.of(context)!.locationWithCount(option.name, option.count)),
          ),
      ],
      onChanged: isEnabled ? onChanged : null,
    );
  }
}
