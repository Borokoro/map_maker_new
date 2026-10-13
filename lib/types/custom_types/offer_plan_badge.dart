import 'package:equatable/equatable.dart';
import 'package:map_maker_new/types/enum/offer_plan_badge_kind.dart';
import 'package:map_maker_new/types/enum/plan_badge_tone.dart';
import 'package:map_maker_new/types/enum/plan_basis.dart';
import 'package:map_maker_new/types/enum/plan_designation.dart';
import 'package:map_maker_new/types/enum/plan_hint.dart';
import 'package:map_maker_new/types/models/offer.dart';

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
    final PlanBasis basis = PlanBasis.fromApiValue(offer.planBasis);
    final List<PlanDesignation> designations =
        offer.designations.map(PlanDesignation.fromApiValue).whereType<PlanDesignation>().toList();
    final PlanDesignation? designation = PlanDesignation.fromApiValue(offer.designation) ??
        (designations.length == 1 ? designations.first : null);
    final bool hasDesignationBasis = _basesWithDesignation.contains(basis);

    if (hasDesignationBasis && designation != null) {
      return OfferPlanBadge(
        kind: OfferPlanBadgeKind.designation,
        basis: basis,
        designation: designation,
        otherDesignationsCount: designations.where((other) => other != designation).toSet().length,
        tone: _getDesignationTone(designation),
        hint: _buildingDesignations.contains(designation) ? _getHint(basis, offer.infillArea) : null,
      );
    }
    if (hasDesignationBasis && designations.length > 1) {
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
      hint: _getHint(basis, offer.infillArea),
    );
  }

  static PlanHint? _getHint(PlanBasis basis, bool? infillArea) {
    if (basis == PlanBasis.pog) {
      if (infillArea == true) return PlanHint.wzPossible;
      if (infillArea == false) return PlanHint.needsMpzp;
      return PlanHint.checkInfill;
    }
    if (_basesWithoutWz.contains(basis)) return PlanHint.noWzWithoutPog;
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

  @override
  List<Object?> get props => [kind, basis, designation, otherDesignationsCount, tone, hint];
}
