import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean

structure LinearStabilityOperator where
  baseState : HydroDynamicFlow
  perturbation : VectorField
  linearizedOperator : VectorField → VectorField
  eigenvalue : ℂ
  growthRate : ℝ
  criticalThreshold : ℝ

def trivialBaseState : HydroDynamicFlow := primitiveFlow

def neutralOperator (v : VectorField) : VectorField := v

def trivialLinearStabilityOperator : LinearStabilityOperator := {
  baseState := trivialBaseState
  perturbation := zeroVectorField
  linearizedOperator := neutralOperator
  eigenvalue := 0
  growthRate := 0
  criticalThreshold := 0
}

def StabilityMargin (L : LinearStabilityOperator) : ℝ :=
  L.criticalThreshold - L.growthRate

def MarginNonnegative (L : LinearStabilityOperator) : Prop :=
  StabilityMargin L ≥ 0

def LinearStabilityClosed (L : LinearStabilityOperator) : Prop :=
  MarginNonnegative L ∧ L.criticalThreshold > 0

theorem trivial_linear_stability_closed_checked : LinearStabilityClosed trivialLinearStabilityOperator := by
  unfold LinearStabilityClosed MarginNonnegative StabilityMargin trivialLinearStabilityOperator
  simp

end ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean
end HautevilleHouse
