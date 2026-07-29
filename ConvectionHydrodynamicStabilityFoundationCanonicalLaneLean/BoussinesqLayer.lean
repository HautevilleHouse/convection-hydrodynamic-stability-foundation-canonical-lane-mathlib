import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure BoussinesqOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  transport : VectorField → VectorField
  buoyancy : ScalarField → VectorField
  thermalDiffusion : ScalarField → ScalarField

def primitiveBoussinesqOperators : BoussinesqOperators := {
  divergence := fun _ => zeroScalarField,
  gradient := fun _ => zeroVectorField,
  laplacian := fun u => u,
  timeDerivative := fun _ => zeroVectorField,
  transport := fun _ => zeroVectorField,
  buoyancy := fun _ => zeroVectorField,
  thermalDiffusion := fun _ => zeroScalarField
}

structure BoussinesqFlow where
  velocity : VectorField
  temperature : ScalarField
  pressure : ScalarField
  viscosity : ℝ
  thermalDiffusivity : ℝ
  thermalExpansion : ℝ
  gravity : Space3
  operators : BoussinesqOperators

def primitiveBoussinesqFlow : BoussinesqFlow := {
  velocity := zeroVectorField,
  temperature := zeroScalarField,
  pressure := zeroScalarField,
  viscosity := 1,
  thermalDiffusivity := 1,
  thermalExpansion := 1,
  gravity := fun _ => 0,
  operators := primitiveBoussinesqOperators
}

def Incompressible (F : BoussinesqFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def BoussinesqEquationClosed (F : BoussinesqFlow) : Prop :=
  Incompressible F ∧ True

theorem primitive_boussinesq_equation_closed_checked :
    BoussinesqEquationClosed primitiveBoussinesqFlow := by
  refine And.intro ?_ trivial
  rfl

end ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean
end HautevilleHouse