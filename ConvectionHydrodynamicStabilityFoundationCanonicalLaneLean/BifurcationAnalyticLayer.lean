import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean

structure BifurcationAnalyticCertificate where
  operator : LinearStabilityOperator
  criticalRa : ℝ
  bifurcationType : String
  hopfFrequency : ℝ
  bifurcationThreshold : ℝ
  criticalRaPositive : criticalRa > 0
  bifurcationTypeRecognized : bifurcationType = "steady" ∨ bifurcationType = "hopf"
  hopfFrequencyNonnegative : hopfFrequency ≥ 0
  bifurcationThresholdPositive : bifurcationThreshold > 0

def trivialBifurcationAnalyticCertificate : BifurcationAnalyticCertificate := {
  operator := trivialLinearStabilityOperator
  criticalRa := 1
  bifurcationType := "steady"
  hopfFrequency := 0
  bifurcationThreshold := 1
  criticalRaPositive := by norm_num
  bifurcationTypeRecognized := Or.inl rfl
  hopfFrequencyNonnegative := by norm_num
  bifurcationThresholdPositive := by norm_num
}

def BifurcationAnalyticClosed (C : BifurcationAnalyticCertificate) : Prop :=
  C.criticalRaPositive ∧ C.bifurcationTypeRecognized ∧ C.hopfFrequencyNonnegative ∧ C.bifurcationThresholdPositive

theorem trivial_bifurcation_analytic_closed : BifurcationAnalyticClosed trivialBifurcationAnalyticCertificate := by
  exact And.intro trivialBifurcationAnalyticCertificate.criticalRaPositive
    (And.intro trivialBifurcationAnalyticCertificate.bifurcationTypeRecognized
      (And.intro trivialBifurcationAnalyticCertificate.hopfFrequencyNonnegative
        trivialBifurcationAnalyticCertificate.bifurcationThresholdPositive))

end ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean
end HautevilleHouse
