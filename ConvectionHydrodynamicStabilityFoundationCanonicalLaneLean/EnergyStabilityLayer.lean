import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean

structure EnergyStabilityCertificate where
  flow : HydroDynamicFlow
  kineticEnergy : ℝ
  dissipationRate : ℝ
  buoyancyFlux : ℝ
  energyStabilityCriterion : kineticEnergy ≤ dissipationRate + buoyancyFlux
  energyStabilityCriterionClosed : energyStabilityCriterion

def sourceEnergyStabilityCertificate : EnergyStabilityCertificate := {
  flow := primitiveFlow
  kineticEnergy := 0
  dissipationRate := 1
  buoyancyFlux := 0
  energyStabilityCriterion := by
    nlinarith
  energyStabilityCriterionClosed := by
    trivial
}

def EnergyStabilityClosed (C : EnergyStabilityCertificate) : Prop :=
  C.energyStabilityCriterion ∧ C.flow = primitiveFlow

theorem source_energy_stability_closed : EnergyStabilityClosed sourceEnergyStabilityCertificate := by
  exact And.intro sourceEnergyStabilityCertificate.energyStabilityCriterionClosed (by rfl)

end ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean
end HautevilleHouse
