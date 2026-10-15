import 'package:equatable/equatable.dart';
import 'package:map_maker_new/types/enum/offer_plan_badge_kind.dart';
import 'package:map_maker_new/types/enum/plan_badge_tone.dart';
import 'package:map_maker_new/types/enum/plan_basis.dart';
import 'package:map_maker_new/types/enum/plan_designation.dart';
import 'package:map_maker_new/types/enum/plan_hint.dart';
import 'package:map_maker_new/types/models/offer.dart';
import 'package:map_maker_new/types/models/offer_plot.dart';

class OfferPlanBadge extends Equatable {
  final OfferPlanBadgeKind kind;
  final PlanBasis basis;
  final PlanDesignation? designation;
  final int otherDesignationsCount;
  final PlanBadgeTone tone;
  final PlanHint? hint;

  static const List<PlanBasis> _basesWithDesignation = [
    PlanBasis.mpzp,
    PlanBasis.pog,
    PlanBasis.pogDraft,
    PlanBasis.studium,
    PlanBasis.mixed,
  ];
  static const List<PlanBasis> _basesWithoutWz = [
    PlanBasis.pogDraft,
    PlanBasis.studium,
    PlanBasis.none,
  ];
  static const List<PlanDesignation> _buildingDesignations = [
    PlanDesignation.residential,
    PlanDesignation.residentialServices,
    PlanDesignation.farmstead,
    PlanDesignation.recreation,
    PlanDesignation.services,
    PlanDesignation.industrial,
  ];

  const OfferPlanBadge({
    required this.kind,
    required this.basis,
    required this.designation,
    required this.otherDesignationsCount,
    required this.tone,
    required this.hint,
  });

  factory OfferPlanBadge.fromOffer(Offer offer) {
    return OfferPlanBadge.fromPlanData(
      planBasis: offer.planBasis,
      designation: offer.designation,
      designations: offer.designations,
      infillArea: offer.infillArea,
    );
  }

  factory OfferPlanBadge.fromPlot(OfferPlot plot) {
    return OfferPlanBadge.fromPlanData(
      planBasis: plot.planBasis,
      designation: plot.designation,
      designations: plot.designations,
      infillArea: plot.infillArea,
    );
  }

  factory OfferPlanBadge.fromPlanData({
    required String planBasis,
    required String? designation,
    required List<String> designations,
    required bool? infillArea,
  }) {
    final PlanBasis basis = PlanBasis.fromApiValue(planBasis);
    final List<PlanDesignation> planDesignations =
        designations.map(PlanDesignation.fromApiValue).whereType<PlanDesignation>().toList();
    final PlanDesignation? planDesignation = PlanDesignation.fromApiValue(designation) ??
        (planDesignations.length == 1 ? planDesignations.first : null);
    final bool hasDesignationBasis = _basesWithDesignation.contains(basis);

    if (hasDesignationBasis && planDesignation != null) {
      return OfferPlanBadge(
        kind: OfferPlanBadgeKind.designation,
        basis: basis,
        designation: planDesignation,
        otherDesignationsCount: planDesignations.where((other) => other != planDesignation).toSet().length,
        tone: _getDesignationTone(planDesignation),
        hint: _buildingDesignations.contains(planDesignation) ? _getHint(basis, infillArea) : null,
      );
    } else if (hasDesignationBasis && planDesignations.length > 1) {
      return OfferPlanBadge(
        kind: OfferPlanBadgeKind.mixedDesignations,
        basis: basis,
        designation: null,
        otherDesignationsCount: 0,
        tone: PlanBadgeTone.brand,
        hint: null,
      );
    }
    return OfferPlanBadge(
      kind: OfferPlanBadgeKind.basis,
      basis: basis,
      designation: null,
      otherDesignationsCount: 0,
      tone: _getBasisTone(basis),
      hint: _getHint(basis, infillArea),
    );
  }

  static PlanHint? _getHint(PlanBasis basis, bool? infillArea) {
    if (basis == PlanBasis.pog) {
      if (infillArea == true) return PlanHint.wzPossible;
      if (infillArea == false) return PlanHint.needsMpzp;
      return PlanHint.checkInfill;
    } else if (_basesWithoutWz.contains(basis)) {
      return PlanHint.noWzWithoutPog;
    }
    return null;
  }

  static PlanBadgeTone _getDesignationTone(PlanDesignation designation) {
    switch (designation) {
      case PlanDesignation.residential:
      case PlanDesignation.residentialServices:
      case PlanDesignation.farmstead:
        return PlanBadgeTone.success;
      case PlanDesignation.recreation:
      case PlanDesignation.services:
      case PlanDesignation.industrial:
        return PlanBadgeTone.brand;
      case PlanDesignation.agricultural:
      case PlanDesignation.forest:
      case PlanDesignation.green:
      case PlanDesignation.open:
      case PlanDesignation.water:
        return PlanBadgeTone.nature;
      case PlanDesignation.transport:
      case PlanDesignation.infrastructure:
      case PlanDesignation.cemetery:
      case PlanDesignation.other:
        return PlanBadgeTone.neutral;
    }
  }

  static PlanBadgeTone _getBasisTone(PlanBasis basis) {
    switch (basis) {
      case PlanBasis.unknown:
        return PlanBadgeTone.neutral;
      case PlanBasis.mpzp:
      case PlanBasis.mpzpUnreadable:
      case PlanBasis.pog:
      case PlanBasis.mixed:
        return PlanBadgeTone.brand;
      case PlanBasis.wz:
        return PlanBadgeTone.success;
      case PlanBasis.pogDraft:
      case PlanBasis.studium:
      case PlanBasis.none:
        return PlanBadgeTone.warning;
    }
  }

  bool get isMixed => basis == PlanBasis.mixed || kind == OfferPlanBadgeKind.mixedDesignations;

  @override
  List<Object?> get props => [kind, basis, designation, otherDesignationsCount, tone, hint];
}
