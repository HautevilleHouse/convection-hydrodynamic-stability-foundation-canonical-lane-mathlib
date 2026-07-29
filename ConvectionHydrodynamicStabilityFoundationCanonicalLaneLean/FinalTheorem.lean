import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean.BridgeLemmas
import HautevilleHouse.ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean.GateLemmas

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean

def ConstrainedHydrodynamicClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_hydrodynamic_endgame (A : AdmissibleClass) :
    ConstrainedHydrodynamicClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean
end HautevilleHouse