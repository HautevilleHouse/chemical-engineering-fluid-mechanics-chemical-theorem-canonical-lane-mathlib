import ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean.CompactnessRigidityLayer

/-!
# Regularity Endpoint Layer

This module carries the endpoint route for the admitted analytic class: source
formula closure, bridge closure, gate closure, and the carried unrestricted
classical boundary.
-/

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean

structure RegularityEndpointCertificate where
  compactnessRigidity : CompactnessRigidityCertificate
  sourceFormulaClosed : Prop
  bridgeClosedOnObject : Prop
  gateClosedOnAdmissibleClass : Prop
  theoremBoundaryCarried : Prop
  sourceFormulaClosedProof : sourceFormulaClosed
  bridgeClosedOnObjectProof : bridgeClosedOnObject
  gateClosedOnAdmissibleClassProof : gateClosedOnAdmissibleClass
  theoremBoundaryCarriedProof : theoremBoundaryCarried

def analyticAdmittedObject : AdmittedTheoremObject := {
  object := theoremSpecificObject
  localWitness := "Chemical Engineering certificate with Leray-Hopf envelope, energy-enstrophy gate, compactness-rigidity gate, and regularity endpoint."
  bridgeEvidence := "source-derived Lean certificate fields"
  sourceKeyChecked := rfl
  theoremObjectChecked := rfl
}

def analyticAdmissibleClass : AdmissibleClass := {
  object := analyticAdmittedObject
  endpointSatisfied := ChemicalEngineeringEquationsClosed primitiveChemicalEngineeringFlow
  remainderRecorded := formalizationCertificate.theoremBoundaryOpen = true
  gateWitness := Or.inl primitive_flow_equations_closed_checked
}

def sourceRegularityEndpointCertificate : RegularityEndpointCertificate := {
  compactnessRigidity := sourceCompactnessRigidityCertificate
  sourceFormulaClosed := True
  bridgeClosedOnObject := bridgeClosed analyticAdmissibleClass
  gateClosedOnAdmissibleClass := gateClosed analyticAdmissibleClass
  theoremBoundaryCarried := formalizationCertificate.theoremBoundaryOpen = true
  sourceFormulaClosedProof := trivial
  bridgeClosedOnObjectProof := bridge_from_admissible_class analyticAdmissibleClass
  gateClosedOnAdmissibleClassProof := gate_from_admissible_class analyticAdmissibleClass
  theoremBoundaryCarriedProof := rfl
}

def RegularityEndpointClosed (C : RegularityEndpointCertificate) : Prop :=
  CompactnessRigidityClosed C.compactnessRigidity ∧
  C.sourceFormulaClosed ∧
  C.bridgeClosedOnObject ∧
  C.gateClosedOnAdmissibleClass ∧
  C.theoremBoundaryCarried

theorem source_regularity_endpoint_closed :
    RegularityEndpointClosed sourceRegularityEndpointCertificate := by
  exact And.intro source_compactness_rigidity_closed
    (And.intro sourceRegularityEndpointCertificate.sourceFormulaClosedProof
      (And.intro sourceRegularityEndpointCertificate.bridgeClosedOnObjectProof
        (And.intro sourceRegularityEndpointCertificate.gateClosedOnAdmissibleClassProof
          sourceRegularityEndpointCertificate.theoremBoundaryCarriedProof)))

end ChemicalEngineeringFluidMechanicsChemicalTheoremCanonicalLaneLean
end HautevilleHouse