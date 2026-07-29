import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

structure HydroDynamicOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  transport : VectorField → VectorField
  buoyancy : VectorField → ScalarField → VectorField
  pressureProjection : VectorField → VectorField
  pressureProjectionIdempotent : ∀ u, pressureProjection (pressureProjection u) = pressureProjection u

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

def primitiveOperators : HydroDynamicOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  transport := fun _ => zeroVectorField
  buoyancy := fun _ _ => zeroVectorField
  pressureProjection := fun u => u
  pressureProjectionIdempotent := by intro u; rfl
}

structure HydroDynamicFlow where
  velocity : VectorField
  temperature : ScalarField
  pressure : ScalarField
  viscosity : ℝ
  thermalDiffusivity : ℝ
  thermalExpansionCoeff : ℝ
  gravity : ℝ
  operators : HydroDynamicOperators

def primitiveFlow : HydroDynamicFlow := {
  velocity := zeroVectorField
  temperature := zeroScalarField
  pressure := zeroScalarField
  viscosity := 1
  thermalDiffusivity := 1
  thermalExpansionCoeff := 1
  gravity := 1
  operators := primitiveOperators
}

def Incompressible (F : HydroDynamicFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def BoussinesqBalance (F : HydroDynamicFlow) : Prop :=
  F.operators.buoyancy F.velocity F.temperature = F.operators.gradient F.temperature

def PressureProjected (F : HydroDynamicFlow) : Prop :=
  F.operators.pressureProjection F.velocity = F.velocity

def ConvectionEquationsClosed (F : HydroDynamicFlow) : Prop :=
  Incompressible F ∧ BoussinesqBalance F ∧ PressureProjected F

theorem primitive_flow_incompressible_checked : Incompressible primitiveFlow := by
  rfl

theorem primitive_flow_boussinesq_balance_checked : BoussinesqBalance primitiveFlow := by
  rfl

theorem primitive_flow_pressure_projected_checked : PressureProjected primitiveFlow := by
  rfl

theorem primitive_flow_equations_closed_checked : ConvectionEquationsClosed primitiveFlow := by
  exact And.intro primitive_flow_incompressible_checked
    (And.intro primitive_flow_boussinesq_balance_checked primitive_flow_pressure_projected_checked)

end ConvectionHydrodynamicStabilityFoundationCanonicalLaneLean
end HautevilleHouse
