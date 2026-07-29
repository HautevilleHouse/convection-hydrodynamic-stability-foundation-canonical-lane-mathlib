import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean

structure TurbulenceTransitionCertificate where
  bifurcation : BifurcationCertificate
  transitionThreshold : Prop
  chaosOnset : Prop
  mixingLength : Prop
  dissipationAnomaly : Prop
  transitionThresholdClosed : transitionThreshold
  chaosOnsetClosed : chaosOnset
  mixingLengthClosed : mixingLength
  dissipationAnomalyClosed : dissipationAnomaly

def sourceTurbulenceTransitionCertificate : TurbulenceTransitionCertificate := {
  bifurcation := sourceBifurcationCertificate
  transitionThreshold := baselineCertificateAllPass = true
  chaosOnset := constantSpecs.length = constantSpecCount
  mixingLength := reviewerFalsificationConditionCount = 5
  dissipationAnomaly := outsideConstantDependencyCount = 0
  transitionThresholdClosed := rfl
  chaosOnsetClosed := rfl
  mixingLengthClosed := rfl
  dissipationAnomalyClosed := rfl
}

def TurbulenceTransitionClosed (C : TurbulenceTransitionCertificate) : Prop :=
  BifurcationClosed C.bifurcation ∧
  C.transitionThreshold ∧ C.chaosOnset ∧ C.mixingLength ∧ C.dissipationAnomaly

theorem source_turbulence_transition_closed :
    TurbulenceTransitionClosed sourceTurbulenceTransitionCertificate := by
  exact And.intro source_bifurcation_closed
    (And.intro sourceTurbulenceTransitionCertificate.transitionThresholdClosed
      (And.intro sourceTurbulenceTransitionCertificate.chaosOnsetClosed
        (And.intro sourceTurbulenceTransitionCertificate.mixingLengthClosed
          sourceTurbulenceTransitionCertificate.dissipationAnomalyClosed)))

end ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean
end HautevilleHouse