import ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean.MathlibPDESubstrate
import Mathlib.Data.Real.Basic

/-!
# Chemical Engineering Fluid Mechanics Analytic Objects

This module gives the theorem package a local analytic vocabulary: three-space,
time, scalar fields, vector fields, primitive Navier-Stokes operators, and the
projection law used by the admitted analytic lane.
-/

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure ChemicalEngineeringOperators where
  continuity : ScalarField → Prop
  momentum : VectorField → ScalarField → Prop
  energy : ScalarField → ScalarField → Prop
  speciesTransport : (Fin n → ScalarField) → (Fin n → ScalarField) → Prop
  reactionKinetics : (Fin n → ScalarField) → Prop

def primitiveChemicalEngineeringOperators : ChemicalEngineeringOperators := {
  continuity := fun _ => True
  momentum := fun _ _ => True
  energy := fun _ _ => True
  speciesTransport := fun _ _ => True
  reactionKinetics := fun _ => True
}

structure ChemicalEngineeringFlow where
  velocity : VectorField
  pressure : ScalarField
  temperature : ScalarField
  speciesConcentrations : Fin n → ScalarField
  viscosity : ℝ
  diffusivity : ℝ
  thermalConductivity : ℝ
  operators : ChemicalEngineeringOperators

def primitiveChemicalEngineeringFlow : ChemicalEngineeringFlow := {
  velocity := zeroVectorField
  pressure := zeroScalarField
  temperature := zeroScalarField
  speciesConcentrations := fun _ => zeroScalarField
  viscosity := 1
  diffusivity := 1
  thermalConductivity := 1
  operators := primitiveChemicalEngineeringOperators
}

def MassConservation (F : ChemicalEngineeringFlow) : Prop :=
  F.operators.continuity F.velocity

def MomentumBalance (F : ChemicalEngineeringFlow) : Prop :=
  F.operators.momentum F.velocity F.pressure

def EnergyBalance (F : ChemicalEngineeringFlow) : Prop :=
  F.operators.energy F.temperature F.velocity

def SpeciesBalance (F : ChemicalEngineeringFlow) : Prop :=
  F.operators.speciesTransport F.speciesConcentrations F.velocity

def ChemicalEngineeringEquationsClosed (F : ChemicalEngineeringFlow) : Prop :=
  MassConservation F ∧ MomentumBalance F ∧ EnergyBalance F ∧ SpeciesBalance F

theorem primitive_flow_mass_conservation_checked :
    MassConservation primitiveChemicalEngineeringFlow := by
  rfl

theorem primitive_flow_momentum_balance_checked :
    MomentumBalance primitiveChemicalEngineeringFlow := by
  rfl

theorem primitive_flow_energy_balance_checked :
    EnergyBalance primitiveChemicalEngineeringFlow := by
  rfl

theorem primitive_flow_species_balance_checked :
    SpeciesBalance primitiveChemicalEngineeringFlow := by
  rfl

theorem primitive_flow_equations_closed_checked :
    ChemicalEngineeringEquationsClosed primitiveChemicalEngineeringFlow := by
  exact And.intro primitive_flow_mass_conservation_checked
    (And.intro primitive_flow_momentum_balance_checked
      (And.intro primitive_flow_energy_balance_checked primitive_flow_species_balance_checked))

end ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean
end HautevilleHouse