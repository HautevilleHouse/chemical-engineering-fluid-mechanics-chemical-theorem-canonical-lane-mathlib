import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean

structure BoundaryLayerCertificate where
  boundaryThickness : ℝ
  pressureGradient : ScalarField
  shearStress : VectorField
  boundaryThicknessPos : boundaryThickness > 0
  shearStressNonZero : shearStress ≠ 0

def sampleBoundaryLayer : BoundaryLayerCertificate := {
  boundaryThickness := 0.01
  pressureGradient := fun _ _ => 0
  shearStress := fun _ _ _ => 1
  boundaryThicknessPos := by norm_num
  shearStressNonZero := by
    intro h; have : zeroVectorField = 0 := rfl; exact h
}

def BoundaryLayerClosed (C : BoundaryLayerCertificate) : Prop :=
  C.boundaryThickness > 0 ∧ C.shearStress ≠ 0

theorem sample_boundary_layer_closed : BoundaryLayerClosed sampleBoundaryLayer := by
  exact And.intro sampleBoundaryLayer.boundaryThicknessPos sampleBoundaryLayer.shearStressNonZero

end ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean
end HautevilleHouse