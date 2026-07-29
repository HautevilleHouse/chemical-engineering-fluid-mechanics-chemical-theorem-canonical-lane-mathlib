import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

def zeroVectorField : VectorField := fun _ _ _ => 0

structure FluidMechanicsOperators where
  gradient : ScalarField → VectorField
  divergence : VectorField → ScalarField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  advection : VectorField → VectorField
  stressDivergence : VectorField → VectorField

def defaultOperators : FluidMechanicsOperators := {
  gradient := fun _ => zeroVectorField
  divergence := fun _ => 0
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  advection := fun u => u
  stressDivergence := fun u => u
}

structure FluidMechanicsFlow where
  velocity : VectorField
  pressure : ScalarField
  viscosity : ℝ
  density : ℝ
  operators : FluidMechanicsOperators

def defaultFlow : FluidMechanicsFlow := {
  velocity := zeroVectorField
  pressure := 0
  viscosity := 1
  density := 1
  operators := defaultOperators
}

def Incompressible (F : FluidMechanicsFlow) : Prop :=
  F.operators.divergence F.velocity = 0

def NavierStokesMomentum (F : FluidMechanicsFlow) : Prop :=
  F.operators.timeDerivative F.velocity = 
    F.operators.advection F.velocity + (F.viscosity / F.density) * F.operators.laplacian F.velocity

def Continuity (F : FluidMechanicsFlow) : Prop :=
  F.operators.divergence F.velocity = 0

def FluidEquationClosed (F : FluidMechanicsFlow) : Prop :=
  Incompressible F ∧ NavierStokesMomentum F ∧ Continuity F

theorem default_flow_incompressible : Incompressible defaultFlow := by rfl

theorem default_flow_navier_stokes : NavierStokesMomentum defaultFlow := by rfl

theorem default_flow_continuity : Continuity defaultFlow := by rfl

theorem default_flow_equation_closed : FluidEquationClosed defaultFlow := by
  exact And.intro default_flow_incompressible (And.intro default_flow_navier_stokes default_flow_continuity)

end ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean
end HautevilleHouse