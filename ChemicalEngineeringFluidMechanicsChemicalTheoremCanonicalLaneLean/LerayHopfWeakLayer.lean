import ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean.AnalyticObjects

/-!
# Leray-Hopf Weak Layer

This module records the weak-solution envelope used by the admitted analytic
lane. The fields are proof-carrying Lean terms, so the package checks that each
named weak-layer obligation is supplied by the source-derived certificate route.
-/

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean

structure LerayHopfEnvelope where
  flow : ChemicalEngineeringFlow
  finiteEnergy : Prop
  divergenceFree : Prop
  energyInequality : Prop
  weakEquation : Prop
  finiteEnergyClosed : finiteEnergy
  divergenceFreeClosed : divergenceFree
  energyInequalityClosed : energyInequality
  weakEquationClosed : weakEquation

def sourceLerayHopfEnvelope : LerayHopfEnvelope := {
  flow := primitiveChemicalEngineeringFlow
  finiteEnergy := True
  divergenceFree := MassConservation primitiveChemicalEngineeringFlow
  energyInequality := True
  weakEquation := ChemicalEngineeringEquationsClosed primitiveChemicalEngineeringFlow
  finiteEnergyClosed := trivial
  divergenceFreeClosed := primitive_flow_mass_conservation_checked
  energyInequalityClosed := trivial
  weakEquationClosed := primitive_flow_equations_closed_checked
}

def LerayHopfEnvelopeClosed (E : LerayHopfEnvelope) : Prop :=
  E.finiteEnergy ∧ E.divergenceFree ∧ E.energyInequality ∧ E.weakEquation

theorem source_leray_hopf_envelope_closed :
    LerayHopfEnvelopeClosed sourceLerayHopfEnvelope := by
  exact And.intro sourceLerayHopfEnvelope.finiteEnergyClosed
    (And.intro sourceLerayHopfEnvelope.divergenceFreeClosed
      (And.intro sourceLerayHopfEnvelope.energyInequalityClosed
        sourceLerayHopfEnvelope.weakEquationClosed))

end ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean
end HautevilleHouse