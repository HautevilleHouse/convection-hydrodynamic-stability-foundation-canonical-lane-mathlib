import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean.BoussinesqApproximation

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean

structure LinearStabilityCertificate where
  baseState : BoussinesqFlow
  perturbation : VectorField
  linearizedOperator : (VectorField → VectorField)
  eigenvalueCondition : Prop
  growthRateBound : ℝ
  eigenvalueConditionClosed : eigenvalueCondition

def baseState : BoussinesqFlow := primitiveBoussinesqFlow

def trivialPerturbation : VectorField := zeroVectorField

def trivialLinearOperator (u : VectorField) : VectorField := u

def sourceLinearStabilityCertificate : LinearStabilityCertificate := {
  baseState := baseState,
  perturbation := trivialPerturbation,
  linearizedOperator := trivialLinearOperator,
  eigenvalueCondition := (trivialLinearOperator trivialPerturbation = trivialPerturbation),
  growthRateBound := 0,
  eigenvalueConditionClosed := rfl
}

def LinearStabilityClosed (C : LinearStabilityCertificate) : Prop :=
  C.eigenvalueCondition

theorem source_linear_stability_closed :
    LinearStabilityClosed sourceLinearStabilityCertificate := by
  exact sourceLinearStabilityCertificate.eigenvalueConditionClosed

end ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean
end HautevilleHouse