import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean

structure TwoPhaseFlowCertificate where
  phase1Velocity : VectorField
  phase2Velocity : VectorField
  surfaceTension : ℝ
  density1 : ℝ
  density2 : ℝ
  phase1VelocityNonZero : phase1Velocity ≠ 0
  surfaceTensionPos : surfaceTension > 0
  density1Pos : density1 > 0
  density2Pos : density2 > 0

def sampleTwoPhaseFlow : TwoPhaseFlowCertificate := {
  phase1Velocity := fun _ _ _ => 1
  phase2Velocity := fun _ _ _ => 0
  surfaceTension := 0.07
  density1 := 1000
  density2 := 1
  phase1VelocityNonZero := by
    intro h; have : zeroVectorField = 0 := rfl; exact h
  surfaceTensionPos := by norm_num
  density1Pos := by norm_num
  density2Pos := by norm_num
}

def TwoPhaseFlowClosed (C : TwoPhaseFlowCertificate) : Prop :=
  C.phase1Velocity ≠ 0 ∧ C.surfaceTension > 0 ∧ C.density1 > 0 ∧ C.density2 > 0

theorem sample_two_phase_flow_closed : TwoPhaseFlowClosed sampleTwoPhaseFlow := by
  exact And.intro sampleTwoPhaseFlow.phase1VelocityNonZero (
    And.intro sampleTwoPhaseFlow.surfaceTensionPos (
      And.intro sampleTwoPhaseFlow.density1Pos sampleTwoPhaseFlow.density2Pos))

end ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean
end HautevilleHouse