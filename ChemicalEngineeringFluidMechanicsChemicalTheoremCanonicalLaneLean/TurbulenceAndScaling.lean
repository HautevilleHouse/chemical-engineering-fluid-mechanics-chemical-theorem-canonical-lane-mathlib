import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean

structure TurbulenceScalingCertificate where
  reynoldsNumber : ℝ
  dissipationRate : ℝ
  kolmogorovScale : ℝ
  integralScale : ℝ
  energySpectrumSlope : ℝ
  dissipationRateClosed : dissipationRate > 0
  kolmogorovScaleClosed : kolmogorovScale > 0
  energySpectrumSlopeClosed : energySpectrumSlope = -5/3

def initialTurbulenceCertificate : TurbulenceScalingCertificate := {
  reynoldsNumber := 10000
  dissipationRate := 0.1
  kolmogorovScale := 0.001
  integralScale := 1.0
  energySpectrumSlope := -1.6666666666666667
  dissipationRateClosed := by norm_num
  kolmogorovScaleClosed := by norm_num
  energySpectrumSlopeClosed := by norm_num
}

def TurbulenceScalingClosed (C : TurbulenceScalingCertificate) : Prop :=
  C.dissipationRate > 0 ∧ C.kolmogorovScale > 0 ∧ C.energySpectrumSlope = -5/3

theorem initial_turbulence_scaling_closed : TurbulenceScalingClosed initialTurbulenceCertificate := by
  exact And.intro (by exact initialTurbulenceCertificate.dissipationRateClosed) (
    And.intro initialTurbulenceCertificate.kolmogorovScaleClosed initialTurbulenceCertificate.energySpectrumSlopeClosed)

end ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean
end HautevilleHouse