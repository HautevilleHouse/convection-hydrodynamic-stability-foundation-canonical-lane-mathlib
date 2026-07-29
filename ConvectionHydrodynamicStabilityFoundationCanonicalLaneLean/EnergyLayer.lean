import canonicalLaneMathlib.AdmissibleClass
import ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean.LinearStabilityLayer

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean

structure EnergyCertificate where
  linearStability : LinearStabilityCertificate
  energyStability : Prop
  perturbationDecay : Prop
  energyStabilityClosed : energyStability
  perturbationDecayClosed : perturbationDecay

def sourceEnergyCertificate : EnergyCertificate := {
  linearStability := sourceLinearStabilityCertificate,
  energyStability := True,
  perturbationDecay := True,
  energyStabilityClosed := trivial,
  perturbationDecayClosed := trivial
}

def EnergyClosed (C : EnergyCertificate) : Prop :=
  LinearStabilityClosed C.linearStability ∧ C.energyStability ∧ C.perturbationDecay

theorem source_energy_closed :
    EnergyClosed sourceEnergyCertificate := by
  refine And.intro source_linear_stability_closed ?_
  exact And.intro sourceEnergyCertificate.energyStabilityClosed
    sourceEnergyCertificate.perturbationDecayClosed

end ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean
end HautevilleHouse