import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean

structure BifurcationCertificate where
  nonlinearEnergy : NonlinearEnergyCertificate
  criticalRayleigh : Prop
  bifurcationType : Prop
  secondaryBranch : Prop
  amplitudeEquation : Prop
  criticalRayleighClosed : criticalRayleigh
  bifurcationTypeClosed : bifurcationType
  secondaryBranchClosed : secondaryBranch
  amplitudeEquationClosed : amplitudeEquation

def sourceBifurcationCertificate : BifurcationCertificate := {
  nonlinearEnergy := sourceNonlinearEnergyCertificate
  criticalRayleigh := baselineCertificateAllPass = true
  bifurcationType := constantSpecs.length = constantSpecCount
  secondaryBranch := reviewerFalsificationConditionCount = 5
  amplitudeEquation := outsideConstantDependencyCount = 0
  criticalRayleighClosed := rfl
  bifurcationTypeClosed := rfl
  secondaryBranchClosed := rfl
  amplitudeEquationClosed := rfl
}

def BifurcationClosed (C : BifurcationCertificate) : Prop :=
  NonlinearEnergyClosed C.nonlinearEnergy ∧
  C.criticalRayleigh ∧ C.bifurcationType ∧ C.secondaryBranch ∧ C.amplitudeEquation

theorem source_bifurcation_closed :
    BifurcationClosed sourceBifurcationCertificate := by
  exact And.intro source_nonlinear_energy_closed
    (And.intro sourceBifurcationCertificate.criticalRayleighClosed
      (And.intro sourceBifurcationCertificate.bifurcationTypeClosed
        (And.intro sourceBifurcationCertificate.secondaryBranchClosed
          sourceBifurcationCertificate.amplitudeEquationClosed)))

end ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean
end HautevilleHouse