import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean

structure VortexCertificate where
  vorticityField : VectorField
  circulation : ℝ
  coreRadius : ℝ
  circulationNonZero : circulation ≠ 0
  coreRadiusPos : coreRadius > 0

def sampleVortex : VortexCertificate := {
  vorticityField := fun _ _ _ => 1
  circulation := 2.0
  coreRadius := 0.5
  circulationNonZero := by norm_num
  coreRadiusPos := by norm_num
}

def VortexDynamicsClosed (C : VortexCertificate) : Prop :=
  C.circulation ≠ 0 ∧ C.coreRadius > 0

theorem sample_vortex_dynamics_closed : VortexDynamicsClosed sampleVortex := by
  exact And.intro sampleVortex.circulationNonZero sampleVortex.coreRadiusPos

end ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean
end HautevilleHouse