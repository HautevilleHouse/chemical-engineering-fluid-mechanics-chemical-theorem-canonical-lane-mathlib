import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean

def ConstrainedFluidMechanicsClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_fluid_mechanics_closure (A : AdmissibleClass) :
    ConstrainedFluidMechanicsClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean
end HautevilleHouse